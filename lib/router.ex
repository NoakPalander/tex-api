defmodule Tex.Router do
  use Plug.Router
  use Tex.Plugs

  get "/png" do
    path =
      Tex.Core.process(
        Map.fetch!(conn.params, "content") |> String.replace("\"", ""),
        border: Map.get(conn.params, "border"),
        size: Map.get(conn.params, "size"),
        color: Map.get(conn.params, "color"),
        background: Map.get(conn.params, "background")
      )

    send_file(conn, 200, path)
  end
end
