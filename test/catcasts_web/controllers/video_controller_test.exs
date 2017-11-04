defmodule CatcastsWeb.VideoControllerTest do
  use CatcastsWeb.ConnCase

  alias Catcasts.Videos

  @create_attrs %{duration: "some duration", thumbnail: "some thumbnail", title: "some title", video_id: "some video_id", view_count: 42}
  @update_attrs %{duration: "some updated duration", thumbnail: "some updated thumbnail", title: "some updated title", video_id: "some updated video_id", view_count: 43}
  @invalid_attrs %{duration: nil, thumbnail: nil, title: nil, video_id: nil, view_count: nil}

  def fixture(:video) do
    {:ok, video} = Videos.create_video(@create_attrs)
    video
  end

  describe "index" do
    test "lists all videos", %{conn: conn} do
      conn = get conn, video_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Videos"
    end
  end

  describe "new video" do
    test "renders form", %{conn: conn} do
      conn = get conn, video_path(conn, :new)
      assert html_response(conn, 200) =~ "Add a video"
    end
  end

  describe "create video" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, video_path(conn, :create), video: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == video_path(conn, :show, id)

      conn = get conn, video_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Video"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, video_path(conn, :create), video: @invalid_attrs
      assert html_response(conn, 200) =~ "Add a video"
    end
  end

  describe "delete video" do
    setup [:create_video]

    test "deletes chosen video", %{conn: conn, video: video} do
      conn = delete conn, video_path(conn, :delete, video)
      assert redirected_to(conn) == video_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, video_path(conn, :show, video)
      end
    end
  end

  defp create_video(_) do
    video = fixture(:video)
    {:ok, video: video}
  end
end
