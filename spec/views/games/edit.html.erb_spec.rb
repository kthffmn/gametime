require 'spec_helper'

describe "games/edit" do
  before(:each) do
    @game = assign(:game, stub_model(Game,
      :instructions => "MyString",
      :maximum => 1,
      :minimum => 1,
      :early_childhood => false,
      :elementary_school => false,
      :middle_school => false,
      :high_school => false,
      :college => false,
      :adulthood => false
    ))
  end

  it "renders the edit game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", game_path(@game), "post" do
      assert_select "input#game_instructions[name=?]", "game[instructions]"
      assert_select "input#game_maximum[name=?]", "game[maximum]"
      assert_select "input#game_minimum[name=?]", "game[minimum]"
      assert_select "input#game_early_childhood[name=?]", "game[early_childhood]"
      assert_select "input#game_elementary_school[name=?]", "game[elementary_school]"
      assert_select "input#game_middle_school[name=?]", "game[middle_school]"
      assert_select "input#game_high_school[name=?]", "game[high_school]"
      assert_select "input#game_college[name=?]", "game[college]"
      assert_select "input#game_adulthood[name=?]", "game[adulthood]"
    end
  end
end
