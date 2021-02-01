import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import UserItem from '../components/user_item'
import UserModal from './user_modal'

import { fetchUsers, applyFilter } from '../actions';

class UsersList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      visible: false,
      user: null
    }
  }

  fetchUsers = (page = null) => {
    console.log(page)
    this.props.fetchUsers(page, 'applicants', 'role')
  }

  componentDidMount() {
    this.fetchUsers();
  }

  openModal = (user) => {
    this.setState({
      visible: true,
      user: user
    })
  }

  closeModal = () => {
    this.setState({
      visible: false,
      user: null,
      edit: false
    })
  }

  handleHeaderClick = (sortKey) => {
    let currentlyActiveSortedHeader = event.target.parentElement.querySelector('.active');
    if (currentlyActiveSortedHeader && event.target != currentlyActiveSortedHeader) {
      currentlyActiveSortedHeader.classList.remove('active')
    }
    this.props.setSortParams(sortKey);
    event.target.classList.add('active');
  }

  handleChange = (event) => {
    if (window.confirm(`Are you sure you wish to change the user state to ${event.target.selectedOptions[0].value}?`)){
      console.log(event.target.selectedOptions[0].value)
      let user = {
        state: event.target.selectedOptions[0].value
      }
      this.props.updateUser(
        this.state.user.id,
        user
      )
    }
  }

  handleSave = (event) => {
    if (window.confirm(`Are you sure you wish to update the User properties?`)){
      let user = {
        move_in: this.state.user.move_in,
        move_out: this.state.user.move_out,
        phone_number: this.state.user.phone_number,
      }
      this.props.updateUser(
        this.state.user.id,
        user
      )
    }
  }

  updateBookingState = (event) => {
    this.setState({
      user: {
        ...this.state.user,
        [event.target.name]: event.target.value
      }
    })
  }

  render() {
    const user = this.state.user

    var users = this.props.users.slice(0);
    // byDate = byDate.sort(function(a,b) {
    //     return a.application.created_at - b.application.created_at;
    // });

    // byDate = byDate.sortBy(function(o){ return new Date( o.application.created_at ) });
    users = users.sort(function(a, b) {
      if (a.application && b.application) {
        var c = new Date(a.application.created_at);
        var d = new Date(b.application.created_at);
      } else{
        var c = new Date(a.created_at);
        var d = new Date(b.created_at);
      }
      return d-c;
    });

    return (
      <div className="table-container">
        <table className="list-container">
          <thead>
            <tr>
              <th>Name</th>
              <th>Email</th>
              <th>Phone</th>
              <th>Applied</th>
            </tr>
          </thead>
          <tbody>
            {
              users.length > 0 && users.map((user) => {
                return <UserItem key={user.id} onClick={() => this.openModal(user)} {...user} />;
              })
            }
          </tbody>
        </table>
        {
          user &&
            <UserModal user={this.state.user} onHide={this.closeModal} visible={this.state.visible} />
        }
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    users: state.users
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchUsers, applyFilter }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(UsersList);
