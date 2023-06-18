import Config
require Logger

Logger.info("Loading Config #{config_env()}")
import_config("#{config_env()}.exs")

config :logger, :console, metadata: [:request_id]
