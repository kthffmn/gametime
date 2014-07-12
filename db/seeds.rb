def make_tags
  TAGS = ["accepting", "advancing", "agreement", "association", "audience participation", "audience suggestion", "audience warm-up", "backline", "blocking", "blue", "breaking the routine", "bulldozing", "canceling", "characters", "commenting", "concentration", "conflict", "continuation", "denial", "die", "edit", "embodying", "endowing", "endowment", "energy", "environment", "exercise", "experts", "finding the game", "focus", "format", "freezing", "fuck your fear", "gibberish", "give and take", "groundlings", "group", "guessing", "hedging", "heightening", "hip-hop", "host", "icebreakers", "ignoring", "instant trouble", "jabbertalk", "joining", "justifying", "lights edit", "limitations", "line game", "long form", "long form", "look and listen", "magnet", "mc", "monologue", "monoscene", "music", "name game", "narration", "narrative", "object work", "object work", "offer", "opening", "performance", "pimping", "pit", "platform", "props", "questions", "raising the stakes", "rap", "reincorporating", "replay", "revolving door edit", "running gag", "second city", "setup", "shelving", "short form", "sideline", "singsong", "solo", "space work", "spontaneity", "status", "status", "storytelling", "subtext", "tag out", "taking care of yourself", "third idea improv", "tilts", "time dash", "timed", "transaction scene", "transitions", "trust", "truthfulness", "ucb", "verbal wit", "waffling", "walk-through", "warm-up", "wimping", "yes and"]
  TAGS.each{|tag| Tag.create(:name  => tag)}
end

def load_data
  game_file = File.open("#{Rails.root}/db/game_data.rb", "r")
  game_data = eval(game_file.read)
  game_file.close
end

def add_games
  game_data = load_data
  game_data.each do |g|
    game = Game.new(
      description: g[:description], 
      adulthood: 1,
      college: 1,
      high_school: 1,
      early_childhood: 0,
      elementary_school: 0, 
      minimum: 4, 
      maximum: 25,
    )
    game.names = [Name.create(content: g[:name], popularity: 4)]
    game[:tags].each do |t|
      game.tags << Tag.find_by_name(content: t)
    end
    game[:notes].each do |n|
      game.notes << Note.create(content: n)
    end
    game[:variations].each do |v|
      game.variations << Variation.create(content: v)
    end
    game[:also_known_as].each do |other_name|
      game.names << Name.create(content: other_name, popularity: 2)
    end
    game.save!
  end
end

def add_related_games
  game_data.each do |data|
    name = Name.find_by(:content => data[:name])
    game = name.game
    data[:see_also].each do |related|
      related_name = Name.find_by(:content => related)
      related_game = name.game
      game.related_games << related_game
    end
  end
end

def main
  make_tags
  puts "Tags complete"
  add_games
  puts "Games complete"
  add_related_games
  puts "Relations complete"
end

main
