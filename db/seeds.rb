def main
  seed_tags
  add_games
  add_related_games
end

def seed_tags
  tags = ["accepting", "advancing", "agreement", "association", "audience participation", "audience suggestion", "audience warm-up", "backline", "blocking", "blue", "breaking the routine", "bulldozing", "canceling", "characters", "commenting", "concentration", "conflict", "continuation", "denial", "die", "edit", "embodying", "endowing", "endowment", "energy", "environment", "exercise", "experts", "finding the game", "focus", "format", "freezing", "fuck your fear", "gibberish", "give and take", "groundlings", "group", "guessing", "hedging", "heightening", "hip-hop", "host", "icebreakers", "ignoring", "instant trouble", "jabbertalk", "joining", "justifying", "lights edit", "limitations", "line game", "long form", "long form", "look and listen", "magnet", "mc", "monologue", "monoscene", "music", "name game", "narration", "narrative", "object work", "object work", "offer", "opening", "performance", "pimping", "pit", "platform", "props", "questions", "raising the stakes", "rap", "reincorporating", "replay", "revolving door edit", "running gag", "second city", "setup", "shelving", "short form", "sideline", "singsong", "solo", "space work", "spontaneity", "status", "status", "storytelling", "subtext", "tag out", "taking care of yourself", "third idea improv", "tilts", "time dash", "timed", "transaction scene", "transitions", "trust", "truthfulness", "ucb", "verbal wit", "waffling", "walk-through", "warm-up", "wimping", "yes and"]
  tags.each{|tag| Tag.create(:name  => tag)}
  puts "tags added"
end

def load_data
  game_file = File.open("#{Rails.root}/db/game_data.rb", "r")
  game_data = eval(game_file.read)
  game_file.close
  puts "data loaded"
  game_data
end

def add_games
  game_data = load_data
  game_data.each_with_index do |g, i|
    game = Game.create(
      description: g[:description], 
      adulthood: 1,
      college: 1,
      high_school: 1,
      early_childhood: 0,
      elementary_school: 0, 
      minimum: 4, 
      maximum: 25,
    )
    game.names << Name.create(content: g[:name], popularity: 4)
    make_tags(g, game) if g[:tags]          && g[:tags].class == Array
    make_tips(g, game) if g[:notes]         && g[:notes].class == Array
    make_vars(g, game) if g[:variations]    && g[:variations].class == Array
    add_names(g, game) if g[:also_known_as] && g[:also_known_as].class == Array
    game.save
    print_info(i, game)
  end
  puts "games added"
end

def print_info(i, game)
  puts "#{i + 1}. #{game.names.first.content} added"
  if game.description == nil
    puts "******** #{game.names.first.content} has no description ********"
  end
end

def make_tags(g, game)
  g[:tags].each do |content|
    tag = Tag.find_by_name(content: content)
    if tag
      game.tags << tag
    end
  end
end

def make_tips(g, game)
  g[:notes].each do |content|
    game.tips << Tip.create(content: content)
  end
end

def make_vars(g, game)
  g[:variations].each do |content|
    game.variations << Variation.create(content: content)
  end
end

def add_names(g, game)
  g[:also_known_as].each do |other_name|
    game.names << Name.create(content: other_name, popularity: 2)
  end
end

def add_related_games
  unfound_games = []
  game_data.each do |game|
    if found_game = Name.find_by(:content => game[:name]).game
      game[:see_also].each do |content|
        if related_game = Name.find_by(:content => content).game
          found_game.relations << related_game
        end
      end
    else
      unfound_games << game[:name]
    end
  end
  puts "----------- unfound games -----------"
  puts unfound_games.inspect
end

main
