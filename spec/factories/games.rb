# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :name_one, class: Name do |n|
    n.content "Name Onesie"
    n.popularity 1
  end

  factory :name_two, class: Name do |n|
    n.content "Name Twosie"
    n.popularity 3
  end

  factory :game do |g|
    g.instructions "Get into a circle, with one person in the middle. Sing bunny bunny, etc."
    g.example_script "Bunny bunny bunny toky toky toky"
    g.maximum 20
    g.minimum 6
    g.early_childhood false
    g.elementary_school false
    g.middle_school true
    g.high_school true
    g.college true
    g.adulthood true
    g.after(:build) do |game|
      game.names << FactoryGirl.build(:name_one)
      game.names << FactoryGirl.build(:name_two)
    end
    g.after(:create) do |game|
      game.names.each do |name| 
        name.save!
      end
    end
  end

  factory :invalid_game_max, class: Name do |g|
    g.instructions "Get into a circle, with one person in the middle. Sing bunny bunny, etc."
    g.example_script "Bunny bunny bunny toky toky toky"
    g.maximum 20
    g.minimum 6
    g.early_childhood false
    g.elementary_school false
    g.middle_school true
    g.high_school true
    g.college true
    g.adulthood true
    g.after(:build) do |game|
      game.names << FactoryGirl.build(:name_one)
      game.names << FactoryGirl.build(:name_two)
    end
    g.after(:create) do |game|
      game.names.each do |name| 
        name.save!
      end
    end
  end
end

