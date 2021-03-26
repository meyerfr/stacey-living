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

      community_area = community_area.as_json.merge({
        photos: community_area.photos.map { |photo| url_for(photo) },
        amenities: community_area.amenities,
        descriptions: community_area.descriptions
      })

      address = project.address.as_json.merge({
        description: project.address.description
      })

      project.as_json.merge({
        descriptions: project.descriptions,
        prices: [project.cheapest_price],
        marker: marker,
        photos: photos,
        next_available_move_in_date: project.next_available_move_in_date,
        amenities: project.all_amenities,
        community_area: community_area,
        address: address
      })
    }
    # amenities = project.amenities

    render json: projects
  end
end
