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
      if step == 'rooms'
        @project.status == 'active'
        redirect_to bookings_path
      else
        redirect_to(next_wizard_path)
      end
    else
      set_nested_attributes
      render_wizard @project
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_nested_attributes
    case step
    when 'project_info'
      # unless @project.descriptions.present?
      #   @project.descriptions.build(field: 'project info')
      # end
      unless @project.community_areas.present?
        @project.community_areas.build(name: "common space #{@project.name}")
        @project.community_areas.each{ |com| com.descriptions.build }
      end
      unless @project.descriptions.present?
        ['project info index', 'project info show'].each do |field|
          @project.descriptions.build(field: field)
        end
      end
      Amenity.all.each do |amenity|
        @project.join_amenities.build(name: 'project index', amenity_id: amenity.id) unless @project.join_amenities.select{|ja| ja.name == 'project index' && ja.amenity_id == amenity.id }.present?
        @project.community_areas.each do |com|
          com.join_amenities.build(name: 'community area', amenity_id: amenity.id) unless com.join_amenities.select{|ja| ja.name == 'community area' && ja.amenity_id == amenity.id }.present?
        end
      end
    when 'address'
      @project.build_address unless @project.address.present?
      unless @project.address.id.present?
        @project.address.build_description(field: 'address info')
      end
    when 'rooms'
      @project.roomtypes.build unless @project.roomtypes.count > 1
      @project.roomtypes.each do |roomtype|
        ['3-5 Months', '6-8 Months', '9+ Months'].each do |duration|
          roomtype.prices.build(duration: duration) unless roomtype.prices.collect(&:duration).include?(duration)
        end
        # roomtype.room_attributes.build
        roomtype.descriptions.build(field: "#{roomtype.name} description") unless roomtype.descriptions.collect(&:field).include?("#{roomtype.name} description")
        Amenity.all.each do |amenity|
          roomtype.join_amenities.build(name: 'roomtype index inventory', amenity_id: amenity.id) unless roomtype.join_amenities.select{|ja| ja.name == 'roomtype index inventory' && ja.amenity_id == amenity.id }.present?
          roomtype.join_amenities.build(name: 'roomtype index inclusion', amenity_id: amenity.id) unless roomtype.join_amenities.select{|ja| ja.name == 'roomtype index inclusion' && ja.amenity_id == amenity.id }.present?
          roomtype.join_amenities.build(name: 'roomtype show', amenity_id: amenity.id) unless roomtype.join_amenities.select{|ja| ja.name == 'roomtype show' && ja.amenity_id == amenity.id }.present?
        end
      end
    end
  end

  def project_params(step)
    permitted_attributes =  case step
                            when "project_info"
                              [
                                :name,
                                {photos: []},
                                community_areas_attributes: [
                                  :id,
                                  :name,
                                  :size,
                                  {photos: []},
                                  descriptions_attributes:
                                  [
                                    :id,
                                    :field,
                                    :content
                                  ],
                                  join_amenities_attributes: [
                                    :id,
                                    :amenity_id,
                                    :name,
                                    :_destroy
                                  ]
                                ],
                                descriptions_attributes: [
                                  :id,
                                  :field,
                                  :content
                                ],
                                join_amenities_attributes: [
                                  :id,
                                  :amenity_id,
                                  :name,
                                  :_destroy
                                ]
                              ]
                            when "address"
                              [
                                address_attributes: [
                                  :id,
                                  :addressable_id,
                                  :street,
                                  :number,
                                  :zip,
                                  :city,
                                  :country,
                                  description_attributes: [
                                    :id,
                                    :descriptionable_id,
                                    :field,
                                    :content
                                  ]
                                ]
                              ]
                            when "rooms"
                              [
                                roomtypes_attributes: [
                                  :_destroy,
                                  :id,
                                  :name,
                                  :size,
                                  {photos: []},
                                  rooms_attributes: [
                                    :id,
                                    :_destroy,
                                    :intern_number,
                                    :house_number
                                  ],
                                  descriptions_attributes: [
                                    :id,
                                    :field,
                                    :content
                                  ],
                                  prices_attributes: [
                                    :id,
                                    :duration,
                                    :amount
                                  ],
                                  join_amenities_attributes: [
                                    :id,
                                    :amenity_id,
                                    :name,
                                    :_destroy
                                  ]
                                ]
                              ]
                            end

    params.require(:project).permit(permitted_attributes).merge(form_step: step)
  end
end
