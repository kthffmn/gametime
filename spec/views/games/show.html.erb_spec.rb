require 'spec_helper'

describe "games/show" do
  before(:each) do
    @game = FactoryGirl.create(:game)
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Get into a circle, with one person in the middle. Sing bunny bunny, etc./)
  end
end
