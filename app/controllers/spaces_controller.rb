class SpacesController < ApplicationController
  def index
    #@spaces = Space.all
    @doctors = Doctor.all
  end

  def show
    #@space = Space.find(params[:id])
    @doctor = Doctor.find(params[:id])
  end

end
