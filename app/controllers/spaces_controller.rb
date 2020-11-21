class SpacesController < ApplicationController
  def index
    @spaces = Space.search(params[:search])
    @doctors = Doctor.all
  end

  def new
    @doctors = Doctor.all
    @patients = Patient.all
    @space = Space.new
  end

  def find
    @spaces = Space.find_by(doctor_id: params[:doctor_id], create_date: params[:create_date])
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
    params.require(:space).permit(:patient_id, :doctor_id, :start_time, :end_time, :create_date, :search)
  end

end
