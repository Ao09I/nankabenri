class ThreadController < ApplicationController
  #子の投稿
  def new
    @post = Post.find_by(id: params[:id])
    #!!!!!!!!!!コメントの取得の仕方!!!!!!!!!!!!!
    @comment = Comment.where(post_id: params[:id])
  end

  def create
    @comment = Comment.new(user_id: session[:user_id], post_id: params[:id], content: params[:content])
    @comment.save
    redirect_to("/thread/new")
  end

  def comment

  end
end
