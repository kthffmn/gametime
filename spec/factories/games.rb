# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :name_one, class: Name do |n|
    n.content "Middle-ish Popularity"
    n.popularity 3
  end

  factory :name_two, class: Name do |n|
    n.content "More Popular"
    n.popularity 4
  end

  factory :popular_name, class: Name do |n|
    n.content "Same popularity"
    n.popularity 3
  end

  factory :zero_popularity_name, class: Name do |n|
    n.content "zero popularity"
    n.popularity 0
  end

  factory :game do |g|
    g.description "Get into a circle, with one person in the middle. Sing bunny bunny, etc."
    g.example "Bunny bunny bunny toky toky toky"
    g.maximum 20
    g.minimum 6
    g.early_childhood true
    g.elementary_school true
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

  factory :second_game, class: Game do |g|
    g.description "This is a totally different kind of game. Promise."
    g.example "Bunny bunny bunny toky toky toky"
    g.maximum 20
    g.minimum 6
    g.early_childhood true
    g.elementary_school true
    g.middle_school false
    g.high_school true
    g.college true
    g.adulthood false
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

  factory :invalid_game_max, class: Game do |g|
    g.description "Get into a circle, with one person in the middle. Sing bunny bunny, etc."
    g.example "Bunny bunny bunny toky toky toky"
    g.maximum 1
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

  factory :invalid_game_names, class: Game do |g|
    g.description "Get into a circle, with one person in the middle. Sing bunny bunny, etc."
    g.example "Bunny bunny bunny toky toky toky"
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
      game.names << FactoryGirl.build(:popular_name)
    end
    g.after(:create) do |game|
      game.names.each do |name| 
        name.save!
      end
    end
  end

  factory :no_name, class: Game do |g|
    g.description "Get into a circle, with one person in the middle. Sing bunny bunny, etc."
    g.example "Bunny bunny bunny toky toky toky"
    g.maximum 20
    g.minimum 6
    g.early_childhood false
    g.elementary_school false
    g.middle_school true
    g.high_school true
    g.college true
    g.adulthood true
  end

  factory :short_description, class: Game do |g|
    g.description "circle"
    g.example "Bunny bunny bunny toky toky toky"
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

  factory :long_description, class: Game do |g|
    g.description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec elementum malesuada tortor et vulputate. Fusce diam elit, vulputate ut viverra ut, vestibulum in leo. Nullam a turpis elit. Sed pulvinar magna velit, at facilisis nisl tempus sollicitudin. Morbi sit amet tortor quis magna hendrerit tempor bibendum sed risus. Sed hendrerit, justo at tincidunt consequat, lacus nisl egestas eros, sed semper purus tellus id libero. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec pellentesque purus eu mauris malesuada volutpat. Nam egestas dui eu mauris aliquet, vel bibendum elit fringilla. Donec tempus odio quam, quis lacinia mauris tincidunt sed. Vivamus id lectus in mauris vestibulum congue convallis ac est. Duis faucibus risus at metus dignissim, ut lacinia neque tristique. Mauris arcu ipsum, consequat in rutrum pellentesque, fermentum ornare nisi. Cras congue dolor quis justo mollis egestas. Nullam eget vulputate leo. Phasellus justo purus volutpat."
    g.example "Bunny bunny bunny toky toky toky"
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

  factory :no_age_group, class: Game do |g|
    g.description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec elementum malesuada tortor et vulputate. Fusce diam elit, vulputate ut viverra ut, vestibulum in leo. Nullam a turpis elit. Sed pulvinar magna velit, at facilisis nisl tempus sollicitudin. Morbi sit amet tortor quis magna hendrerit tempor bibendum sed risus. Sed hendrerit, justo at tincidunt consequat, lacus nisl egestas eros, sed semper purus tellus id libero. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec pellentesque purus eu mauris malesuada volutpat. Nam egestas dui eu mauris aliquet, vel bibendum elit fringilla. Donec tempus odio quam, quis lacinia mauris tincidunt sed. Vivamus id lectus in mauris vestibulum congue convallis ac est. Duis faucibus risus at metus dignissim, ut lacinia neque tristique. Mauris arcu ipsum, consequat in rutrum pellentesque, fermentum ornare nisi. Cras congue dolor quis justo mollis egestas. Nullam eget vulputate leo. Phasellus justo purus volutpat."
    g.example "Bunny bunny bunny toky toky toky"
    g.maximum 20
    g.minimum 6
    g.early_childhood false
    g.elementary_school false
    g.middle_school false
    g.high_school false
    g.college false
    g.adulthood false
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

  factory :zero_pop_value, class: Game do |g|
    g.description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec elementum malesuada tortor et vulputate. Fusce diam elit, vulputate ut viverra ut, vestibulum in leo. Nullam a turpis elit. Sed pulvinar magna velit, at facilisis nisl tempus sollicitudin. Morbi sit amet tortor quis magna hendrerit tempor bibendum sed risus. Sed hendrerit, justo at tincidunt consequat, lacus nisl egestas eros, sed semper purus tellus id libero. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec pellentesque purus eu mauris malesuada volutpat. Nam egestas dui eu mauris aliquet, vel bibendum elit fringilla. Donec tempus odio quam, quis lacinia mauris tincidunt sed. Vivamus id lectus in mauris vestibulum congue convallis ac est. Duis faucibus risus at metus dignissim, ut lacinia neque tristique. Mauris arcu ipsum, consequat in rutrum pellentesque, fermentum ornare nisi. Cras congue dolor quis justo mollis egestas. Nullam eget vulputate leo. Phasellus justo purus volutpat."
    g.example "Bunny bunny bunny toky toky toky"
    g.maximum 20
    g.minimum 6
    g.early_childhood false
    g.elementary_school false
    g.middle_school false
    g.high_school false
    g.college false
    g.adulthood false
    g.after(:build) do |game|
      game.names << FactoryGirl.build(:name_one)
      game.names << FactoryGirl.build(:zero_popularity_name)
    end
    g.after(:create) do |game|
      game.names.each do |name| 
        name.save!
      end
    end
  end
end