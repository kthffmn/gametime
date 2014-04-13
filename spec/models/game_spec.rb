require 'spec_helper'

describe Game do
  subject(:game) {FactoryGirl.create(:game)}
  its "valid with a two names, instructions, example script, max, min, and age group booleans" do
    expect(game).to be_valid
  end
end
