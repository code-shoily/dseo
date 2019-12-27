defmodule DSEO.Chapter2.Scratch do
  def ets_setup do
    :ets.new(:tab, [:named_table])
    :ets.insert(:tab, {:haskell, :lazy})
    :ets.insert(:tab, {:haskell, :ghci})
    :ets.insert(:tab, {:ocaml, :strict})
    :ets.insert(:tab, {:racket, :strict})
  end

  def match_ets do
    :ets.match(:tab, {:"$1", :"$0"})
    :ets.match(:tab, {:"$1", :_})
    :ets.match(:tab, {:"$1", :strict})
  end
end
