import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import SimpleReactLightbox, { SRLWrapper } from "simple-react-lightbox";
import { Link } from 'react-router-dom';
import Spinner from 'react-bootstrap/Spinner';

import { fetchRoomtypes, fetchProjects } from '../actions';

import ProgressNavbar from '../components/progress_navbar'
import Map from '../components/map';
import BookingForm from './booking_form';

class RoomtypesShow extends Component {
  // constructor(props){
  //   super(props)
  //   this.state = {
  //     roomtype_amenities: []
  //   }
  // }
  componentDidMount() {
    if (this.props.roomtypes.length === 0) {
      this.props.fetchProjects()
      this.props.fetchRoomtypes(this.props.match.params.project_id)
    }
  }

  openLightbox = () => {
    event.target.previousElementSibling.children[0].click()
  }

  switchToBalconyRoomtype = () => {
    this.props.history.push(`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/projects/${this.props.project.id}/roomtypes/`);
  }

  render () {
    const roomtype = this.props.roomtype;
    console.log('roomtype', roomtype)
    const project = this.props.project;
    const photos = roomtype && roomtype.photos
    const roomtype_amenities = roomtype?.amenities.roomtype_show_amenities
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

    return [
      <ProgressNavbar step={3} history={this.props.history} params={this.props.match.params} key="ProgressNavbar2" />,
      <div className="stacey-card-wrapper" key="RoomtypesShow">
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
                      roomtype.balcony &&
                      // <a href={`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/projects/${this.props.match.params.project_id}/roomtypes/${roomtype.roomtype_with_balcony_id}`}>This room with balcony</a>
                      <Link to={`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/projects/${this.props.match.params.project_id}/roomtypes/${roomtype.balcony}`} key={roomtype.id}>{`This room ${roomtype.name.includes('balcony') ? 'without' : 'with'} balcony`}</Link>
                      // <span onClick={this.switchToBalconyRoomtype}>This Room with Balcony</span>
                    }
                    {
                      // roomtype.balcony &&
                      // <a href={`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/projects/${this.props.match.params.project_id}/roomtypes/${roomtype.roomtype_without_balcony_id}`}>This room without balcony</a>
                      // <Link to={`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/projects/${roomtype.balcony.id}/roomtypes/${roomtype.id}`} key={roomtype.id}>This room without balcony</Link>
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
                  <span className="description">{roomtype?.description.content}</span>
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
                  <span className="description" key={`description${project.id}`}>{project?.address.description.content}</span>
                </div>
                <Map selectedLocation={project} locations={this.props.projects} key={`map${project.id}`} />
                <div className="section">
                  <h3 className="section-header">What Is The Coliving Buzz All About?</h3>
                  <span className="description">
                    Our members enjoy their individual private suites whilst sharing beautiful common spaces. <br/>
                    Everything you need is included in one convenient payment: Rent, furniture, internet, utilities, cleaning, events, Netflix + Spotify in the common spaces and even the GEZ. Do not take our word for granted, move in and experience the STACEY way of living!</span>
                </div>
              </div>,
              <BookingForm roomtype={roomtype} params={this.props.match.params} key="bookingForm" history={this.props.history} />
            ]
          }
        </div>
      </div>
    ]
  }
};

function mapStateToProps(state, ownProps) {
  const projectId = parseInt(ownProps.match.params.project_id);
  const roomtypeId = parseInt(ownProps.match.params.roomtype_id);
  return {
    projects: state.projects,
    project: state.projects.find((project) => project.id === projectId),
    roomtypes: state.roomtypes,
    roomtype: state.roomtypes?.find((roomtype) => roomtype.id === roomtypeId)
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchRoomtypes, fetchProjects }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(RoomtypesShow);
