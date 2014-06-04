class StaticPagesController < ApplicationController

  def home
    @rand_num = rand(1..Game.all.count)
  end
  
end