class GamesController < ApplicationController

  def index
    @games = Game.all
    respond_to do |format|
      format.html
      format.json { render :json => @games.to_json(:include => [:most_popular_name, :variations, :tags, :tips])}
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
    @game.names.build
    @game.tags.build
    @game.relations.build
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(game_params)
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @game }
      else
        format.html { render action: 'new' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @game = Game.find(params[:id])
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
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
                                    :example,
                                    :id,
                                    :is_an_exercise,
                                    :maximum, :minimum, 
                                    :relation_ids => [],
                                    :tag_ids => [], 
                                    :tags_attributes => [:id, :name],
                                    names_attributes: [:content, :game_id, :_destroy, :popularity, :id],
                                    tips_attributes: [:content, :game_id, :id],
                                    variation_attributes: [:content, :game_id, :id]
                                  )
    end
end
