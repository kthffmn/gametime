# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# make tags
TAGS = ["accepting", "accepting", "advancing", "agreement", "association", "audience participation", "audience suggestion", "audience warm-up", "backline", "blocking", "blue", "breaking the routine", "bulldozing", "canceling", "characters", "commenting", "concentration", "conflict", "continuation", "denial", "die", "edit", "embodying", "endowing", "endowment", "energy", "environment", "exercise", "experts", "finding the game", "focus", "format", "freezing", "fuck your fear", "gibberish", "give and take", "group", "guessing", "hedging", "heightening", "host", "icebreakers", "ignoring", "instant trouble", "jabbertalk", "joining", "justifying", "lights edit", "limitations", "line game", "long form", "long form", "look and listen", "mc", "monologue", "narration", "narrative", "object work", "object work", "offer", "opening", "performance", "pimping", "platform", "props", "questions", "raising the stakes", "reincorporating", "replay", "revolving door edit", "running gag", "setup", "shelving", "short form", "sideline", "singsong", "solo", "space work", "spontaneity", "status", "status", "storytelling", "subtext", "tag out", "taking care of yourself", "third idea improv", "tilts", "time dash", "timed", "transaction scene", "transitions", "trust", "truthfulness", "verbal wit", "waffling", "walk-through", "warm-up", "wimping", "yes and"]
TAGS.each{|tag| Tag.create(:name  => tag)}
