defmodule ParamsValidation.RouterTester do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  import ParamsValidation

  get "/get-with-query-param/:query_thing", expect(path_params: %{thing: :string}) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(query_thing))
  end

  post "/post-with-query-and-simple-body/:query_thing",
       expect(body_params: %{body_thing: :string}, path_params: %{query_thing: :string}) do
    return_thing = %{query: query_thing, body: conn.body_params.body_thing}

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(return_thing))
  end

  post "/post-with-query-and-complex-body/:query_thing",
       expect(
         body_params: %{body_thing: ParamsValidation.EctoTypeTester},
         path_params: %{query_thing: :string}
       ) do
    body_thing = conn.body_params.body_thing
    return_thing = %{query: query_thing, body: %{a: body_thing.a, b: body_thing.b, c: body_thing.c}}

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(return_thing))
  end

  match _ do
    send_resp(conn, 400, "oops")
  end
end
