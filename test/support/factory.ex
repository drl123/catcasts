defmodule Catcasts.Factory do
  use ExMachina.Ecto, repo: Catcasts.Repo

  def user_factory do
    %Catcasts.User{
      token: "ffnebyt73bich9",
      email: "batman@example.com",
      first_name: "Bruce",
      last_name: "Wayne",
      provider: "google"
    }
  end
end
