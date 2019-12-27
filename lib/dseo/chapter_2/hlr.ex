defmodule DSEO.Chapter2.HLR do
  @ms :msisdn2pid
  @id :pid2msisdn
  @opts [:public, :named_table]

  def new do
    [@ms, @id] |> Enum.each(&:ets.new(&1, @opts))
  end

  def attach(ms) do
    :ets.insert(@ms, {ms, self()})
    :ets.insert(@id, {self(), ms})
  end

  def detach() do
    case :ets.lookup(@id, self()) do
      [{pid, ms}] ->
        :ets.delete(@id, pid)
        :ets.delete(@ms, ms)

      _ ->
        :ok
    end
  end

  def lookup_id(ms) do
    case :ets.lookup(@ms, ms) do
      [] -> {:error, :invalid}
      [{_ms, pid}] -> {:ok, pid}
    end
  end

  def lookup_ms(id) do
    case :ets.lookup(@id, id) do
      [] -> {:error, :invalid}
      [{_pid, ms}] -> {:ok, ms}
    end
  end
end
