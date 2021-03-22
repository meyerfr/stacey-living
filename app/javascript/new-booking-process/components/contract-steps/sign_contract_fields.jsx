import React, { Component } from 'react'

const SignContractFields = (props) => {
  const contract = props.contract
  return[
    <input
      type="hidden"
      id="signed_date-input"
      name="signed_date"
      key="signed_date"
      className="form-control form-search"
      value={contract.signed_date || ''}
      onChange={props.updateContractField}
    />,
    <input
      type="text"
      autoFocus
      placeholder="signature..."
      id="signature-input"
      name="signature"
      key="signature"
      className="form-control form-search"
      value={contract.signature || ''}
      onChange={props.updateContractField}
    />
  ]
}

export default SignContractFields;
