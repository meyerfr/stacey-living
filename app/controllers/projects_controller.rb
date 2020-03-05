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
    # @project.rooms.build
    @last_project = Project.last
  end

  def create
    @project = Project.new(projects_params)
    @project.name = @project.name.titleize
    @project.street = @project.street.titleize
    @project.city = @project.city.titleize
    if @project.save
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
    if @projct.update(projects_params)
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
      rooms_attributes: [
        :id, :project_id, :number, :house_number, :size, :description, :name, :amount, {price: []}, {pictures: []}
      ]
    )
  end
end
