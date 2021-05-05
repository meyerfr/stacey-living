import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import SimpleReactLightbox, { SRLWrapper } from "simple-react-lightbox";
import Spinner from 'react-bootstrap/Spinner';

import { fetchRoomtypes, fetchProjects } from '../actions';

import ProgressNavbar from '../components/progress_navbar'
import Card from '../components/card';
import Map from '../components/map';

class RoomtypesIndex extends Component {
  componentDidMount() {
    this.props.fetchRoomtypes(this.props.match.params.project_id)
    if (this.props.projects.length === 0) {
      this.props.fetchProjects()
    }
  }

  openLightbox = () => {
    event.target.previousElementSibling.children[0].click()
  }

  render () {
    const roomtypes = this.props.roomtypes;
    const project = this.props.project;
    const photos = project?.photos
    const project_descriptions = project?.descriptions

    const community_area = project?.community_area
    const community_area_amenities = community_area?.amenities
    const community_area_descriptions = community_area?.descriptions

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
      <ProgressNavbar step={2} history={this.props.history} params={this.props.match.params} key="ProgressNavbar2" />,
      <div className="stacey-card-wrapper" key="ProjectShow">
        <SimpleReactLightbox key="simpleReactLightbox">
          {
            !project ?
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
                <span className="description">{project_descriptions?.find((description) => description.field === 'project info index')?.content}</span>
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
            roomtypes.filter(roomtype => !roomtype.name.includes('balcony') && roomtype.name != 'Mighty+').map((roomtype) => {
              return (
                <Card key={roomtype.id} type='roomtype' input={roomtype}>
                  {/* project.rooms_bookable ? 'Explore' : 'Not available' */}
                  <Link to={`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/projects/${roomtype.project_id}/roomtypes/${roomtype.id}`} key={roomtype.id} className="stacey-button reverse-hover">Explore</Link>
                </Card>
              );
            })
          }
        </div>
        {
          project &&
          [
            <div className="section" key="sectionCommunitySpace">
              <h3 className="section-header">The Community Space</h3>
              <span className="description">{community_area_descriptions?.find((description) => description.field === 'common space description')?.content}</span>,
              <div className="community_area-amenities-wrapper">
                <div className="community_area-amenities-container">
                  {
                    community_area_amenities.length > 0 &&
                    community_area_amenities.map((amenity) => {
                      console.log(amenity.photo)
                      return (
                        <div className="amenity" key={amenity.id}>
                          {amenity.photo ? <img src={amenity.photo} alt="photo" className='photo large bordered' /> : <i className="fa fa-user img-prev"></i>}
                          <span>{amenity.title}</span>
                        </div>
                      );
                    })
                  }
                </div>
              </div>
            </div>,
            project.name === 'Mühlenkamp' &&
            <div className="matterport-tour" style={{textAlign: 'center', margin: '40px 0'}} key='matterport'>
              <iframe style={{width: '100%', height: '480px', borderRadius: 5}} src='https://my.matterport.com/show/?m=FBXCJk7q5LZ' frameBorder='0' allowFullScreen allow='xr-spatial-tracking'></iframe>
            </div>,
            <div className="section" key="sectionLocation">
              <h3 className="section-header">The Location</h3>
              <span className="description">{project?.address.description.content}</span>
            </div>,
            <Map locations={this.props.projects} selectedLocation={this.props.project} key={`map${project.id}`} />
          ]
        }
      </div>
    ]
  }
};

function mapStateToProps(state, ownProps) {
  const projectId = parseInt(ownProps.match.params.project_id);
  return {
    projects: state.projects,
    project: state.projects.find((project) => project.id === projectId),
    roomtypes: state.roomtypes
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchRoomtypes, fetchProjects }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(RoomtypesIndex);
