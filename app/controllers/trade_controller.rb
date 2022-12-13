class TradeController < ApplicationController
  def index
    @post = Post.all.order(created_at: :asc)
  end

  def new

  end

  def create
    @post = Post.new(content: params[:content], 
                      user_id: session[:user_id], 
                      is_requirement: params[:is_requirement],
                      is_assignment: params[:is_assignment])
    @post.save
    flash[:notice] = "投稿しました"
    redirect_to("/trade/index")
  end
  
  def show
    @id = params[:id]
    @post = Post.find_by(id: params[:id])
    @comment = Comment.find_by(post_id: params[:id])
  end
end
