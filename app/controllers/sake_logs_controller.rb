class SakeLogsController < ApplicationController
  before_action :set_sake_log, only: %i[ show edit update destroy ]
  before_action :load_brands, only: %i[new edit]

  def index
    @sake_logs = current_user.sake_logs.recent
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
    params.require(:sake_log).permit(:name, :taste, :memo, :sweetness, :sourness, :spiciness, :bitterness, :umami)
  end

  def load_brands
    @brands = BrandService.fetch_brands
    flash.now[:alert] = "銘柄一覧の取得に失敗しました" if @brands.empty?
  end
end
