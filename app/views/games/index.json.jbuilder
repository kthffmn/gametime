if current_user
  json.user do
    json.id current_user.id
    json.name current_user.name
    json.reviewed_games do
      json.array! current_user.reviews, :game_id
    end
    json.favorited_game do
      json.array! current_user.favorites, :game_id
    end
  end
end

json.games do
  json.array! @games, :id, :most_popular_name, :most_popular_name_content, :variations, :tags, :tips, :is_an_exercise, :summary, :maximum, :minimum, :elementary_school, :middle_school, :high_school, :college, :adulthood, :average_rating, :num_of_favs
end