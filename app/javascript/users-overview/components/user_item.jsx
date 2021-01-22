import React from 'react';
import moment from 'moment'


const UserItem = (props) => {
  return (
    <tr onClick={() => props.onClick()}>
      <td>{props.full_name}</td>
      <td>{props.email}</td>
      <td>{`${props.phone_code} ${props.phone_number}`}</td>
      <td>{props.application && moment(props.application.created_at).format('DD/MM/YYYY')}</td>
    </tr>
  )
}

export default UserItem;
