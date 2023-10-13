class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @viewing_parties = @user.viewing_parties
    @movie_details = @viewing_parties.map do |party|
      MovieFacade.details(party.movie_id)
    end
  end
  
  def new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def discover
    @user = User.find(params[:id])
    @movies_facade = MoviesFacade.new(params[:query], params[:top_rated])
  end

  private

  def user_params
    params.permit(:name, :email)
  end

  def invited_friends(party)
    User.joins(:invited_parties).where(viewing_parties: { movie_id: party.movie_id, is_host: false })
  end
end


