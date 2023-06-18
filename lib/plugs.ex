defmodule Tex.Plugs do
  defmacro __using__(_opts) do
    quote do
      require Logger

      if Application.get_env(:tex, :scheme, :http) == :https do
        Logger.info("Loading SSL plugs")
        plug(Plug.SSL)
      else
        Logger.info("Loading non-SSL plugs")
      end

      plug(Plug.Logger)
      plug(Plug.RequestId)
      plug(Plug.Parsers, parsers: [:urlencoded])
      plug(:match)
      plug(:dispatch)
    end
  end
end
