# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# make tags
TAGS = ["accepting", "accepting", "advancing", "agreement", "association", "audience participation", "audience suggestion", "audience warm-up", "backline", "blocking", "blue", "breaking the routine", "bulldozing", "canceling", "characters", "commenting", "concentration", "conflict", "continuation", "denial", "die", "edit", "embodying", "endowing", "endowment", "energy", "environment", "exercise", "experts", "finding the game", "focus", "format", "freezing", "fuck your fear", "gibberish", "give and take", "group", "guessing", "hedging", "heightening", "host", "hip-hop", "icebreakers", "ignoring", "instant trouble", "jabbertalk", "joining", "justifying", "lights edit", "limitations", "line game", "long form", "long form", "look and listen", "mc", "monologue", "music", "name game", "narration", "narrative", "object work", "object work", "offer", "opening", "performance", "pimping", "platform", "props", "questions", "rap", "raising the stakes", "reincorporating", "replay", "revolving door edit", "running gag", "setup", "shelving", "short form", "sideline", "singsong", "solo", "space work", "spontaneity", "status", "status", "storytelling", "subtext", "tag out", "taking care of yourself", "third idea improv", "tilts", "time dash", "timed", "transaction scene", "transitions", "trust", "truthfulness", "verbal wit", "waffling", "walk-through", "warm-up", "wimping", "yes and"]
TAGS.each{|tag| Tag.create(:name  => tag)}

# make game
bunny_game = Game.new(  description: "Extremely silly game, to pump up the energy. Get everyone in a circle. One player becomes the body of a bunny - this is done by holding both arms in front of your chest, elbows touching your rib cage, and letting hands hang. Her 2 neighbors become the `ears` of the bunny, by waving a hand next to the middle player`s ears. All 3 say `bunny bunny bunny` together, until the middle player `throws` a `bunny` to another player in the circle. This player becomes the bunny body, and his neighbors get to do the ears.\r\nPlay this game at a high speed. Mumbling `bunny bunny` en masse gives a nice energy boost.", 
                        minimum: 6, 
                        maximum: 50,
                        is_an_exercise: 0,
                        early_childhood: 0,
                        elementary_school: 1, 
                        middle_school: 1, 
                        high_school: 1, 
                        college: 1, 
                        adulthood: 1
                      )
bunny_game.names = [Name.create(content: "Bunny", game_id: bunny_game.id)]
bunny_game.tags = [Tag.find_by_name("energy")]

# save
bunny_game.save!
