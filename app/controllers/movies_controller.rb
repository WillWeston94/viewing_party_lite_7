# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    if params[:query].present?
      @movies_facade = MoviesFacade.new(params[:query])
    elsif params[:top_rated]
      @movies_facade = MoviesFacade.new(nil, true)
    else
      redirect_to discover_user_path(@user) and return
    end

    return unless @movies_facade.movies.empty?

    redirect_to discover_user_path(@user), alert: 'No movies found.'
  end

  def show
    @user = User.find(params[:user_id])
    MovieDbService.new
    @movie = MovieFacade.movie_details(params[:id])
    @cast = MovieFacade.movie_cast(params[:id])
    @reviews = MovieFacade.movie_reviews(params[:id])
  end
end
