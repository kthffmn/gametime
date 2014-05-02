json.array!(@games) do |game|
  json.extract! game, :id, :description, :maximum, :minimum, :early_childhood, :elementary_school, :middle_school, :high_school, :college, :adulthood
  json.url game_url(game, format: :json)
end
