class SpacesController < ApplicationController
  def index
    @doctors = Doctor.all
    @patients = Patient.all
  end

  def show
    @space = Space.find(params[:id])
    @doctor = Doctor.find(params[:id])
  end

end
