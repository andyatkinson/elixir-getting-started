defmodule Hw.PageController do
  use Hw.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
