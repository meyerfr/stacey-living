import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import SimpleReactLightbox from "simple-react-lightbox";
import GoogleMapReact from "google-map-react";

import { fetchProjects } from '../actions';
import Card from './card';
import Marker from '../components/marker';
import Spinner from 'react-bootstrap/Spinner';

class ProjectsIndex extends Component {
  componentDidMount() {
    this.props.fetchProjects();
  }

  centerMap() {
    return {
      lat: 53.551086,
      lng: 9.993682
    };
  }

      // <Aside key="aside" garage={this.props.garage}>
      //   <Link to="/cars/new">Add a car</Link>
      // </Aside>,
  render () {
    const projects = this.props.projects
    return (
      <SimpleReactLightbox key="simpleReactLightbox">
        <div className="stacey-card-wrapper">
          <div className="banner">
            Where do you want to live next?
          </div>
          <div className="stacey-card-container">
            {projects.length === 0 ?
              <Spinner animation="border" role="status">
                <span className="sr-only">Loading...</span>
              </Spinner>
           :
              projects.map((project) => {
                return (
                  <Card key={project.id} type='project' input={project}>
                    {/* project.rooms_bookable ? 'Explore' : 'Not available' */}
                    <Link to={`/projects/${project.id}`} key={project.id} className="stacey-button reverse-hover">Explore</Link>
                  </Card>
                );
              })
            }
          </div>
          <div className="map-container" style={{width: '100%', height: '500px'}}>
            <GoogleMapReact
              defaultCenter={this.centerMap()}
              defaultZoom={12}
              bootstrapURLKeys={{ key: 'AIzaSyBCw-g1ofOTPw7H6Ub1wAe5cFSheaw-k7c' }}
              >
              {projects.map((project) => {
                return <Marker key={project.id} lat={project.marker.lat} lng={project.marker.lng} />
              })
              }
            </GoogleMapReact>
          </div>
        </div>
      </SimpleReactLightbox>
    )
  }
};

function mapStateToProps(state) {
  return {
    projects: state.projects
    // amenities: state.amenities
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchProjects }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(ProjectsIndex);
