import React from 'react';

const UserItem = (props) => {
  return (
    <tr onClick={() => props.onClick()}>
      <td>{props.full_name}</td>
      <td>{props.email}</td>
      <td>{`${props.phone_code} ${props.phone_number}`}</td>
    </tr>
  )
}

export default UserItem;
