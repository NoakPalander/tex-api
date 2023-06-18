defmodule Native.Task do
  @spec async(list(String.t()), fun(), fun()) :: {:ok, pid(), port()} | {:error, String.t()}
  def async([path | args], on_exit \\ nil, on_message \\ nil) do
    case System.find_executable(path) do
      nil ->
        {:error, "Invalid executable"}

      exe ->
        port = Port.open({:spawn_executable, exe}, [:binary, :exit_status, args: args])

        {:ok,
         {Task.async(fn ->
            Port.open({:spawn_executable, exe}, [:binary, :exit_status, args: args])
            |> listener(on_exit, on_message)
          end), port}}
    end
  end

  @spec await({pid(), port()}, timeout :: integer()) :: term()
  def await({task, port}, timeout \\ 5000) do
    Port.close(port)
    Task.await(task, timeout)
  end

  defp listener(port, on_exit, on_message) do
    receive do
      {^port, {:data, message}} ->
        case invoke(on_message, [String.trim(message)]) do
          {:ok, data} -> data
          :continue -> listener(port, on_exit, on_message)
        end

      {^port, {:exit_status, status}} ->
        invoke(on_exit, [status])
    end
  end

  defp invoke(nil, _args), do: nil
  defp invoke(f, args), do: apply(f, args)
end
