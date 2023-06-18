import Config

config :tex,
  port: System.fetch_env!("TEX_PORT") |> String.to_integer(),
  scheme: :http,
  options: [
    port: System.fetch_env!("TEX_PORT") |> String.to_integer(),
    otp_app: :tex,
  ]
