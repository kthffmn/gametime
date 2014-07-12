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
    g.description ""
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
    g.description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum laoreet elementum leo, eu tristique leo ornare et. Praesent tempus justo rhoncus ullamcorper dignissim. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in placerat nulla. Ut dolor velit, imperdiet ut eleifend et, hendrerit vitae velit. Nunc rutrum est enim, dapibus iaculis arcu aliquet nec. In placerat quam orci, a hendrerit libero vehicula eu. Phasellus eros nisi, convallis sit amet posuere eget, dictum nec urna. Aliquam id eros luctus orci elementum venenatis.Aenean urna lacus, aliquet non posuere at, porttitor quis magna. Nullam tristique ipsum eget tempor fermentum. Ut ut ante vitae erat cursus gravida. Praesent ut malesuada libero. Curabitur luctus volutpat elit sit amet porttitor. Duis quis varius tellus, a bibendum est. Pellentesque varius justo a pulvinar aliquet. Aenean et est euismod, egestas turpis nec, faucibus mauris. Sed fermentum convallis aliquam. Vivamus porttitor lectus in laoreet egestas. Donec enim est, euismod nec sapien quis, auctor adipiscing tortor. Etiam vestibulum mauris sed sollicitudin tempus.Nullam condimentum tellus purus, a mattis eros lacinia vel. Fusce porta, nisl nec egestas dapibus, mi purus feugiat urna, pulvinar laoreet mi erat non lectus. Nullam accumsan, ipsum consectetur consequat ultricies, dui erat condimentum tellus, sit amet varius erat arcu quis ligula. Aliquam ut lacinia tortor. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Morbi a diam eu libero porta tristique non sed urna. Maecenas sagittis suscipit nunc, quis adipiscing nunc ultrices non. Praesent lacinia vulputate nunc sed pharetra. Aenean sed odio ut justo tristique egestas. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec pretium auctor tincidunt. Nunc a ante nibh.Etiam congue eleifend lectus, in vehicula odio dapibus vitae. Aliquam erat volutpat. Integer magna neque, sagittis et tortor eget, facilisis accumsan nunc. Mauris magna felis, suscipit non enim in, porttitor egestas diam. Proin vel felis vehicula mauris semper dapibus sit amet eu dui. Aliquam erat volutpat. Nulla dignissim erat in congue rhoncus. Suspendisse rhoncus dui quis massa consectetur lobortis. Phasellus pharetra tincidunt metus, mattis faucibus orci consectetur in. Nunc feugiat risus sed libero ornare vehicula. Maecenas in iaculis mi. Vivamus magna neque, mollis et eros ac, lobortis aliquam enim. Maecenas tristique dignissim orci, id aliquet risus bibendum sed. Donec diam est, facilisis vitae elementum non, ultricies vitae purus.Sed mollis lacinia sapien, sed dictum justo elementum vel. Suspendisse et posuere lacus. Nulla tincidunt blandit congue. Fusce id pulvinar nulla, at iaculis eros. In iaculis odio ac hendrerit mattis. Donec semper pellentesque posuere. Aliquam ut lectus id elit pharetra pretium.Nunc est nibh, tempus vitae libero quis, aliquet posuere lacus. Maecenas mauris nisl, venenatis sed elit id, congue volutpat eros. Vestibulum rutrum turpis sit amet justo pulvinar, quis euismod augue dictum. Vestibulum tempus nulla eu laoreet aliquet. Vivamus libero sem, pretium et libero vel, placerat bibendum libero. Phasellus eget risus id tellus fermentum euismod quis in libero. Aliquam in odio congue, fringilla purus ullamcorper, tincidunt augue. Nam vel tincidunt tortor, vehicula rhoncus elit.Vestibulum tempor, orci sit amet facilisis porttitor, elit mi sollicitudin eros, sed congue arcu neque eu metus. Proin eu velit sed libero sodales euismod id sit amet arcu. Donec eu rhoncus dui. Nam quis leo metus. Etiam facilisis sapien non purus mattis, eget adipiscing nulla convallis. Duis accumsan vitae mauris id porta. Ut quis aliquet justo, malesuada sagittis tellus. Mauris porttitor imperdiet viverra. Etiam a commodo eros.Suspendisse in nulla velit. Nam convallis dui vitae lorem iaculis, eu adipiscing ligula consectetur. Vestibulum hendrerit rhoncus ipsum pulvinar ultricies. Proin libero odio, dictum non tincidunt eu, blandit vel ante. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean ut congue neque, ut elementum tellus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In vestibulum venenatis velit at aliquet. Curabitur purus leo, porta vel nisi eget, varius elementum elit. Morbi vestibulum mauris sit amet ligula pulvinar cursus. Praesent consequat sagittis erat. Praesent sagittis sit amet nunc non gravida. Quisque varius id libero a pulvinar.Maecenas augue ligula, congue non odio feugiat, volutpat scelerisque libero. Maecenas malesuada turpis ac purus vehicula, in ornare velit cursus. Ut ullamcorper, lorem non congue mollis, lorem leo ultrices ipsum, a elementum nulla elit vitae nisl. Phasellus placerat nibh a felis varius facilisis. Nunc vitae enim a ipsum auctor blandit. Nam sodales justo libero, vitae condimentum enim laoreet et. Ut ipsum elit, ultricies a euismod quis, facilisis aliquam ante. Morbi malesuada imperdiet sed."
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