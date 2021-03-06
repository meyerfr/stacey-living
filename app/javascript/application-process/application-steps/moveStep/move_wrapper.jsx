import React, { Component } from 'react';
import Flatpickr from "react-flatpickr";
import PhoneInput from 'react-phone-number-input';
import { CSSTransition, TransitionGroup, SwitchTransition } from 'react-transition-group';
import moment from 'moment';

import MoveIn from './moveIn';
import MoveOut from './moveOut';
import Contact from './contact';

class MoveWrapper extends Component {
  constructor(props){
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
      },
      step: 1,
      move_in: '',
      move_out: '',
      entered: true
    }
  }

  nextStep = () => {
    // window.scroll({
    //   top: 0,
    //   left: 0,
    //   behavior: 'smooth'
    // });
    this.setState({step: this.state.step + 1})
  }

  changeMoveIn = (event) => {
    this.nextStep()
    this.setState({
      move_in: event.target ? event.target.innerText : moment(event[0]).format('DD/MM/YYYY')
    })
  }

  changeMoveOut = (event) => {
    this.nextStep()
    this.setState({
      move_out: event.target.innerText
    })
  }

  updateApplicant = event => {
    this.setState({
      [event.target.name]: event.target.value
    })
  }

  finishAppplication = (applicant) => {
    const application_data = {...{move_in: this.state.move_in, move_out: this.state.move_out}, ...applicant}
    this.props.finishAppplication(application_data)
    // this.props.changeMoveData(this.state.move_in, this.state.move_out)
  }

  range = (start, end) => {
    return Array(end - start + 1).fill().map((_, idx) => start + idx)
  }

  addClass = (node) =>{
    if (this.state.direction === 'prev') {
      node.classList.remove('next')
      node.classList.add('prev')
    } else{
      node.classList.add('next')
      node.classList.remove('prev')
    }
  }

  render() {
    const step = this.state.step
    const steps = [
      { number: 1, name: 'MoveIn', component: <MoveIn key="1step" changeMoveIn={this.changeMoveIn} /> },
      { number: 2, name: 'MoveOut', component: <MoveOut key="2step" changeMoveOut={this.changeMoveOut} /> },
      { number: 3, name: 'Contact', component: <Contact key="3step" updateApplicant={this.updateApplicant} finishAppplication={this.finishAppplication} loading={this.props.loading} /> },
    ]
    return (
      <div className="move-wrapper step-wrapper">
        <div style={{backgroundSize: 'cover', zIndex: "10", backgroundImage: `linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.2)),  url('${this.props.selectedLocation ? this.props.selectedLocation.imageUrl : "https://res.cloudinary.com/dvuqwvjay/image/upload/v1607077627/community_area_muehlenkamp.jpg"}')` }}></div>
        <SwitchTransition>
          <CSSTransition
            key={this.state.step}
            addEndListener={(node, done) => {
              node.addEventListener("transitionend", done, false);
            }}
            onEnter={(node) => this.addClass(node)}
            onEntering={(node) => this.addClass(node)}
            onExit={(node) => this.addClass(node)}
            onExiting={(node) => this.addClass(node)}
            classNames={`${this.state.direction} fade`}
          >
            <div className={`step-container`}>
              {
                steps.map(({ number, name, component}) => {
                  if (this.state.step == number) {
                    return component
                  }
                })
              }
            </div>
          </CSSTransition>
        </SwitchTransition>
      </div>
    );
  }
}

{
  // <MoveIn in={step == 1} position={step > 1 ? 'left' : ''} changeMoveIn={this.changeMoveIn} />
  // <MoveOut in={step == 2} position={step > 2 ? 'left' : step < 2 && 'right'} changeMoveOut={this.changeMoveOut} />
  // <Contact in={step == 3} position={step > 3 ? 'left' : step < 3 && 'right'} updateApplicant={this.updateApplicant} />
}

export default MoveWrapper;
