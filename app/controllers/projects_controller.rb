class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :check_booking_auth_token!, only: [:index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  layout "bookingprocess", only: [:index]

  def index
    # layout booking
    @booking = Booking.find(params[:booking_id])
    @projects = Project.select{|p| p.address.geocoded? }

    @markers = @projects.map do |project|
      {
        lat: project.address.latitude,
        lng: project.address.longitude,
        # infoWindow: render_to_string(partial: 'info_window', locals: { user: user }),
        image_url: helpers.asset_url('maps_marker.png')
      }
    end
  end

  def new
    @project = Project.new
    @project.roomtypes.build
    @last_project = Project.last
    @amenities = Amenity.all
    # ['project info index', 'project info show']
  end

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

  def show
  end

  def edit
  end

  def update
    if @project.update(projects_params)
      redirect_to @project
    else
      render :edit
    end
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
