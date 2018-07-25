defmodule ParamsValidation.Application do
  @moduledoc """
  An application module used purely for quick router testing.
  """

  use Application

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, ParamsValidation.RouterTester, [], port: 4000)
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
