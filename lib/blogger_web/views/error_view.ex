defmodule BloggerWeb.ErrorView do
  use BloggerWeb, :view

  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Ecto.Changeset

  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("error.json", %{message: %Changeset{} = changeset}) do
    msg =
      translate_errors(changeset)
      |> Enum.map_join(", ", fn {key, val} ->
        case {key, val} do
          {:email, ["Usuário já existe"]} -> "Usuário já existe"
          {:email, _} -> ~s{"#{key}" #{val}}
          {_, _} -> ~s{"#{key}" #{val}}
        end
      end)

    %{message: msg}
  end

  def render("error.json", %{message: message}) do
    %{message: message}
  end

  def translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
