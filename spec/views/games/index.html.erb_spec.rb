require 'spec_helper'

describe "games/index" do
  before(:each) do
    assign(:games, [
      stub_model(Game,
        :instructions => "Instructions",
        :maximum => 1,
        :minimum => 2,
        :early_childhood => false,
        :elementary_school => false,
        :middle_school => false,
        :high_school => false,
        :college => false,
        :adulthood => false
      ),
      stub_model(Game,
        :instructions => "Instructions",
        :maximum => 1,
        :minimum => 2,
        :early_childhood => false,
        :elementary_school => false,
        :middle_school => false,
        :high_school => false,
        :college => false,
        :adulthood => false
      )
    ])
  end

  it "renders a list of games" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Instructions".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
