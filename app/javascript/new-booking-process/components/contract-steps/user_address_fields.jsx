import React, { Component } from 'react'

const UserAddressFields = (props) => {
  const address = props.user.address
  const inputs = [
    { name: 'street & number', component: <input autoFocus type="text" placeholder="street & number" id="street-input" name="street" key="street" className="form-control form-search" value={address?.street || ''} onChange={props.updateUserAddressField} /> },
    { name: 'city', component: <input type="text" placeholder="city..." id="city-input" name="city" key="city" className="form-control form-search" value={address?.city || ''} onChange={props.updateUserAddressField} /> },
    { name: 'zip', component: <input type="text" placeholder="zip code..." id="zip-input" name="zip" key="zip" className="form-control form-search" value={address?.zip || ''} onChange={props.updateUserAddressField} /> },
    { name: 'country', component: <input type="text" placeholder="country..." id="country-input" name="country" key="country" className="form-control form-search" value={address?.country || ''} onChange={props.updateUserAddressField} /> }
  ]
  return(
    <div className="user-address-form-container">
      {
        inputs.map(({name, component}) => {
          return component
        })
      }
    </div>
  )
}

export default UserAddressFields;
