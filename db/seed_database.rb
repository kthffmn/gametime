require "#{Rails.root}/db/game_data.rb"

class SeedDatabase

  attr_reader :game_data

  def initialize
    game_file = File.open("#{Rails.root}/db/game_data.rb", "r")
    data = eval(game_file.read)
    game_file.close
    puts "1. data loaded ********"
    @game_data = data
    seed_tags
    add_games
    add_related_games
  end

  def seed_tags
    tags = ["accepting", "advancing", "agreement", "association", "audience participation", "audience suggestion", "audience warm-up", "backline", "blocking", "blue", "breaking the routine", "bulldozing", "canceling", "characters", "commenting", "concentration", "conflict", "continuation", "denial", "die", "edit", "embodying", "endowing", "endowment", "energy", "environment", "exercise", "experts", "finding the game", "focus", "format", "freezing", "fuck your fear", "gibberish", "give and take", "groundlings", "group", "guessing", "hedging", "heightening", "hip-hop", "host", "icebreakers", "ignoring", "instant trouble", "jabbertalk", "joining", "justifying", "lights edit", "limitations", "line game", "long form", "long form", "look and listen", "magnet", "mc", "monologue", "monoscene", "music", "name game", "narration", "narrative", "object work", "object work", "offer", "opening", "performance", "pimping", "pit", "platform", "props", "questions", "raising the stakes", "rap", "reincorporating", "replay", "revolving door edit", "running gag", "second city", "setup", "shelving", "short form", "sideline", "singsong", "solo", "space work", "spontaneity", "status", "status", "storytelling", "subtext", "tag out", "taking care of yourself", "third idea improv", "tilts", "time dash", "timed", "transaction scene", "transitions", "trust", "truthfulness", "ucb", "verbal wit", "waffling", "walk-through", "warm-up", "wimping", "yes and"]
    tags.each{|tag| Tag.create(:name  => tag)}
    puts "2. tags added ********"
  end

  def add_games
    game_data.each_with_index do |g, i|
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
      game.names << Name.create(content: g[:name], popularity: 4)
      game.save
      make_tags(g, game) if g[:tags]          && g[:tags].class == Array          && g[:tags].length > 0
      make_tips(g, game) if g[:notes]         && g[:notes].class == Array         && g[:notes].length > 0
      make_vars(g, game) if g[:variations]    && g[:variations].class == Array    && g[:variations].length > 0
      add_names(g, game) if g[:also_known_as] && g[:also_known_as].class == Array && g[:also_known_as].length > 0
      game.save
      print_info(i, game)
    end
    puts "444. games added  ********"
  end

  def print_info(i, game)
    puts "#{i + 3}. #{game.names.first.content}"
    if game.description == nil
      puts "******** #{game.names.first.content} has no description ********"
    end
  end

  def make_tags(g, game)
    g[:tags].each do |content|
      tag = Tag.find_by(name: content)
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
          if related_name = Name.find_by(:content => content)
            if related_game = related_name.game
              found_game.relations << related_game
            end
          end
        end
      else
        unfound_games << game[:name]
      end
    end
    puts "445. added relations ********"
    puts "446. unfound games ********"
    puts unfound_games.inspect
  end
end