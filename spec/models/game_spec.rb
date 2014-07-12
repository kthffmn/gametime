require 'spec_helper'

describe Game do
  subject(:game) {FactoryGirl.create(:game)}
  subject(:second_game) {FactoryGirl.create(:second_game)}
  subject(:invalid_num_game) {FactoryGirl.build(:invalid_game_max)}
  subject(:invalid_name_game) {FactoryGirl.build(:invalid_game_names)}
  subject(:no_name) {FactoryGirl.build(:no_name)}
  subject(:short_description) {FactoryGirl.build(:short_description)}
  subject(:long_description) {FactoryGirl.build(:long_description)}
  subject(:no_age_group) {FactoryGirl.build(:no_age_group)}
  subject(:zero_pop_value) {FactoryGirl.build(:zero_pop_value)}

  its "valid with a two names, instructions, example script, max, min, and age group booleans" do
    expect(game).to be_valid
  end

  its "invalid when the max num of players exceeds the min" do
    expect(invalid_num_game).to_not be_valid
  end

  its "invalid without at least one name" do
    expect(no_name).to_not be_valid
  end

  its "invalid with a description less than 10 characters" do
    expect(short_description).to_not be_valid
  end

  its "invalid with a description more than 1000 characters" do
    expect(long_description).to_not be_valid
  end

  its "invalid without an age group selected" do
    expect(no_age_group).to_not be_valid
  end

  its "invalid with two names but one doesn't have a popularity value" do
    expect(zero_pop_value).to_not be_valid
  end

  its "method to see if a game has more than one name works" do
    expect(game.multiple_names?).to be(true)
  end

  its "method to find the most popular name results in the most popular name" do
    expect(game.most_popular_name.content).to eq("More Popular")
  end

  its "method to find the less popular name results in the less name" do
    expect(game.less_popular_names.first.content).to eq("Middle-ish Popularity")
  end

  its "method to see if the exercise/game is appropriate for all ages results in true" do
    expect(game.all_ages?).to be(true)
  end

  its "method to see if the exercise/game is appropriate for all ages results in false" do
    expect(second_game.all_ages?).to be(false)
  end

end
