class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show]

  def index
    @posts = Post.includes(:user, :sake_log).order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
    if params[:sake_log_id]
      sake_log = SakeLog.find_by(id: params[:sake_log_id])
      if sake_log
        @post.body = "#{sake_log.name}（#{sake_log.taste}）\n#{sake_log.memo}"
        @post.sake_log = sake_log
      end
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: '掲示板に投稿しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body, :sake_log_id)
    end
end
