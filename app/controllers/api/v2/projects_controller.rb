class Api::V2::ProjectsController < ActionController::Base
  def index
    projects = Project.where(status: 'active')

    projects = projects.map { |project|
      marker = {
        lat: project.address.latitude,
        lng: project.address.longitude
      }

      photos = project.community_areas.first.photos.map { |photo|
        url_for(photo)
      }

      community_area = project.community_areas.first

      community_area.as_json.merge({
        photos: community_area.photos.map { |photo| url_for(photo) },
        amenities: community_area.amenities,
        descriptions: community_area.descriptions
      })

      project.as_json.merge({
        descriptions: project.descriptions,
        cheapest_price: project.cheapest_price,
        marker: marker,
        photos: photos,
        next_available_move_in: project.next_available_move_in,
        amenities: project.amenities,
        community_area: project.community_areas.first,
        address: project.address
      })
    }
    # amenities = project.amenities

    render json: projects
  end

end
