defmodule ParamsValidation.RouterTester do
  use Plug.Router
  import ParamsValidation
  plug(ParamsValidation, log_errors?: true)

  get "/get-with-query-param/:query_thing", expect(path_params: %{thing: :string}) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(query_thing))
  end

  post "/post-with-query-and-simple-body/:query_thing", expect(body_params: %{body_thing: :string}, path_params: %{query_thing: :string}) do
    return_thing = %{query: query_thing, body: conn.body_params.body_thing}
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(return_thing))
  end

  post "/post-with-query-and-complex-body/:query_thing", expect(body_params: %{body_thing: ConversationServerUser}, path_params: %{query_thing: :string}) do
    return_thing = %{query: query_thing, body: conn.body_params.body_thing}
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(return_thing))
  end

  match _ do
    send_resp(conn, 400, "oops")
  end
end
