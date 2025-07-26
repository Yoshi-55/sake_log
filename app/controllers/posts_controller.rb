class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_post, only: [ :show ]

  def index
    @posts = Post.includes(:user, :sake_log)
                 .search(params[:q])

    # 味覚による並び替え
    if params[:taste_sort].present?
      direction = params[:taste_direction].presence || "desc"  # デフォルトを高い順に
      @posts = sort_by_taste(@posts, params[:taste_sort], direction)
    else
      @posts = @posts.recent
    end

    @posts = @posts.page(params[:page]).per(30)
  end

  def show
    # いいね数の取得
    @likes_count = @post.likes.count

    # 現在のユーザーがいいねしているかチェック（認証済みユーザーの場合）
    @current_user_liked = user_signed_in? && @post.likes.exists?(user: current_user)

    # 関連する投稿の取得（同じ銘柄の他の投稿）
    @related_posts = Post.where(brand: @post.brand)
                        .where.not(id: @post.id)
                        .includes(:user, :sake_log)
                        .limit(3)
  end

  def new
    @post = Post.new
    populate_post_from_sake_log if params[:sake_log_id].present?
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
    params.require(:post).permit(:brand, :memo, :sake_log_id)
  end

  def populate_post_from_sake_log
    sake_log = SakeLog.find_by(id: params[:sake_log_id])
    return unless sake_log

    @post.brand = sake_log.name
    @post.memo = sake_log.memo
    @post.sake_log = sake_log
  end

  def sort_by_taste(posts, taste_type, direction)
    # 味覚データがある投稿のみを取得
    posts_with_taste = posts.joins(:sake_log)

    case taste_type
    when "sweetness"
      column = "sake_logs.sweetness"
    when "sourness"
      column = "sake_logs.sourness"
    when "bitterness"
      column = "sake_logs.bitterness"
    when "umami"
      column = "sake_logs.umami"
    when "spiciness"
      column = "sake_logs.spiciness"
    else
      return posts.recent
    end

    order_direction = direction == "desc" ? "DESC" : "ASC"
    posts_with_taste.order("#{column} #{order_direction}, posts.created_at DESC")
  end
end
