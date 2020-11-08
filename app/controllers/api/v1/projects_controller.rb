class Api::V1::ProjectsController < ActionController::Base
	def index
		projects = Project.where(status: 'active')

		projects = projects.map { |project|
	      cheapest_price = project.cheapest_price
	      marker = {
	      			 lat: project.address.latitude,
	      			 lng: project.address.longitude
	      			 # infoWindow: render_to_string(partial: 'info_window', locals: { project: project }),
	      			 # iamge_url: helpers.asset_url('maps_marker.png')
	      		   }
	      photos = project.community_areas.first.photos.map { |photo|
	      			 url_for(photo)
	      		   }
	      project.as_json.merge({ cheapest_price: cheapest_price, marker: marker, photos: photos})
	    }
		# amenities = project.amenities
		render json: projects
	end
end
