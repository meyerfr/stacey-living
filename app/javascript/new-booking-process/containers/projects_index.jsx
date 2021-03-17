import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import Spinner from 'react-bootstrap/Spinner';

import { fetchProjects } from '../actions';

import ProgressNavbar from '../components/progress_navbar'
import Card from '../components/card';
import Map from '../components/map'

class ProjectsIndex extends Component {
  componentDidMount() {
    if (this.props.projects.length === 0) {
      this.props.fetchProjects();
    }
  }

  render () {
    const projects = this.props.projects
    return [
      <ProgressNavbar step={1} history={this.props.history} params={this.props.match.params} key="ProgressNavbar1" />,
      <div className="stacey-card-wrapper" key="ProjectIndex">
        <div className="banner">
          Where do you want to live next?
        </div>
        <div className="stacey-card-container">
          {
            projects.length === 0 ?
              <Spinner animation="border" role="status">
                <span className="sr-only">Loading...</span>
              </Spinner>
            :
              projects.map((project) => {
                return (
                  <Card key={project.id} type='project' input={project}>
                    {/* project.next_available_move_in ? 'Explore' : 'Not available' */}
                    <Link to={`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/projects/${project.id}/roomtypes`} key={project.id} className="stacey-button reverse-hover">Explore</Link>
                  </Card>
                );
              })
          }
        </div>
        {
          projects.length > 0 && <Map locations={projects} />
        }
      </div>
    ]
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
