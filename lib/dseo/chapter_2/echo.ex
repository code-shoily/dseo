defmodule DSEO.Chapter2.Echo do
  alias __MODULE__

  def go do
    pid = spawn(Echo, :loop, [])
    pid |> send({self(), :hello})

    receive do
      {_, msg} ->
        IO.puts("#{msg}")
    end
    pid |> send(:stop)
  end

  def loop do
    receive do
      {from, msg} ->
        from |> send({self(), msg})
        loop()
      :stop -> :ok
    end
  end
end
