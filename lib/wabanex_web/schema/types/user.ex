defmodule WabanexWeb.Schema.Types.User do
  use Absinthe.Schema.Notation

  @desc "Logic user representations"
  object :user do
    field :id, non_null(:uuid4)
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :trainings, list_of(:training)
  end

  input_object :create_user_input do
    field :name, non_null(:string), description: "Users Name"
    field :email, non_null(:string), description: "Users email"
    field :password, non_null(:string), description: "Users passwords"
  end
end