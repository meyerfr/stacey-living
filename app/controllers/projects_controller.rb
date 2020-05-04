class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :check_booking_auth_token!, only: [:index]
  layout "bookingprocess", only: [:index]

  def index
    # layout booking
    @booking = Booking.find(params[:booking_id])
    @projects = Project.all
  end

  def new
    @project = Project.new
    @project.roomtypes.build
    @last_project = Project.last
    @amenities = Amenity.all
  end

  def create
    @project = Project.new(projects_params)
    if @project.save!
      redirect_to booking_projects_path('sd', Booking.first.id)
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(projects_params)
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.delete
      redirect_to projects_path
    else
      redirect_to :back
    end
  end

  private

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
