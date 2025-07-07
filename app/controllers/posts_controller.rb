class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_post, only: [ :show ]

  def index
    @posts = Post.includes(:user, :sake_log)
    if params[:q].present?
      q = "%#{params[:q]}%"
      @posts = @posts.where("brand LIKE ? OR taste LIKE ? OR memo LIKE ?", q, q, q)
    end
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(30)
  end

  def show
  end

  def new
    @post = Post.new
    if params[:sake_log_id]
      sake_log = SakeLog.find_by(id: params[:sake_log_id])
      if sake_log
        @post.brand = sake_log.name
        @post.taste = sake_log.taste
        @post.memo  = sake_log.memo
        @post.sake_log = sake_log
      end
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "掲示板に投稿しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:brand, :taste, :memo, :sake_log_id)
    end
end
