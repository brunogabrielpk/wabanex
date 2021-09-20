defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  user_id = "5f9df11a-ce7c-45a6-ab74-7639a770a27f"

  describe "users queries" do
    test "when a valid id is given, returns the use", %{conn: conn} do
      params = %{email: "poke8@gmail.com", name: "poke8", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "poke8@gmail.com",
            "name" => "poke8"
          }
        }
      }

      assert expected_response == response
    end
  end

  describe "users mutations" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation{
          createUser(input: {
            name: "poke9", email: "poke9@gmail.com", password: "123456"
          }){
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "createUser" => %{"id" => _id, "name" => "poke9"}
               }
             } = response
    end
  end
end
