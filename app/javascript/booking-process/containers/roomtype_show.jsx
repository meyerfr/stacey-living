import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import SimpleReactLightbox, { SRLWrapper } from "simple-react-lightbox";

import { fetchRoomtype, fetchProject } from '../actions';
// import Card from './card';
import Map from '../components/map';
import BookingForm from './booking_form';
import Spinner from 'react-bootstrap/Spinner';

class RoomtypeShow extends Component {
	constructor(props){
		super(props)
		this.state = {
			roomtype_amenities: []
		}
	}
  componentDidMount() {
  	this.props.fetchProject(this.props.match.params.project_id, 'roomtype_show');
    this.props.fetchRoomtype(this.props.match.params.id);
    const url = `http://localhost:3000/api/v1/amenities?type=roomtype_show&type_id=${this.props.match.params.id}`
		fetch(url)
			.then(res => res.json())
	  		.then(data => this.setState({roomtype_amenities: data}))
  }

  openLightbox = () => {
    event.target.previousElementSibling.children[0].click()
  }

  render () {
    const roomtype = this.props.roomtype;
    const project = this.props.project;
    const photos = roomtype && roomtype.photos
	  const roomtype_amenities = this.state.roomtype_amenities
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
    // console.log(this.props.history)
    return (
      <div className="stacey-card-wrapper">
        <SimpleReactLightbox key="simpleReactLightbox">
        	{
		  			!roomtype ?
						<Spinner animation="border" role="status">
              <span className="sr-only">Loading...</span>
            </Spinner>
					:
        		<div className="project-info-wrapper">
							<div className="project-info-photos">
								{
									!photos ? 
										<Spinner animation="border" role="status">
                      <span className="sr-only">Loading...</span>
                    </Spinner>
									:
										<SRLWrapper options={options}>
											{photos.map((photo, index) => {
									      return <img key={`${roomtype.id}${index}`} src={photo} alt={index}/>
										  })}
									  </SRLWrapper>
								}
                <i className="far fa-image photo-aligned"
                  key={`camera${project.id}`}
                  onClick={() => this.openLightbox()}
                ></i>
							</div>
        		</div>
		  		}
        </SimpleReactLightbox>
        <div className="roomtype-wrapper">
          {
            roomtype && photos && project &&
            [
              <div className="roomtype-container" key={`roomtypeWrapper${roomtype.id}`}>
                <div className="section">
                  <h3 className="section-header main" key='sectionHeaderMain'>{roomtype.name} Suite</h3>
                  <div className="roomtype-amenities-container">
                    {
                      roomtype_amenities.length > 0 && 
                      roomtype_amenities.map((amenity) => {
                        return (
                          <div className="amenity" key={amenity.id}>
                            {amenity.photo && <img src={amenity.photo} alt="photo" className='photo large bordered' />}
                            <span>{amenity.title}</span>
                          </div>
                        );
                      })
                    }
                  </div>
                </div>

                <div className="section">
                  <h3 className="section-header" key='sectionHeaderSuite'>The Suite</h3>
                  <div className="roomtype-photos-container">
                    <SimpleReactLightbox key="simpleReactLightboxRoomtype">
                      <SRLWrapper options={options}>
                        {photos.map((photo, index) => {
                          return <img key={`${project.id}${index}`} src={photo} alt={index}/>
                        })}
                      </SRLWrapper>
                      <i className="far fa-image photo-aligned"
                        key={`camera${roomtype.id}`}
                        onClick={() => this.openLightbox()}
                      ></i>
                    </SimpleReactLightbox>
                  </div>
                </div>
                <div className="section">
                  <h3 className="section-header" key='sectionHeaderLocation'>The Location</h3>
                	<span className="description" key={`description${project.id}`}>{project.descriptions.content}</span>
                </div>
                <Map input={project} key={`map${project.id}`} />
                <div className="section">
                  <h3 className="section-header">What Is The Coliving Buzz All About?</h3>
                  <span className="description">
                    Our members enjoy their individual private suites whilst sharing beautiful common spaces. <br/>
                    Everything you need is included in one convenient payment: Rent, furniture, internet, utilities, cleaning, events, Netflix + Spotify in the common spaces and even the GEZ. Do not take our word for granted, move in and experience the STACEY way of living!</span>
                </div>
              </div>,
              <BookingForm booking_id={this.props.match.params.booking_id} booking_auth_token={this.props.match.params.booking_auth_token} roomtype={roomtype} key="bookingForm" history={this.props.history}/>
            ]
          }
        </div>
      </div>
    )
  }
};

function mapStateToProps(state) {
  return {
  	project: state.project,
    roomtype: state.roomtype
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchRoomtype, fetchProject }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(RoomtypeShow);
