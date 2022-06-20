defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias Discuss.Repo
  alias DiscussWeb.Topic

  def index(conn, _params) do
    topics = Repo.all(Topic) #in iex, don't forget the `Web`:  Discuss.Repo.all(DiscussWeb.Topic)
    render conn, "index.html.eex", topics: topics
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)
    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "w00t! You created a new topic.")
        |> redirect(to: Topic.topic_path(conn, :index))

      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
