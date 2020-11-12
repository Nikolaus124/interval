class DoctorsController < ApplicationController
  def show
    @doctors = Doctor.all
  end
end
