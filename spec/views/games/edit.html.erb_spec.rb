require 'spec_helper'

describe "games/edit" do
  before(:each) do
    @game = FactoryGirl.create(:game)
    @games = [FactoryGirl.create(:second_game)]
  end

  it "renders the edit game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", game_path(@game), "post" do
    end
  end
end
