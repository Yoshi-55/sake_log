class SakeLogsController < ApplicationController
  before_action :set_sake_log, only: %i[ show edit update destroy ]
  before_action :load_brands, only: %i[new edit]

  def index
    @sake_logs = current_user.sake_logs

    # キーワード検索
    if params[:q].present?
      @sake_logs = @sake_logs.where("name ILIKE ? OR memo ILIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end

    # 味覚による並び替え
    if params[:taste_sort].present?
      direction = params[:taste_direction].presence || "desc"  # デフォルトを高い順に
      @sake_logs = sort_by_taste(@sake_logs, params[:taste_sort], direction)
    else
      @sake_logs = @sake_logs.recent
    end
  end

  def show
  end

  def new
    @sake_log = SakeLog.new
  end

  def edit
  end

  def create
    @sake_log = current_user.sake_logs.build(sake_log_params)

    respond_to do |format|
      if @sake_log.save
        format.html { redirect_to sake_logs_path, notice: t("sake_logs.create.success") }
        format.json { render :show, status: :created, location: @sake_log }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sake_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @sake_log.update(sake_log_params)
        format.html { redirect_to sake_logs_path, notice: t("sake_logs.update.success") }
        format.json { render :show, status: :ok, location: @sake_log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sake_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sake_log.destroy!

    respond_to do |format|
      format.html { redirect_to sake_logs_path, status: :see_other, notice: t("sake_logs.destroy.success") }
      format.json { head :no_content }
    end
  end

  private

  def set_sake_log
    @sake_log = current_user.sake_logs.find(params[:id])
  end

  def sake_log_params
    params.require(:sake_log).permit(:name, :memo, :sweetness, :sourness, :spiciness, :bitterness, :umami)
  end

  def load_brands
    @brands = BrandService.fetch_brands
    flash.now[:alert] = "銘柄一覧の取得に失敗しました" if @brands.empty?
  end

  def sort_by_taste(sake_logs, taste_type, direction)
    case taste_type
    when "sweetness"
      column = "sweetness"
    when "sourness"
      column = "sourness"
    when "bitterness"
      column = "bitterness"
    when "umami"
      column = "umami"
    when "spiciness"
      column = "spiciness"
    else
      return sake_logs.recent
    end

    order_direction = direction == "desc" ? "DESC" : "ASC"
    sake_logs.order("#{column} #{order_direction}, created_at DESC")
  end
end
