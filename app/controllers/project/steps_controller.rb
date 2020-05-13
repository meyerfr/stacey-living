class Project::StepsController < ApplicationController
  before_action :set_project
  include Wicked::Wizard
  steps *Project.form_steps

  def show
    set_nested_attributes
    render_wizard
  end

  def update
    if @project.update(project_params(step))
      # if step == 'rooms'
        # if params[:add_rooms] == 'false'
          # @project.status == 'active'
        # end
        # render_wizard
      # else
        redirect_to(next_wizard_path)
      # end
    else
      set_nested_attributes
      render_wizard @project
    end
    # raise
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_nested_attributes
    case step
    when 'project_info'
      unless @project.descriptions.present?
        ['project info index', 'project info show'].each do |field|
          @project.descriptions.build(field: field)
        end
      end
      Amenity.all.each do |amenity|
        unless @project.project_amenities.pluck(:amenity_id).include?(amenity.id)
          @project.project_amenities.build(amenity_id: amenity.id)
        end
      end
    when 'address'
      @project.build_address unless @project.address.present?
      unless @project.address.id.present?
        @project.address.build_description(field: 'address info')
      end
    # when 'project_amenities'
    #   Amenity.all.each do |amenity|
    #     unless @project.project_amenities.pluck(:amenity_id).include?(amenity.id)
    #       @project.project_amenities.build(amenity_id: amenity.id)
    #     end
    #   end
    when 'rooms'
      @project.roomtypes.build unless @project.roomtypes.count > 1
      @project.roomtypes.each do |roomtype|
        ['3-5', '6-8', '9+'].each do |duration|
          roomtype.prices.build(duration: duration) unless roomtype.prices.collect(&:duration).include?(duration)
        end
        # roomtype.room_attributes.build
        ['roomtype info'].each do |field|
          roomtype.descriptions.build(field: field) unless roomtype.descriptions.collect(&:field).include?(field)
        end
      end
    end
  end

  def project_params(step)
    permitted_attributes = case step
                           when "project_info"
                             [:name, {photos: []}, descriptions_attributes: [:id, :field, :content], project_amenities_attributes: [:id, :amenity_id, :_destroy]]
                           when "address"
                             [address_attributes: [:id, :addressable_id, :street, :number, :zip, :city, :country, description_attributes: [:id, :descriptionable_id,:field, :content]]]
                           # when "project_amenities"
                           #   [project_amenities_attributes: [:id, :amenity_id, :_destroy]]
                           when "rooms"
                             [roomtypes_attributes: [:_destroy, :id, :name, :size, {photos: []}, rooms_attributes: [:id, :_destroy, :intern_number, :house_number], descriptions_attributes: [:id, :field, :content], prices_attributes: [:id, :duration, :amount]]]
                           end

    params.require(:project).permit(permitted_attributes).merge(form_step: step)
  end
end
