import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import SimpleReactLightbox, { SRLWrapper } from "simple-react-lightbox";

import { fetchRoomtypes, fetchProject, fetchDescriptions } from '../actions';
import Card from './card';
import Map from '../components/map';
import Spinner from 'react-bootstrap/Spinner';

class RoomtypesIndex extends Component {
	constructor(props){
		super(props)
		this.state = {
			community_area_amenities: []
		}
	}
  componentDidMount() {
  	this.props.fetchProject(this.props.match.params.project_id);
    this.props.fetchRoomtypes(this.props.match.params.project_id);
    const url = `http://localhost:3000/api/v1/amenities?type=project_show&type_id=${this.props.match.params.project_id}`
		fetch(url)
			.then(res => res.json())
	  		.then(data => this.setState({community_area_amenities: data}))
  }

  openLightbox = () => {
    event.target.previousElementSibling.children[0].click()
  }
  
  render () {
    const roomtypes = this.props.roomtypes;
    const project = this.props.project;
    const photos = project && project.photos
	  const community_area_amenities = this.state.community_area_amenities
    const options = {
	  	buttons: {
		    showDownloadButton: false,
		    showNextButton: true,
		    showPrevButton: true,
		    size: '40px'
	  	},
	  	caption: {
	  		showCaption: false
	  	}
		}
    return (
      <div className="stacey-card-wrapper">
        <SimpleReactLightbox key="simpleReactLightbox">
        	{
		  			!project ?
						<div className="no-photos" key="nophotos">No photos yet</div>
					:
        		<div className="project-info-wrapper">
							<div className="project-info-photos">
								{
									!photos ? 
										<div className="no-photos" key="nophotos">No photos yet</div>
									:
										<SRLWrapper options={options}>
											{photos.map((photo, index) => {
									      return <img key={`${project.id}${index}`} src={photo} alt={index}/>
										  })}
									  </SRLWrapper>
								}
                <i className="far fa-image photo-aligned"
                  key={`camera${project.id}`}
                  onClick={() => this.openLightbox()}
                ></i>
							</div>
				  		<div className="project-info-container">
				  			<div className="name">
				  				<span>STACEY</span>
				  				<span>{project.name}</span>
				  			</div>
				  			<span className="description">{project.descriptions.find((description) => description.field === 'project info index').content}</span>
				  		</div>
        		</div>
		  		}
        </SimpleReactLightbox>
        <h3 className="section-header">The Suites</h3>
        <div className="stacey-card-container roomtypes">
          {roomtypes.length === 0 ?
            <Spinner animation="border" role="status">
              <span className="sr-only">Loading...</span>
            </Spinner>
         	:
            roomtypes.map((roomtype) => {
              return (
                <Card key={roomtype.id} type='roomtype' input={roomtype}>
                  {/* project.rooms_bookable ? 'Explore' : 'Not available' */}
                  <Link to={`/projects/${roomtype.project_id}/roomtypes/${roomtype.id}`} key={roomtype.id} className="stacey-button reverse-hover">Explore</Link>
                </Card>
              );
            })
          }
        </div>
        <h3 className="section-header" key="sectionHeaderCommunitySpace">The Community Space</h3>
        {
        	project && 
        	[
          	<span className="description" key="community_area_description">{project.descriptions.find((description) => description.field === 'common space description').content}</span>,
          	<div className="community_area-amenities-wrapper" key="community_area-amenities-wrapper">
	          	<div className="community_area-amenities-container">
		          	{
			          	community_area_amenities.length > 0 && 
			          	community_area_amenities.map((amenity) => {
										return (
											<div className="amenity" key={amenity.id}>
												{amenity.photo ? <img src={amenity.photo} alt="photo" className='photo large bordered' /> : <i className="fa fa-user img-prev"></i>}
												<span>{amenity.title}</span>
											</div>
										);
									})
		          	}
	          	</div>
          	</div>,
            project.name === 'Mühlenkamp' &&
            <div className="matterport-tour" style={{textAlign: 'center', margin: '40px 0'}} key='matterport'>
              <iframe style={{width: '100%', height: '480px', borderRadius: 5}} src='https://my.matterport.com/show/?m=FBXCJk7q5LZ' frameBorder='0' allowFullScreen allow='xr-spatial-tracking'></iframe>
            </div>,
            <h3 className="section-header" key='sectionHeaderLocation'>The Location</h3>,
          	<span className="description" key={`description${project.id}`}>{project.descriptions.find((description) => description.field === 'address info').content}</span>,
            <Map input={project} key={`map${project.id}`} />
          ]
        }
      </div>
    )
  }
};

function mapStateToProps(state) {
  return {
  	project: state.project,
    roomtypes: state.roomtypes,
    descriptions: state.descriptions
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchRoomtypes, fetchProject, fetchDescriptions }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(RoomtypesIndex);
