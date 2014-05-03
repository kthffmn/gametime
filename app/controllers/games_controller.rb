class GamesController < ApplicationController

  def index
    @games = Game.all
    respond_to do |format|
      format.html
      format.json { render :json => @games.to_json(:include => [:names, :variations, :tags, :tips])}
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
    @name = @game.names.build
    @tagizatons = @game.tagizations.build
    @tag = @tagizatons.build_tag
    @relationships = @game.relationships.build
    @relation = @relationships.build_relation
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    clean_params = rm_tags_and_relations(game_params)
    @game = Game.new(clean_params)

    get_tag_ids(game_params).each do |id|
      @game.tags << Tag.find(id)
    end

    if relation_ids = get_relation_ids(game_params)
      relation_ids.each do |id|
        @game.relationships << Game.find(id)
      end
    end 
  
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        # format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        # format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @game = Game.find(params[:id])
    binding.pry
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        # format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        # format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url }
      # format.json { head :no_content }
    end
  end

  private

    def game_params
      params.require(:game).permit( 
                                    :description,
                                    :early_childhood, :elementary_school, :middle_school, :high_school, :college, :adulthood,
                                    :example_script,
                                    :id,
                                    :is_an_exercise,
                                    :maximum, :minimum, 

                                    relationships_attributes: [:relation_id, :game_id],

                                    tagizations_attributes: [game_id: [], tag_id: []],

                                    names_attributes: [:content, :game_id, :_destroy, :popularity, :id],
                                    tips_attributes: [:content, :game_id, :id],
                                    variation_attributes: [:content, :game_id, :id]
                                  )
    end
end
