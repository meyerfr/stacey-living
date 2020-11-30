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
	      next_available_move_in = project.next_available_move_in_date
	      project.as_json.merge({ cheapest_price: cheapest_price, marker: marker, photos: photos, next_available_move_in: next_available_move_in })
	    }
		# amenities = project.amenities
		render json: projects
	end

	def show
		project = Project.find(params[:id])
		marker = {
			lat: project.address.latitude,
			lng: project.address.longitude
			# infoWindow: render_to_string(partial: 'info_window', locals: { project: project }),
			# iamge_url: helpers.asset_url('maps_marker.png')
		}
		if params[:page] == 'roomtype_show'
			descriptions = project.address.description
		else
			photos = project.community_areas.first.photos.map { |photo|
				url_for(photo)
			}
			descriptions = project.all_descriptions
		end

		project = project.as_json.merge({
			marker: marker, 
			photos: photos,
			descriptions: descriptions
		})
		render json: project
	end
end
