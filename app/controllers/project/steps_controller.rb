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
      redirect_to(next_wizard_path)
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
    when 'address'
      @project.build_address unless @project.address.present?
      unless @project.address.id.present?
        @project.address.build_description(field: 'address info')
      end
    when 'project_amenities'
      Amenity.all.each do |amenity|
        unless @project.project_amenities.pluck(:amenity_id).include?(amenity.id)
          @project.project_amenities.build(amenity_id: amenity.id)
        end
      end
    end
  end

  def project_params(step)
    permitted_attributes = case step
                           when "project_info"
                             [:name, descriptions_attributes: [:id, :field, :content]]
                           when "address"
                             [address_attributes: [:id, :addressable_id, :street, :number, :zip, :city, :country, description_attributes: [:id, :descriptionable_id,:field, :content]]]
                           when "project_amenities"
                             [project_amenities_attributes: [:id, :amenity_id, :_destroy]]
                           when "rooms"
                             [roomtypes_attributes: [:name, :size, rooms_attributes: [:intern_number, :number]]]
                           end

    params.require(:project).permit(permitted_attributes).merge(form_step: step)
  end
end
