class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:show, :edit, :update, :destroy]

  # GET /facilities
  # GET /facilities.json
  def index
    @facilities = Facility.all
    @communities = (@facilities.map { |f| f.community }).uniq
    sum = 0
    summed = 0
    @over_10_days = 0
    @max_delay = 0
    @facilities.each do |f|
      if f.checks.length > 0
        last_check = f.checks.order('checks.date DESC').limit(1).first
        difference = (Time.zone.now.to_date - last_check.date.to_date).to_i
        sum += difference > f.days_to_check ? difference - f.days_to_check : 0
        summed += difference > f.days_to_check ? 1 : 0
        @over_10_days += difference > 10 ? 1 : 0;
        @max_delay = difference > @max_delay ? difference - f.days_to_check : @max_delay
      end
    end
    @average_delay = summed > 0 ? sum / summed : 0
  end

  def facilities
    @facilities = Facility.all
  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
  end

  # GET /facilities/new
  def new
    @facility = Facility.new
  end

  # GET /facilities/1/edit
  def edit
  end

  # POST /facilities
  # POST /facilities.json
  def create
    @facility = Facility.new(facility_params)

    respond_to do |format|
      if @facility.save
        format.html { redirect_to @facility, notice: 'Facility was successfully created.' }
        format.json { render :show, status: :created, location: @facility }
      else
        format.html { render :new }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facilities/1
  # PATCH/PUT /facilities/1.json
  def update
    respond_to do |format|
      if @facility.update(facility_params)
        format.html { redirect_to @facility, notice: 'Facility was successfully updated.' }
        format.json { render :show, status: :ok, location: @facility }
      else
        format.html { render :edit }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    @facility.destroy
    respond_to do |format|
      format.html { redirect_to facilities_url, notice: 'Facility was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility
      @facility = Facility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facility_params
      params.require(:facility).permit(:name, :community, :days_to_check)
    end
end
