require "net/http"
require "uri"
require "json"

class SakeLogsController < ApplicationController
  before_action :set_sake_log, only: %i[ show edit update destroy ]
  before_action :load_brands, only: %i[new edit]

  # GET /sake_logs or /sake_logs.json
  def index
    @sake_logs = current_user.sake_logs.order(created_at: :desc)
  end

  # GET /sake_logs/1 or /sake_logs/1.json
  def show
  end

  # GET /sake_logs/new
  def new
    @sake_log = SakeLog.new
  end

  # GET /sake_logs/1/edit
  def edit
  end

  # POST /sake_logs or /sake_logs.json
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

  # PATCH/PUT /sake_logs/1 or /sake_logs/1.json
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

  # DELETE /sake_logs/1 or /sake_logs/1.json
  def destroy
    @sake_log.destroy!

    respond_to do |format|
      format.html { redirect_to sake_logs_path, status: :see_other, notice: t("sake_logs.destroy.success") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sake_log
      @sake_log = current_user.sake_logs.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sake_log_params
      params.require(:sake_log).permit(:name, :taste, :memo)
    end

    def load_brands
      url = URI.parse("https://muro.sakenowa.com/sakenowa-data/api/brands")
      response = Net::HTTP.get_response(url)

      if response.is_a?(Net::HTTPSuccess)
        data = JSON.parse(response.body)
        @brands = data["brands"].map { |b| [ b["name"], b["name"] ] }
      else
        @brands = []
        flash.now[:alert] = "銘柄一覧の取得に失敗しました"
      end
    end
end
