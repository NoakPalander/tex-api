import Config

config :tex,
  port: 3000,
  scheme: :http,
  options: [
    port: 3000,
    otp_app: :tex,
  ]

config :porcelain,
  driver: Porcelain.Driver.Basic
