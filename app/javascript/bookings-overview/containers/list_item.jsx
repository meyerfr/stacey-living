import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import Modal from 'react-bootstrap/Modal'
import moment from 'moment'

class ListItem extends Component {
  render() {
  	let sortParamsKey = this.props.sortParams.key
    return (
    	<tr onClick={() => this.props.onClick()}>
		  	<td className={sortParamsKey === 'project_name' ? 'sorted' : ''}>{this.props.project_name}</td>
		  	<td className={sortParamsKey === 'roomtype_name' ? 'sorted' : ''}>{this.props.roomtype_name}</td>
		  	<td className={sortParamsKey === 'apartment_number' ? 'sorted' : ''}>{this.props.apartment_number}</td>
		  	<td className={sortParamsKey === 'room_number' ? 'sorted' : ''}>{this.props.room_number}</td>
		  	<td className={sortParamsKey === 'user_name' ? 'sorted' : ''}>{this.props.user_name}</td>
		  	<td className={sortParamsKey === 'move_in' ? 'sorted' : ''}>{moment(this.props.move_in).format('D MMM YY')}</td>
		  	<td className={sortParamsKey === 'move_out' ? 'sorted' : ''}>{moment(this.props.move_out).format('D MMM YY')}</td>
		</tr>  
    )
  }
}

function mapStateToProps(state) {
  return {
    sortParams: state.app.sortParams
  };
}

export default connect(mapStateToProps, null)(ListItem);
