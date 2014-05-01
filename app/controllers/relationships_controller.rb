class RelationshipsController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    @relationship = game.relationships.build(:relation_id => params[:relation_id])
    if @relationship.save
      flash[:notice] = "Successfully created link"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy
    flash[:notice] = "Removed link"
    redirect_to root_url
  end
end
