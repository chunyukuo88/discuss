defmodule DiscussWeb.Topic do
  use DiscussWeb, :model

  schema "topics" do
    field :title, :string
  end
end