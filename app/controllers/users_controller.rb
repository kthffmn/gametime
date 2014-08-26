class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @user.to_json(:include => [:favorites, :reviews])}
    end
  end

end