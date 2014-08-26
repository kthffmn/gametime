require "#{Rails.root}/db/game_data.rb"

class SeedDatabase

  attr_reader :game_data

  def initialize
    game_file = File.open("#{Rails.root}/db/game_data.rb", "r")
    data = eval(game_file.read)
    game_file.close
    puts "A. data loaded ********"
    @game_data = data
    seed_tags
    add_games
    add_related_games
    relate_tags_to_games
    add_users
    puts "G. ALL DONE :)"
  end

  def seed_tags
    tags = ["accepting", "advancing", "agreement", "association", "audience participation", "audience suggestion", "audience warm-up", "backline", "blocking", "blue", "breaking the routine", "bulldozing", "canceling", "characters", "commenting", "concentration", "conflict", "continuation", "denial", "die", "edit", "embodying", "endowing", "endowment", "energy", "environment", "exercise", "experts", "finding the game", "focus", "format", "freezing", "fuck your fear", "gibberish", "give and take", "groundlings", "group", "guessing", "hedging", "heightening", "hip-hop", "host", "icebreakers", "ignoring", "instant trouble", "jabbertalk", "joining", "justifying", "lights edit", "limitations", "line game", "long form", "long form", "look and listen", "magnet", "mc", "monologue", "monoscene", "music", "name game", "narration", "narrative", "object work", "object work", "offer", "opening", "performance", "pimping", "pit", "platform", "props", "questions", "raising the stakes", "rap", "reincorporating", "replay", "revolving door edit", "running gag", "second city", "setup", "shelving", "short form", "sideline", "singsong", "solo", "space work", "spontaneity", "status", "status", "storytelling", "subtext", "tag out", "taking care of yourself", "third idea improv", "tilts", "time dash", "timed", "transaction scene", "transitions", "trust", "truthfulness", "ucb", "verbal wit", "waffling", "walk-through", "warm-up", "wimping", "yes and"]
    tags.each{|tag| Tag.create(:name  => tag)}
    puts "B. tags added ********"
  end

  def add_games
    puts "C. begin adding games ********"
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
      if game.errors.full_messages.length > 0
        binding.pry
      end
      print_info(i, game)
    end
    puts "D. games added  ********"
  end

  def print_info(i, game)
    puts "  #{i + 1}. #{game.names.first.content}"
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
    game_data.each do |game|
      if name = Name.find_by(:content => game[:name])
        if found_game = name.game
          game[:see_also].each do |content|
            if related_name = Name.find_by(:content => content)
              if related_game = related_name.game
                found_game.relations << related_game
              end
            end
          end
        end
      end
    end
    puts "E. relations added ********"
  end

  def relate_tags_to_games
    tags = {"Accepting"=>["Accepting", "Accepting Circle", "Emotional Manipulation", "Goalie", "Open Offer", "Rumors", "Six Episodes", "Sound Circle", "The Re-Run", "Tug-O-War", "Word at a time proverb", "Yes Lets", "Yes Lets - or Rather Not", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Association"=>["Free Association", "Introducing Association", "3 some", "Alliterations", "Animalistics", "Association Jump", "Become", "Blind Association Circle", "Blind Freeze", "Character Walk", "Clap Snap Association", "CopyCat", "Dissociation", "Family Portraits", "Firing Squad", "Free Association", "Free Association Circle", "Free Association Lines", "Freeze Tag", "Introducing Association", "Jump", "Just Gibberish", "Last Letter", "Malapropism", "Name 6 Circle", "Open Offer", "Patterns", "Props", "Remote Control", "Rumors", "Slappy Face", "Space Jump", "Surprise Movement", "Translate Gibberish", "Walk-over Association", "What are you doing", "What would she be if", "Word Ball", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Audience Participation"=>["Ask-for", "Alphabet Game", "Bucket", "Day in the Life", "Ding Dong", "ID", "Last Letter Scene", "No P", "Only Questions", "Pockets", "Puppets", "Rhymes", "Story Story Die", "Sung Story Die", "Survivor", "The Good, the Bad and the Ugly Advice", "Zulu(2)", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Audience Warm-up"=>["Audience Warm-ups", "Finger Applause", "Superman Jam", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Characters"=>["3 Lines", "Aerobics", "Animalistics", "Animals", "Character Swap", "Character Walk", "Coming Home", "Communal Monologue", "Ding Characters", "Emotions Characters", "Faces", "Fast Food Laban", "Fast Food Stanislawski", "Front Desk", "Funeral Service", "Goalie", "Hitch Hiker", "Imitate", "Jump", "Mr. So and So", "Murder Mystery", "Musical Fairy Tale", "Nuclear Bomb Chicken", "Object Narrative", "Old Job New Job", "Opposite Characters", "Opposites", "Pauze", "Solo Doors", "Split Screen", "Story To A Chair", "Supermen", "The Bag", "Three Line Solo", "Voices From Heaven", "You`re Fired", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Concentration"=>["Look and Listen", "3 Series", "Accepting Circle", "Action Syllables", "Ali Baba and the 40 Thieves", "Alliteration Introduction", "Alliterations", "Alphabet Circle", "Barney", "Beasty Rap", "Big Booty", "Bippety Bop(1)", "Bippety Bop(2)", "Bumpity Bump", "Catch`em", "Character Swap", "Clap Snap Stamp", "Click Bang you`re dead", "Concentration Circle", "Cross Circle", "Distorting Mirror", "Elephant", "Emotional Mirror", "Fruit Basket", "Fuzzy Ducky", "Give and Take", "Group Environment", "Group Freeze", "Ha Soh Kah", "Hand Slap", "Kitty in the Corner", "Knife Baby Angry Cat", "Ksss", "Letter Number Name", "Mexican Name Wave", "Mirror", "Mirror in Circle", "Move and Speak", "No Doubles 1-10", "Non Sequitor", "One Duck", "One Two Three Four", "Pass Clap", "Pass Yes", "Peruvian Ball Game", "Receiver Right Clap", "Remote Control", "Seven Up", "Shootout", "Simon Says", "Sitting Standing Lying", "Slappy Face", "SloMo Tag", "Survivor", "Synchro Clap", "The Magnet", "Turning Circle", "Walking by Numbers", "What Has Changed", "Who stole the Cookies", "You", "Zapping", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Continuation"=>["Scene Replay", "Ask-for", "Before or After", "Communal Monologue", "Continuing Emotions", "Continuing Styles", "Diamond", "Fast Forward", "Growing and Shrinking Machine", "Hat Continuation", "Musical Fairy Tale", "Pauze", "Simple Continuation", "Switcheroo", "Word at a time proverb", "Zoom-In Zoom-Out", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Die"=>["Alphabet Game", "Beatnik Poet", "Last Letter Scene", "No P", "Only Questions", "Rhymes", "Story Story Die", "Sung Story Die", "Survivor", "The Good, the Bad and the Ugly Advice", "Zulu(2)", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Endowment"=>["Card Status", "Crime Endowments", "Dating Game", "Double Endowment", "Endowments", "Famous Person Endowment", "Fortune Teller", "He Said She Said", "Hijacker", "LCD", "Marriage Counsel Endowment", "Mr. So and So", "Press Conference", "Repair Shop", "Silly Stinky Sexy", "The Party", "Who Where Why Am I", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Energy"=>["Warm-up", "Action Syllables", "Ali Baba and the 40 Thieves", "Alphabet Letters", "Bandaid Tag", "Barnyard", "Big Fish Small Fish", "Bobsledding Bodies", "Boom Chicago", "Bunny", "Cat and Mouse", "Catch`em", "Chivalrous Couples", "Create Obstacles", "Ducks and Cows", "Energy 1-10", "Evolution", "Exaggeration Circle", "Fusillade", "Ha Soh Kah", "House, Creature, Flood", "Human Knot", "Killer Bunny", "King Lizard", "Ksss", "Man Overboard", "My Fault", "Pass Clap", "Popcorn", "Primal Screams", "Shootout", "Supernova", "Synchro Clap", "The Scream", "Three Noses", "Virus", "What are you doing", "Whoosh", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Environment"=>["Platform", "Platform", "3 Lines", "Boom Chicago", "Coming Home", "Doors", "Front Desk", "Group Environment", "Human Props", "Move and Speak", "Narrative, Color, Emotion", "Object Morphing", "Real Estate Broker", "Solo Doors", "Three Line Environment", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Exercise"=>["3 Lines", "3 Series", "Accepting Circle", "Aerobics", "Alien Tiger Cow", "Alliteration Introduction", "Alliterations", "Alphabet Circle", "Animalistics", "Animals", "Artist Model Clay", "Association Jump", "Automatic Storytelling", "Back Dancing", "Barney", "Beasty Rap", "Become", "Bidirectional Satellite TV", "Big Blob", "Big Fish Small Fish", "Bippety Bop(1)", "Bippety Bop(2)", "Blind Association Circle", "Blind Freeze", "Blind Harold", "Blind Lead", "Blind Line Offers", "Body Hide", "Boom Chicago", "Boris", "Bunny", "Catch`em", "Character Swap", "Character Walk", "Circle of Knots", "Clap Snap Association", "Click Bang you`re dead", "Columbian Hypnosis", "Coming Home", "Communal Monologue", "Complete Bodies", "Concentration Circle", "CopyCat", "Crisis Situation", "Cross Circle", "Death and Retriever", "Ding", "Ding Characters", "Disc(1)", "Disc(2)", "Dissociation", "Distance Game", "Distorting Mirror", "Doors", "Double Opening", "Duck Duck Goose", "Elephant", "Emotional Manipulation", "Emotional Mirror", "Emotions Characters", "Energy 1-10", "Exaggeration Circle", "Excluding", "Fast Food Laban", "Fast Food Stanislawski", "Flock Dance", "Follow the Leader", "Follow your Nose", "Free Association", "Free Association Circle", "Free Association Lines", "Free Falling", "Freeze Tag", "Front Desk", "Fruit Basket", "Funeral Service", "Fusillade", "Fuzzy Ducky", "Gibberish Commands", "Gibberish Malapropism", "Give and Take", "Goalie", "Greetings", "Group Environment", "Group Freeze", "Group Order", "Ha Soh Kah", "Hand Slap", "He Said She Said", "Hitch Hiker", "Honey Walk", "Human Props", "Imitate", "Introducing Association", "Jump", "Just Gibberish", "Killer Bunny", "King Game", "Knife Baby Angry Cat", "Last Letter", "Letter Number Name", "Line Mirror", "Machines", "Make More Interesting", "Man Overboard", "Mantra", "Mantra Introduction", "Master Servant Disaster", "Mexican Name Wave", "Mirror", "Mirror in Circle", "Mother Goose", "Move and Speak", "Mr. So and So", "My Fault", "Name 6 Circle", "Name Volley", "Narrative, Color, Emotion", "No Doubles 1-10", "Non Sequitor", "Nuclear Bomb Chicken", "Object Morphing", "Object Narrative", "Objects", "One Line Scene", "One Mouth", "One Two Three Four", "Only Questions", "Open Offer", "Open Your Hand", "Opposite Characters", "Opposites", "Overload", "Paperclip Game", "Pass Ball", "Pass Clap", "Patterns", "Pauze", "Peruvian Ball Game", "Point of View", "Pop-up Storybook", "Popcorn", "Presents", "Primal Screams", "Rash", "Real Estate Broker", "Receiver Right Clap", "Remote Control", "Repeater", "Replay Gibberish", "Reverse Chair Dance", "Rumors", "Samurai", "Satellite Radio", "Satellite TV", "Scorpion", "Sculptors", "Seven Up", "Simon Says", "Sitting Standing Lying", "Six Episodes", "Slide Show", "SloMo Samurai", "Smart Fellas", "Solo Doors", "Sound Circle", "Squeezer", "Story Spine", "Story To A Chair", "Supernova", "Surprise Movement", "Survivor", "Swedish Sculptors", "Switch Gibberish", "Synchro Clap", "The Bag", "The Magnet", "The Re-Run", "Three Line Environment", "Three Line Solo", "Three Noses", "Three Sentence Story", "Translate Gibberish", "Tug-O-War", "Voices From Heaven", "Walk-over Association", "Walking by Numbers", "Warehouse", "What are you doing", "What Happens Next", "What Has Changed", "What would she be if", "Word at a Time Letter", "Word at a time proverb", "Word at a Time Story", "Word Ball", "Yes Lets", "You", "You`re Fired", "Zombie Name Game", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Experts"=>["Ask-for", "Gibberish Expert", "Translation for the Deaf", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Format"=>["Long Form", "BarPro", "ComedySportz", "Cut", "Five Four Three Two One", "French Braid", "Gorilla Theatre", "Harold", "Impro Match", "Micetro", "Motel", "Pop-up Storybook", "Script Tease", "Theatresports", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Gibberish"=>["Emotional Mirror", "Five Things", "Foreign Movie", "Gibberish Commands", "Gibberish Expert", "Gibberish Malapropism", "Just Gibberish", "LCD", "Non Sequitor", "Poet Translator", "Replay Gibberish", "Switch Gibberish", "Translate Gibberish", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Group"=>["Trust", "Alien Tiger Cow", "Artist Model Clay", "Association Jump", "Back Dancing", "Blind Lead", "Blind Line Up", "Body Hide", "Circle of Knots", "Circle Sitting", "Death and Retriever", "Duck Duck Goose", "Energy 1-10", "Excluding", "Family Portraits", "Follow the Leader", "Group Environment", "Group Order", "Heave Ho", "Hot Spot", "Human Props", "Line Mirror", "Machines", "Massage", "Millipede", "Objects", "One Mouth", "Popcorn", "Rash", "Reverse Chair Dance", "Sculptors", "Six Episodes", "Slide Show", "Solitaire", "Squeezer", "Swedish Sculptors", "The Magnet", "Tossing", "Tug-O-War", "What Happens Next", "Word at a time proverb", "Word at a Time Story", "Yes Lets", "Yes Lets - or Rather Not", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Guessing"=>["Bong Bong Bong", "Crime Endowments", "Endowments", "Famous Person Endowment", "Five Things", "Fortune Teller", "Hijacker", "LCD", "Marriage Counsel Endowment", "Repair Shop", "Something Old Something New", "The Party", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Icebreakers"=>["Group", "Trust", "10 Fingers", "Action Syllables", "Aerobics", "Alliteration Introduction", "Alphabet Letters", "Bandaid Tag", "Blind Line Up", "Bobsledding Bodies", "Body Hide", "Bumpity Bump", "Click Bang you`re dead", "Create Obstacles", "Cross Circle", "Cross the Circle", "Flock Dance", "Greetings", "House, Creature, Flood", "Human Knot", "King Lizard", "Knife Baby Angry Cat", "Letter Number Name", "Massage", "Mirror in Circle", "Name Volley", "Reverse Chair Dance", "Shootout", "Smart Fellas", "Three Noses", "Who stole the Cookies", "Zombie Name Game", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Limitations"=>["Actor`s Nightmare", "Adjective Scene", "Backwards Interview", "Beatnik Poet", "Big Blob", "Blind Harold", "Blindfolded Scene", "Bong Bong Bong", "Bucket", "Call from Ray", "Card Status", "Crabtrees Conundrum", "Deaf Replay", "Death in a Minute", "Disc(1)", "Disc(2)", "Distance Game", "Double Blind Freeze", "Double Opening", "Dry Cleaning Bag of Death", "Emotional Family", "Emotional Quadrants", "Evil Stick of Gum", "Final Freeze", "Five Things", "Fortune Cookie", "Handicapped Fairy Tale", "Helping Hands", "Hesitation", "ID", "Last Letter Scene", "Last Line", "Location", "Marshmallow Mania", "Motel", "Move and Speak", "No P", "One Line Scene", "Only Questions", "Parallel Universe", "Pockets", "Rhymes", "Scene in the Dark", "Sideways", "Sitting Standing Lying", "Split Screen", "The Bat", "Three Rules", "Timeline", "Touch to Talk", "Verses", "Walkout", "Without Sound", "Without Words", "Word at a Time Expert", "Word at a Time Scene", "Word at a Time Song", "You`re Fired", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Long Form"=>["Harold", "Triple Play", "Armando", "Balladeer(2)", "Blind Harold", "Cloud Atlas", "Cut", "Deconstruction", "Disaster Movie", "Doo Wop(2)", "DVD Special Edition", "Faces", "Feature Film", "Five Four Three Two One", "Follow the Leaver", "French Braid", "Funeral Service", "Goon River", "Harold", "Invocation", "La Ronde", "Location", "Lotus", "Maslow`s Hierarchy of Needs", "Montage", "Motel", "Murder Mystery", "Pop-up Storybook", "Script Tease", "Soap Series", "Standard Musical", "Straight Story", "Sybil", "TellTales", "The Bat", "Triple Play", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Look and Listen"=>["3 Lines", "3 Series", "Aerobics", "Bidirectional Satellite TV", "Blind Association Circle", "Blind Harold", "Boom Chicago", "Card Status", "Character Swap", "Communal Monologue", "Complete Bodies", "Double Endowment", "Double Opening", "Hijacker", "Janus Dance", "Knife Baby Angry Cat", "Mirror in Circle", "Mother Goose", "No Doubles 1-10", "Overload", "Paperclip Game", "Pauze", "Point of View", "Remote Control", "Repeater", "Satellite Radio", "Satellite TV", "Scene in the Dark", "Something Old Something New", "Survivor", "The Re-Run", "Walking by Numbers", "What Has Changed", "You", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Narration"=>["Storytelling", "Automatic Storytelling", "Boris", "Cloud Atlas", "Double Endowment", "Double Opening", "Guest Game", "Just Gibberish", "Lets Not", "Master Servant Disaster", "Movie Review", "Musical Fairy Tale", "Name the Monster", "Narrative, Color, Emotion", "Narrator", "Object Narrative", "Only Questions", "Point of View", "Rhymes", "Script Tease", "Six Episodes", "Slide Show", "Story Spine", "Story Story Die", "Straight Story", "Three Sentence Story", "Typewriter", "Voices From Heaven", "What Happens Next", "Word at a Time Letter", "Word at a time proverb", "Word at a Time Story", "Yes Lets - or Rather Not", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Object Work"=>["10 Fingers", "3 some", "Accepting Circle", "Action Syllables", "Ali Baba and the 40 Thieves", "Alien Tiger Cow", "Alliterations", "Alphabet Circle", "Alphabet Letters", "Assassin", "Association Jump", "Bandaid Tag", "Barney", "Barnyard", "Beasty Rap", "Big Booty", "Big Fish Small Fish", "Bippety Bop(1)", "Bippety Bop(2)", "Blind Freeze", "Blind Line Up", "Bobsledding Bodies", "Boom Chicago", "Bumpity Bump", "Bunny", "Cat and Mouse", "Catch`em", "Chivalrous Couples", "Circle Sitting", "Clap Snap Association", "Clap Snap Stamp", "Concentration Circle", "Create Obstacles", "Cross Circle", "Cross the Circle", "Dissociation", "Duck Duck Goose", "Ducks and Cows", "Eights", "Elephant", "Emotional Mirror", "Energy 1-10", "Evolution", "Exaggeration Circle", "Family Portraits", "Firing Squad", "Flock Dance", "Follow your Nose", "Free Association", "Free Association Circle", "Freeze Tag", "Fruit Basket", "Fuzzy Ducky", "Greetings", "Group Order", "Ha Soh Kah", "Hand Slap", "Honey Walk", "Hot Spot", "House, Creature, Flood", "Human Knot", "Jump", "Killer Bunny", "King Lizard", "Kitty in the Corner", "Knife Baby Angry Cat", "Ksss", "Last Letter", "Letter Number Name", "Malapropism", "Man Overboard", "Massage", "Mexican Name Wave", "Millipede", "Mirror", "Mirror in Circle", "No Doubles 1-10", "Non Sequitor", "Objects", "One Duck", "One Two Three Four", "Pass Ball", "Pass Clap", "Pass Yes", "Patterns", "Play Tag", "Popcorn", "Presents", "Primal Screams", "Rash", "Receiver Right Clap", "Remote Control", "Rumors", "Samurai", "Seven Up", "Shootout", "SloMo Samurai", "SloMo Tag", "Smart Fellas", "Sound Circle", "Squeezer", "Stretching", "Supernova", "Synchro Clap", "The Scream", "Three Noses", "Turning Circle", "Virus", "Walking by Numbers", "What are you doing", "Who stole the Cookies", "Whoosh", "Word at a time proverb", "Word Ball", "Yes Lets", "You", "Zombie Name Game", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Performance"=>["Actor`s Nightmare", "Adjective Scene", "Alphabet Game", "American Idol", "Animalistics", "Armando", "Asides", "Audience Warm-ups", "Backwards Interview", "Balladeer(1)", "Balladeer(2)", "Bartender", "Beasty Rap", "Beatnik Poet", "Before or After", "Big Blob", "Black Box", "Blind Freeze", "Blind Harold", "Blind Musical", "Blindfolded Scene", "Blues Jam", "Bong Bong Bong", "Boris", "Bucket", "Call from Ray", "Card Status", "Cards", "CD Shop", "ComedySportz", "Commercial", "Confessions", "Continuing Emotions", "Continuing Styles", "CopyCat", "Crabtrees Conundrum", "Crime Endowments", "Dating Game", "Day in the Life", "Deaf Replay", "Death in a Minute", "Deconstruction", "Diamond", "Ding", "Ding Dong", "Director`s Cut", "Do Ron Ron", "Doo Wop(1)", "Doo Wop(2)", "Double Blind Freeze", "Double Endowment", "Dry Cleaning Bag of Death", "Dubbed Movie", "DVD Special Edition", "Emotional Family", "Emotional Manipulation", "Emotional Quadrants", "Endowments", "Evil Stick of Gum", "Evil Twin", "Famous Last Words", "Famous Person Endowment", "Fast Forward", "Feature Film", "Final Freeze", "Finger Applause", "Five Things", "Foreign Movie", "Fortune Cookie", "Fortune Teller", "Freeze Tag", "French Braid", "Funeral Service", "Fusillade", "Game-O-Matic", "Gibberish Expert", "Goon River", "Greatest Hits", "Ground Control", "Growing and Shrinking Machine", "Guest Game", "Hall of Justice", "Handicapped Fairy Tale", "Harold", "Hat Continuation", "Hats", "He Said She Said", "Helping Hands", "Hesitation", "Hijacker", "Hitch Hiker", "Horoscope", "Human Props", "I Love You", "ID", "In-Out", "Invisibility", "Invocation", "Irish Drinking Song", "Janus Dance", "Jeopardy", "Just Gibberish", "La Ronde", "Last Letter Scene", "Last Line", "LCD", "Little Voice", "Location", "Lotus", "Lounge Singer", "Machines", "Making Faces", "Marriage Counsel Endowment", "Marshmallow Mania", "Maslow`s Hierarchy of Needs", "Mega Replay", "Montage", "More or Less", "Motel", "Move and Speak", "Mr. So and So", "Musical Fairy Tale", "Narrator", "No P", "Object Narrative", "Old Job New Job", "One Eighty Five", "One Mouth", "Only Questions", "Parallel Universe", "Pecking Order", "Pillars", "Pockets", "Poet Translator", "Poetry Corner", "Point of View", "Pop-up Storybook", "Press Conference", "Props", "Protest Song", "Puppets", "Repair Shop", "Reverse Trivial Pursuit", "Rhymes", "Rituals", "Scene in the Dark", "Scene Painting", "Scene Replay", "Scene To Music", "Script Tease", "Sideways", "Silly Stinky Sexy", "Simple Continuation", "Sitting Standing Lying", "Slap Take", "Slide Show", "Soap Series", "Something Old Something New", "Sound Effects", "Sounds Like a Song", "Space Jump", "Spit Take", "Split Screen", "Sportz Center", "Story Story Die", "Stunt Double", "Sung Story Die", "Superman Jam", "Supermen", "Survivor", "Switch Gibberish", "Switcheroo", "Sybil", "The Bat", "The Gerbil", "The Good, the Bad and the Ugly Advice", "The Party", "Three Melodies", "Three Rules", "Timed Scenes", "Timeline", "Touch to Talk", "Translation for the Deaf", "Triple Play", "Trivial Pursuit", "TV News", "Typewriter", "Verses", "Voices From Heaven", "Walkout", "Who Where Why Am I", "Without Sound", "Without Words", "Word at a Time Expert", "Word at a Time Scene", "Word at a Time Song", "Worlds Worst", "You`re Fired", "Zapping", "Zoom-In Zoom-Out", "Zulu(1)", "Zulu(2)", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Replay"=>["Limitations", "Character Swap", "Deaf Replay", "Mega Replay", "Point of View", "Replay Gibberish", "Scene Replay", "The Re-Run", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "SingSong"=>["References", "American Idol", "Balladeer(1)", "Balladeer(2)", "Bartender", "Beasty Rap", "Blind Musical", "Blues Jam", "CD Shop", "Do Ron Ron", "Doo Wop(1)", "Doo Wop(2)", "Greatest Hits", "Hot Spot", "I Love You", "Irish Drinking Song", "Lounge Singer", "Musical Fairy Tale", "Protest Song", "Scene To Music", "Sounds Like a Song", "Standard Musical", "Sung Story Die", "Three Melodies", "Word at a Time Song", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Solo"=>["Lounge Singer", "Narrative, Color, Emotion", "Solo Doors", "Story To A Chair", "Sybil", "Three Line Solo", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Spontaneity"=>["Barney", "Become", "Crisis Situation", "Ding", "Mantra", "Mantra Introduction", "Name the Monster", "Open Your Hand", "Presents", "Sound Circle", "Surprise Movement", "Translate Gibberish", "Warehouse", "Zombie Name Game", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Status"=>["Status", "Card Status", "Master Servant Disaster", "Mother Goose", "Pecking Order", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Timed"=>["Timed Scenes", "Death in a Minute", "Scene Replay", "Timed Scenes", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Trust"=>["Icebreakers", "Group", "Back Dancing", "Blind Lead", "Blindfolded Scene", "Body Hide", "Circle Sitting", "Columbian Hypnosis", "Death and Retriever", "Emotional Manipulation", "Fingertips", "Free Falling", "Heave Ho", "Janus Dance", "Massage", "Scorpion", "Solitaire", "Swedish Sculptors", "The Magnet", "Tossing", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Verbal wit"=>["Alphabet Game", "Confessions", "Famous Last Words", "Jeopardy", "One Eighty Five", "Poetry Corner", "Press Conference", "Reverse Trivial Pursuit", "Rhymes", "The Good, the Bad and the Ugly Advice", "Trivial Pursuit", "Worlds Worst", "Zulu(1)", "Zulu(2)", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"], "Warm-up"=>["10 Fingers", "3 some", "Accepting Circle", "Action Syllables", "Ali Baba and the 40 Thieves", "Alien Tiger Cow", "Alliterations", "Alphabet Circle", "Alphabet Letters", "Assassin", "Association Jump", "Bandaid Tag", "Barney", "Barnyard", "Beasty Rap", "Big Booty", "Big Fish Small Fish", "Bippety Bop(1)", "Bippety Bop(2)", "Blind Freeze", "Blind Line Up", "Bobsledding Bodies", "Boom Chicago", "Bumpity Bump", "Bunny", "Cat and Mouse", "Catch`em", "Chivalrous Couples", "Circle Sitting", "Clap Snap Association", "Clap Snap Stamp", "Concentration Circle", "Create Obstacles", "Cross Circle", "Cross the Circle", "Dissociation", "Duck Duck Goose", "Ducks and Cows", "Eights", "Elephant", "Emotional Mirror", "Energy 1-10", "Evolution", "Exaggeration Circle", "Family Portraits", "Firing Squad", "Flock Dance", "Follow your Nose", "Free Association", "Free Association Circle", "Freeze Tag", "Fruit Basket", "Fuzzy Ducky", "Greetings", "Group Order", "Ha Soh Kah", "Hand Slap", "Honey Walk", "Hot Spot", "House, Creature, Flood", "Human Knot", "Jump", "Killer Bunny", "King Lizard", "Kitty in the Corner", "Knife Baby Angry Cat", "Ksss", "Last Letter", "Letter Number Name", "Malapropism", "Man Overboard", "Massage", "Mexican Name Wave", "Millipede", "Mirror", "Mirror in Circle", "No Doubles 1-10", "Non Sequitor", "Objects", "One Duck", "One Two Three Four", "Pass Ball", "Pass Clap", "Pass Yes", "Patterns", "Play Tag", "Popcorn", "Presents", "Primal Screams", "Rash", "Receiver Right Clap", "Remote Control", "Rumors", "Samurai", "Seven Up", "Shootout", "SloMo Samurai", "SloMo Tag", "Smart Fellas", "Sound Circle", "Squeezer", "Stretching", "Supernova", "Synchro Clap", "The Scream", "Three Noses", "Turning Circle", "Virus", "Walking by Numbers", "What are you doing", "Who stole the Cookies", "Whoosh", "Word at a time proverb", "Word Ball", "Yes Lets", "You", "Zombie Name Game", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"]}
    errors = ["ERROR!!!"]
    i = 0
    tags.each do |tag, games|
      i += 1
      my_tag = Tag.find_or_create_by(:name => tag.downcase)
      puts "  #{i}. Applying the #{my_tag.name} tag"
      games.each do |g|
        name = Name.find_by(:content => g)
        if name
          if name.game
            name.game.tags << my_tag
          end
        else
          errors << g
        end
      end
    end
    puts errors.inspect
    puts "F. related tags to games ********"
  end

  def add_users
    katie = User.create(
      image_url: "http://graph.facebook.com/707770775927049/picture?type=square",
      provider: "facebook",
      uid: "707770775927049",
      name: "Katie Hoffman",
      oauth_token: "CAAE3EX4UXuUBAIprYJ4KZALzkWjiJ2HsV9BwIm0S7zyEH8TF2ECELo1GgJnZA6Ws48bZBHV9xatuSNpj64fS7DCFj7h1bNF15w5JNvLwuv3WxmH3I7Oawl1RfD8ycqHVluQYCKqysrDur5SjlkHmkqqONuimzIvJdgcrhZBbziRq44l4L4FSpsf3PKGKalpU7ysi34GZBs3iiwIK57PA8",
      oauth_expires_at: "Tue, 26 Aug 2014 19:00:00 UTC +00:00"
    )
  end
end
# ["ERROR: no name found", "Accepting", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "What would she be if", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Ask-for", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "You`re Fired", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Look and Listen", "Click Bang you`re dead", "What Has Changed", "Who stole the Cookies", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Ask-for", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Warm-up", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Platform", "Platform", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Click Bang you`re dead", "What Has Changed", "What would she be if", "You`re Fired", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Ask-for", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Long Form", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Trust", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Group", "Trust", "Click Bang you`re dead", "Who stole the Cookies", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "You`re Fired", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Maslow`s Hierarchy of Needs", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "What Has Changed", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Storytelling", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Who stole the Cookies", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Director`s Cut", "Maslow`s Hierarchy of Needs", "You`re Fired", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Limitations", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "References", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Icebreakers", "Group", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact", "Who stole the Cookies", "Improv Encyclopedia", "Improv Games", "Improv Game Categories", "Improv Glossary", "Improv References", "FAQ", "Download", "Contact"]