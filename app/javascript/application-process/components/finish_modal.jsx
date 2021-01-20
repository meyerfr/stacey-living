import React from 'react';
import Modal from 'react-bootstrap/Modal'

const FinishModal = (props) => {
  return (
    <Modal
      show={props.show}
      // onHide={props.onHide}
      backdrop="static"
      size="lg"
      aria-labelledby="contained-modal-title-vcenter"
      centered
    >
      <div className="finish-apply-modal">
        <div className="finish-apply-modal-head">
          <span className="icon">🎉</span>
          <h2>Thanks for your Application</h2>
        </div>
        <div className="finish-apply-modal-body">
          <p>We are so excited to hear about your interest in becoming a part of the STACEY family! It looks like we do have availabilities across our locations for your selected move-in date</p>
          <div>
            <p><strong>So what is the next step?</strong></p>
            <p>To get started we will get back to you for a 10min call, in which you will get to know our Co-Living concept better and have a chance to ask all your questions.</p>
          </div>
          <p>If you do not get a call from us within the next 48h, please reply to the email we just send you or call +49 40 696389600.</p>
          <p>We are so excited to get to know you :)</p>
        </div>
        <div className="finish-apply-modal-actions">
          <a href="https://www.stacey.de/faq" className="stacey-button reverse-hover">Visit our <strong>FAQ</strong>s</a>
        </div>
      </div>
    </Modal>
  )
};

export default FinishModal
