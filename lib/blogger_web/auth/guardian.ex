defmodule BloggerWeb.Auth.Guardian do
  use Guardian, otp_app: :blogger

  alias Blogger.{Error, User}
  alias Blogger.Users.Get

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> Get.by_id()
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- Get.by_id(user_id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Por favor verifique suas credenciais")}
      error -> error
    end
  end

  def authenticate,
    do: {:error, Error.build(:bad_request, "Invalido ou parametros não fornecido")}
end
