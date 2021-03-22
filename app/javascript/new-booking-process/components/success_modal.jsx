import React from 'react';
import Modal from 'react-bootstrap/Modal'

const SuccessModal = (props) => {
  return (
    <Modal
      show={props.show}
      // onHide={props.onHide}
      backdrop="static"
      size="lg"
      aria-labelledby="contained-modal-title-vcenter"
      centered
    >
      <div className="finish-apply-modal" style={{padding: '1rem 1rem 2rem'}}>
        <div className="finish-apply-modal-head">
          <span className="icon">🎉</span>
          <h2>Just one more step left!</h2>
        </div>
        <div className="finish-apply-modal-body">
          <p>We are looking forward to welcoming you at STACEY {props.project_name} soon!</p>
          <div>
            <p><strong>The only step that's missing now is for you to send your Deposit to the following Account.</strong></p>
            <table>
              <tbody>
                <tr>
                  <th>Account Name</th>
                  <td>STACEY Real Estate GmbH</td>
                </tr>
                <tr>
                  <th>Amount</th>
                  <td>{(props.price?.amount * 2).toFixed(0)} €</td>
                </tr>
                <tr>
                  <th>IBAN</th>
                  <td>DE61 2005 0550 1500 8679 06</td>
                </tr>
                <tr>
                  <th>BIC</th>
                  <td>HASPDEHHXXX</td>
                </tr>
              </tbody>
            </table>
            <p style={{marginTop: 5, fontSize: 12}}>You can find all the information regarding your reservation in your email inbox. (Please check your spam ordner if you can't find the email)</p>
          </div>
          <p>We are so excited to welcome you as our new member and for you to meet our amazing community.</p>
          If you have anything else you would like to ask or talk about, please don't hesitate to contact us: <a href={"mailto:team@stacey-living.de"}>team@staces-living.de</a>
        </div>
      </div>
    </Modal>
  )
};

export default SuccessModal
