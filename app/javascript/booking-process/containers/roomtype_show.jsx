import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import SimpleReactLightbox, { SRLWrapper } from "simple-react-lightbox";
import { Link } from 'react-router-dom';


import { fetchRoomtype, fetchProject, fetchAmenities } from '../actions';
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
    this.props.fetchAmenities('roomtype_show', this.props.match.params.id)
      .then((promise) => {
        this.setState({roomtype_amenities: promise.payload})
      })
  }

  openLightbox = () => {
    event.target.previousElementSibling.children[0].click()
  }

  switchToBalconyRoomtype = () => {
    this.props.history.push(`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/projects/${this.props.project.id}/roomtypes/`);
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
                  <div className="section-header main">
                    <h3>{roomtype.name} Suite</h3>
                    {
                      roomtype.roomtype_with_balcony_id &&
                      <a href={`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/projects/${this.props.match.params.project_id}/roomtypes/${roomtype.roomtype_with_balcony_id}`}>This room with balcony</a>
                      // <Link to={`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/projects/${roomtype.roomtype_with_balcony_id}/roomtypes/${roomtype.id}`} key={roomtype.id} className="stacey-button reverse-hover">Explore</Link>
                      // <span onClick={this.switchToBalconyRoomtype}>This Room with Balcony</span>
                    }
                    {
                      roomtype.roomtype_without_balcony_id &&
                      <a href={`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/projects/${this.props.match.params.project_id}/roomtypes/${roomtype.roomtype_without_balcony_id}`}>This room without balcony</a>
                      // <Link to={`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/projects/${roomtype.roomtype_with_balcony_id}/roomtypes/${roomtype.id}`} key={roomtype.id} className="stacey-button reverse-hover">Explore</Link>
                      // <span onClick={this.switchToBalconyRoomtype}>This Room with Balcony</span>
                    }
                  </div>
                  <div className="roomtype-amenities-container">
                    <div className="amenity">
                      <img src="https://res.cloudinary.com/dvuqwvjay/image/upload/v1591348529/square-meter-icon.png" alt="photo" className='photo large bordered' />
                      <span>{roomtype.size.toFixed(0)} m<sup>2</sup></span>
                    </div>
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
                    <div className="amenity">
                      <img src={roomtype.amount_of_people > 1 ? 'https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606736/users.png' : 'https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606736/user.png'} alt="photo" className='photo large bordered' />
                      <span>{roomtype.amount_of_people > 1 ? 'two people' : 'one person'}</span>
                    </div>
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
  return bindActionCreators({ fetchRoomtype, fetchProject, fetchAmenities }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(RoomtypeShow);
