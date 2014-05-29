# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# make tags
TAGS = ["accepting", "advancing", "agreement", "association", "audience participation", "audience suggestion", "audience warm-up", "backline", "blocking", "blue", "breaking the routine", "bulldozing", "canceling", "characters", "commenting", "concentration", "conflict", "continuation", "denial", "die", "edit", "embodying", "endowing", "endowment", "energy", "environment", "exercise", "experts", "finding the game", "focus", "format", "freezing", "fuck your fear", "gibberish", "give and take", "groundlings", "group", "guessing", "hedging", "heightening", "hip-hop", "host", "icebreakers", "ignoring", "instant trouble", "jabbertalk", "joining", "justifying", "lights edit", "limitations", "line game", "long form", "long form", "look and listen", "magnet", "mc", "monologue", "monoscene", "music", "name game", "narration", "narrative", "object work", "object work", "offer", "opening", "performance", "pimping", "pit", "platform", "props", "questions", "raising the stakes", "rap", "reincorporating", "replay", "revolving door edit", "running gag", "second city", "setup", "shelving", "short form", "sideline", "singsong", "solo", "space work", "spontaneity", "status", "status", "storytelling", "subtext", "tag out", "taking care of yourself", "third idea improv", "tilts", "time dash", "timed", "transaction scene", "transitions", "trust", "truthfulness", "ucb", "verbal wit", "waffling", "walk-through", "warm-up", "wimping", "yes and"]
TAGS.each{|tag| Tag.create(:name  => tag)}

# make Bunny game
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
bunny_game.names = [Name.create(content: "Bunny")]
bunny_game.tags = [Tag.find_by_name("energy")]
bunny_game.save!

# make Bibbety Bop game
bop_game =  Game.new(    
                      description: "All players in a circle, one player in the middle who is `it`. This player picks a player in the circle and yells `bippety-bippety-bop` at her. If he manages to get to `bop` before she can say `bop`, she becomes `it`.",
                      minimum: 6, 
                      maximum: 40,
                      is_an_exercise: 0,
                      early_childhood: 0,
                      elementary_school: 1, 
                      middle_school: 1, 
                      high_school: 1, 
                      college: 1, 
                      adulthood: 1
                    )
bop_game.names = [Name.create(content: "Bippety Bop")]
bop_game.tags = [Tag.find_by_name("focus"), Tag.find_by_name("concentration")]
bop_game.variations = [
                        Variation.create(content: "Just say `bop` if anyone else reacts, that person becomes `it`"),
                        Variation.create(content: "Say `Elephant`, after which 3 players build the elephant: the player picked does the trunk (hold nose and squeeze your other arm through) and her neighbors do the ears. If any of the 3 players screws up or does not react he or she becomes it.")
                      ]
bop_game.tips = [Tip.create(content: "This game can get competitive so make sure that players don't target other players maliciously")]
bop_game.save!