class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    like = @post.likes.find_or_initialize_by(user: current_user)
    
    if like.persisted?
      like.destroy
    else
      like.save
    end
    
    @post.reload
    
    respond_to do |format|
      format.html { redirect_back fallback_location: posts_path }
      format.json { render json: { liked: @post.likes.exists?(user: current_user), count: @post.likes.count } }
      format.js   { render json: { liked: @post.likes.exists?(user: current_user), count: @post.likes.count } }
    end
  end
end
