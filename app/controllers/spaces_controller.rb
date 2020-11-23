class SpacesController < ApplicationController

  def index
    @doctors = Doctor.all
    if (params[:dcr] and params[:dt])
      @spaces = Space.search(params[:dcr], params[:dt])
    end

  end

  def new
    @doctors = Doctor.all
    @patients = Patient.all
    @space = Space.new
  end

  def create
    @space = Space.new(space_params)
    if @space.save
      redirect_to @space
    else
      render :new
    end
  end

  private

  def space_params
    params.require(:space).permit(:patient_id, :doctor_id, :start_time, :end_time, :create_date, :dcr, :dt)
  end

end
