import React from 'react';
import { CSSTransition } from 'react-transition-group';

const MoveOut = ({ in: inProp, changeMoveOut: changeMoveOut }) => {
  return (
    <div className="step-container moveIn-options-wrapper">
      <h3 className="underline step-header">How long are you going to stay?</h3>
      <div className="moveIn-options step-form-container">
        <span className="option step-form-item" onClick={changeMoveOut}>3-5 Months</span>
        <span className="option step-form-item" onClick={changeMoveOut}>6-8 Months</span>
        <span className="option step-form-item" onClick={changeMoveOut}>9-12 Months</span>
        <span className="option step-form-item" onClick={changeMoveOut}>Forever</span>
      </div>
    </div>
  );
};

export default MoveOut;
