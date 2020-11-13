class SpacesController < ApplicationController
  def index
    @doctors = Doctor.all
    @patients = Patient.all
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new(space_params)
    if @space.save
      redirect_to @space
    else
      render :index
    end
  end

  private

  def space_params
    params.require(:space).permit(:patient_id, :doctor_id, :start_time, :end_time, :create_date)
  end

end
