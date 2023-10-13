class ApplicationController < ActionController::Base
  def invited_friends(party)
    User.joins(:invited_parties).where(viewing_parties: { movie_id: party.movie_id, is_host: false })
  end
end
