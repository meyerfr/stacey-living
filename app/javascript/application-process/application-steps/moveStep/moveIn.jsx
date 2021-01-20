import React, { Component } from 'react';
import Flatpickr from "react-flatpickr";
import { CSSTransition } from 'react-transition-group';

class MoveIn extends Component {
  constructor(props) {
    super(props)
    this.state = {
      options: {
        altInput: true,
        altFormat: "d.m.Y",
        dateFormat: "Y-m-d",
        placeholder: 'select a Date',
        locale: {
          firstDayOfWeek: 1 // start week on Monday
        },
        minDate: "today",
        position: "auto center"
      }
    }
  }

  render(){
    return (
      <div className="step-container moveIn-options-wrapper">
        <h3 className="underline step-header">When do you want to move?</h3>
        <div className="moveIn-options step-form-container">
          <span className="option step-form-item" onClick={this.props.changeMoveIn}>As soon as possible</span>
          <span className="option step-form-item" onClick={this.props.changeMoveIn}>30 days</span>
          <span className="option step-form-item" onClick={this.props.changeMoveIn}>60 days</span>
          <Flatpickr
            placeholder="select a Date"
            options={this.state.options}
            className='option step-form-item'
            onChange={this.props.changeMoveIn}
          />
        </div>
      </div>
    );
  }
}

export default MoveIn;
