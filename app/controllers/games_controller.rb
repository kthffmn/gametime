class GamesController < ApplicationController

  def index
    @games = Game.all
    respond_to do |format|
      format.html
      format.json { render :json => @games.to_json(:include => :names)}
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
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(game_params)

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
      params.require(:game).permit(:description, :maximum, :minimum, :early_childhood, :elementary_school, :middle_school, :high_school, :college, :adulthood, :example_script, :is_an_exercise, names_attributes: [:content, :game_id, :id, :_destroy, :popularity], tagizations_attributes: [:id, tag_attributes: [:name ]])
    end
end
