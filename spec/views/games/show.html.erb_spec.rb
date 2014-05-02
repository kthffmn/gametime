require 'spec_helper'

describe "games/show" do
  before(:each) do
    @game = assign(:game, stub_model(Game,
      :description => "descriptionss",
      :maximum => 50,
      :minimum => 10,
      :early_childhood => false,
      :elementary_school => false,
      :middle_school => true,
      :high_school => false,
      :college => false,
      :adulthood => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/descriptionss/)
    rendered.should match(/50/)
    rendered.should match(/10/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/true/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
