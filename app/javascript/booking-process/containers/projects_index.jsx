import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

import { fetchProjects } from '../actions';
import Card from './card';
import Map from '../components/map'
import Spinner from 'react-bootstrap/Spinner';

class ProjectsIndex extends Component {
  componentDidMount() {
    this.props.fetchProjects();
  }

  render () {
    const projects = this.props.projects
    return (
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
                    <Link to={`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/projects/${project.id}/roomtypes`} key={project.id} className="stacey-button reverse-hover">Explore</Link>
                  </Card>
                );
              })
            }
          </div>
          {
            projects.length > 0 && <Map input={projects} />
          }
        </div>
    )
  }
};

function mapStateToProps(state) {
  return {
    projects: state.projects
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchProjects }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(ProjectsIndex);
