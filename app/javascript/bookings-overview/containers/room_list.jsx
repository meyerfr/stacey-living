import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import ListItem from './list_item'
import { setSortParams, applyFilter } from '../actions';
import Modal from 'react-awesome-modal'
import moment from 'moment'

class RoomList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      visible: false,
      booking: null
    }
  }

  openModal = (booking) => {
    console.log(booking)
    this.setState({
      visible: true,
      booking: booking
    })
  }

  closeModal = () => {
    this.setState({
      visible: false,
      booking: null
    })
  }

  handleHeaderClick = (sortKey) => {
    console.log(event.target.parentElement);
    let currentlyActiveSortedHeader = event.target.parentElement.querySelector('.active');
    if (currentlyActiveSortedHeader && event.target != currentlyActiveSortedHeader) {
      currentlyActiveSortedHeader.classList.remove('active')
    }
    this.props.setSortParams(sortKey);
    event.target.classList.add('active');
  }

  render() {
    return (
      <div className="table-container">
        <table className="list-container">
          <thead>
            <tr>
              <th className={this.props.sortParams.key === 'project_name' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("project_name")}>Location</th>
              <th className={this.props.sortParams.key === 'roomtype_name' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("roomtype_name")}>Category</th>
              <th className={this.props.sortParams.key === 'apartment_number' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("apartment_number")}>Apartment</th>
              <th className={this.props.sortParams.key === 'room_number' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("room_number")}>Number</th>
              <th className={this.props.sortParams.key === 'user_name' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("user_name")}>Tenant</th>
              <th className={this.props.sortParams.key === 'move_in' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("move_in")}>Move In</th>
              <th className={this.props.sortParams.key === 'move_out' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("move_out")}>Move Out</th>
            </tr>
          </thead>
          <tbody>
            {
              this.props.bookings.map((booking) => {
                return <ListItem key={booking.id} onClick={() => this.openModal(booking)} {...booking} />;
              })
            }
          </tbody>
        </table>
        <Modal 
            visible={this.state.visible}
            width="90%"
            effect="fadeInUp"
            onClickAway={() => this.closeModal()}>
            {
              this.state.booking ?
                <div className="modal-container">
                  <h1 id="modal-title">{this.state.booking.user_name}</h1>
                  <table className="modal-content">
                    <tbody>
                      <tr>
                        <td>Move In:</td>
                        <td>{moment(this.state.booking.move_in).format('Do MMMM YYYY')}</td>
                      </tr>
                      <tr>
                        <td>Move Out:</td>
                        <td>{moment(this.state.booking.move_out).format('Do MMMM YYYY')}</td>
                      </tr>
                      <tr>
                        <td>Location:</td>
                        <td>{this.state.booking.project_name}</td>
                      </tr>
                      <tr>
                        <td>Roomtype:</td>
                        <td>{this.state.booking.roomtype_name}</td>
                      </tr>
                      <tr>
                        <td>Room:</td>
                        <td>{this.state.booking.room_number}</td>
                      </tr>
                      <tr>
                        <td>Phone:</td>
                        <td>{this.state.booking.phone}</td>
                      </tr>
                      <tr>
                        <td>Booking Id:</td>
                        <td>{this.state.booking.id}</td>
                      </tr>
                    </tbody>
                  </table>
                  <a href="" onClick={() => this.closeModal()}>Close</a>
                </div>
              :
                <h1>Nothing Slected</h1>
            }
        </Modal>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    bookings: state.app.bookings,
    sortParams: state.app.sortParams
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ setSortParams, applyFilter }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(RoomList);
