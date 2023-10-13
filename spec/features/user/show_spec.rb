require "rails_helper"

RSpec.describe "User Show Page" do
  describe "As an authenticated user", :vcr do
    before :each do
      @weston = User.create(name: "Weston", email: "IMaG@thehood.com")
      @movie = MovieFacade.movie_details(100)
      @cast = MovieFacade.movie_cast(100)
      @reviews = MovieFacade.movie_reviews(100)
      @party = @weston.viewing_parties.create(movie_id: 100, date_time: "2021-08-01 01:00:00")
      @party.guests.create(name: "Weston", email: "IMaG@thehood.com")
      visit user_path(@weston)
    end

    it "I see a list of all my viewing parties" do
      expect(page).to have_content("My Viewing Parties")
      expect(page).to have_content(@movie.title)
      expect(page).to have_content(@party.date.strftime('%B %d, %Y'))
    end

    it "displays the movie image, description, host indication, and party date time" do
      expect(page).to have_css("img[src*='#{@movie.poster_path}']")
      expect(page).to have_content(@movie.description)
      expect(page).to have_content("Hosting")
      expect(page).to have_content(@party.date_time.strftime('%B %d, %Y %I:%M %p'))
    end

    describe "when the user is the host" do
      it "displays the list of invited friends" do
        expect(page).to have_content("Invited Friends")
        expect(page).to have_content(@weston.name)
      end
    end
  end
end
