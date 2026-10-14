class MonitoredApisController < ApplicationController
  before_action :set_monitored_api, only: %i[ show edit update destroy ]

  # GET /monitored_apis or /monitored_apis.json
  def index
    @monitored_apis = MonitoredApi.all
  end

  # GET /monitored_apis/1 or /monitored_apis/1.json
  def show
  end

  # GET /monitored_apis/new
  def new
    @monitored_api = MonitoredApi.new
  end

  # GET /monitored_apis/1/edit
  def edit
  end

  # POST /monitored_apis or /monitored_apis.json
  def create
    @monitored_api = MonitoredApi.new(monitored_api_params)

    respond_to do |format|
      if @monitored_api.save
        format.html { redirect_to @monitored_api, notice: "Monitored api was successfully created." }
        format.json { render :show, status: :created, location: @monitored_api }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @monitored_api.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /monitored_apis/1 or /monitored_apis/1.json
  def update
    respond_to do |format|
      if @monitored_api.update(monitored_api_params)
        format.html { redirect_to @monitored_api, notice: "Monitored api was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @monitored_api }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @monitored_api.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /monitored_apis/1 or /monitored_apis/1.json
  def destroy
    @monitored_api.destroy!

    respond_to do |format|
      format.html { redirect_to monitored_apis_path, notice: "Monitored api was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monitored_api
      @monitored_api = MonitoredApi.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def monitored_api_params
      params.expect(monitored_api: [ :name, :url, :expected_status ])
    end
end
