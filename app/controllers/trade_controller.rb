class TradeController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new

  end

  def create
    #@post = 
    redirect_to("/trade/index")
  end
  
  def show
    @id = params[:id]
    @post = Post.find_by(id: params[:id])
  end
end
