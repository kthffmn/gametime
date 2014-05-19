require 'spec_helper'

describe "games/index" do
  before(:each) do
    @games = [FactoryGirl.create(:game), FactoryGirl.create(:second_game)]
  end

  it "renders a list of games" do
    render
    rendered.should match(/Get into a circle, with one person in the middle. Sing bunny bunny, etc./)
    rendered.should match(/This is a totally different kind of game. Promise./)
  end
end
