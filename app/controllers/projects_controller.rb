class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :check_booking_auth_token!, only: [:index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  # layout "bookingprocess", only: [:index]
  layout "overview", only: [:index]

  def create
    @project = Project.new
    @project.save(validate: false)
    redirect_to project_step_path(@project, Project.form_steps.first)
    # @project = Project.new(projects_params)
    # raise
    # if @project.save!
    #   redirect_to booking_projects_path('sd', Booking.first.id)
    # else
    #   render :new
    # end
  end

  def index
  end

  def destroy
    if @project.delete
      redirect_to projects_path
    else
      redirect_to :back
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def projects_params
    params.require(:project).permit(
      :street,
      :house_number,
      :city,
      :zipcode,
      :name,
      :description,
      {pictures: []},
      {photos: []},
      {amenities_ids: []},
      project_amenities_attributes: [:amenity_id],
      address_attributes: [
        :street,
        :number,
        :zip,
        :city,
        :country
      ],
      rooms_attributes: [
        :id,
        :project_id,
        :size,
        :description,
        :name,
        :amount,
        {price: []},
        {photos: []},
        room_amenities_attributes: [:amenity_id],
        room_attributes_attributes: [
          :number,
          :house_number
        ]
      ],
    )
  end
end
