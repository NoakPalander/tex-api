defmodule Tex.Application do
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: Application.fetch_env!(:tex, :scheme), plug: Tex.Router, options: options()}
    ]

    opts = [strategy: :one_for_one, name: Tex.Supervisor]

    Logger.info("Starting server on port: #{port()}!")
    Supervisor.start_link(children, opts)
  end

  defp port(), do: Application.fetch_env!(:tex, :port)
  defp options(), do: Application.fetch_env!(:tex, :options)
end
