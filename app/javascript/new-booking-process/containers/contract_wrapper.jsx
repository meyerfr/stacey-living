import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import ProgressNavbar from '../components/progress_navbar'
import ContractPdfContainer from './contract_pdf_container'
import ContractForm from './contract_form'

import { fetchProjects, fetchRoomtypes } from '../actions';

class ContractWrapper extends Component {
  // constructor(props){
  //   super(props)
  //   this.state = {
  //     loading: true
  //   }
  // }

  componentDidMount(){
    // this.setState({
    //   user: this.props.booking.user
    // })
    if (this.props.projects.length == 0) {this.props.fetchProjects()}
    if (this.props.roomtypes.length == 0) {this.props.fetchRoomtypes(this.props.match.params.booking_id)}
    // this.setState({
    //   loading: false
    // })
    // this.props.fetchContract(this.props.match.params.booking_auth_token, this.props.match.params.booking_id)
    // this.props.fetchUser(this.props.booking.user_id)
  }

  render() {
    // console.log('state', this.state.loading)
    return[
      <ProgressNavbar step={3} key="ProgressNavbar3" />,
      <div className="contract-wrapper" key="ContractWrapper">
        <ContractForm project_id={this.props.match.params.project_id} roomtype_id={this.props.match.params.roomtype_id} params={this.props.match.params} history={this.props.history} />
        <ContractPdfContainer project_id={this.props.match.params.project_id} roomtype_id={this.props.match.params.roomtype_id} />
      </div>
    ]
  }
}

function mapStateToProps(state) {
  return {
    projects: state.projects,
    roomtypes: state.roomtypes
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchProjects, fetchRoomtypes }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(ContractWrapper);
