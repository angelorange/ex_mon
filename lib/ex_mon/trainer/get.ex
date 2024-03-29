defmodule ExMon.Trainer.Get do
  alias ExMon.{Trainer, Repo}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "invalid id format"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Trainer, uuid) do
      nil -> {:error, "trainer not found"}
      trainer -> {:ok, Repo.preload(trainer, :pokemon)}
    end
  end
end
