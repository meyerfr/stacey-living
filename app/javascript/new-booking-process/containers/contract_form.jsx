import React, { Component } from 'react'
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { CSSTransition, TransitionGroup, SwitchTransition } from 'react-transition-group';
import Spinner from 'react-bootstrap/Spinner';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons'

import { signContract } from '../actions';

import SignContractFields from '../components/contract-steps/sign_contract_fields'
import UserAddressFields from '../components/contract-steps/user_address_fields'
import UpdateUserModal from './update_user_modal'

class ContractForm extends Component {
  constructor(props) {
    super(props)
    this.state = {
      step: 1,
      direction: 'next',
      formFilledOut: false,
      loading: true,
      showUserModal: false
    }
  }

  componentDidMount() {
    if (this.props.booking?.user) {
      this.setState({
        user: this.props.booking.user,
        contract: {
          signature: this.props.contract.signature,
          signedDate: this.props.contract.signedDate
        },
        loading: false
      })
    }
  }

  signContract = () => {
    this.props.signContract(
      this.state.contract,
      this.state.user,
      () => {
        this.setState({
          loading: false
        })
      }
    )
  }

  checkForm = (step) => {
    let formFilledOut = false
    if (step == 3) {
      this.setState({
        formFilledOut: true
      })
      return
    }

    if (step == 1) {
      const user = this.state.user
      const address = user.address
      formFilledOut = address.street.length > 3 && address.city.length > 2 && address.country.length > 3 && address.zip.length > 4
    } else if (step == 2) {
      const contract = this.state.contract
      formFilledOut = contract.signature.length > 0 ? true : false
    }
    this.setState({
      formFilledOut: formFilledOut
    })
  }

  nextStep = () => {
    const next_step = this.state.step + 1
    this.setState({
      step: next_step,
      direction: 'next',
      loading: true ? next_step == 3 : this.state.loading
    }, this.checkForm(next_step))
    if (next_step == 3) {
      this.signContract()
    }
  }

  prevStep = () => {
    this.setState({
      step: this.state.step - 1,
      direction: 'prev'
    }, this.checkForm(this.state.step - 1))
  }

  // to determine if fade left or right
  addClass = (node) =>{
    if (this.state.direction === 'prev') {
      node.classList.remove('next')
      node.classList.add('prev')
    } else{
      node.classList.add('next')
      node.classList.remove('prev')
    }
  }

  // enter = (node) => {
  // }

  // entering = (node) => {
  // }

  // exit = (node) => {
  // }

  // exiting = (node) => {
  // }

  updateUserAddressField = (event) => {
    this.setState({
      user: {
        ...this.state.user,
        address: {
          ...this.state.user.address,
          [event.target.name]: event.target.value
        }
      }
    }, this.checkForm(this.state.step))
  }

  updateContractField = (event) => {
    this.setState({
      contract: {
        ...this.state.contract,
        [event.target.name]: event.target.value
      }
    }, this.checkForm(this.state.step))
  }

  renderFormActions = () => {
    const step = this.state.step
    let text = ''
    if (step == 1) {
      text = 'Next'
    } else if (step == 2) {
      text = 'Sign'
    } else {
      text = 'Continue'
    }

    return (
      <button key="formAction" disabled={!this.state.formFilledOut} onClick={this.state.step < 3 ? this.nextStep : this.finishContract} className="stacey-button reverse-hover">
        {text}
      </button>
    )
  }

  finishContract = () => {
    this.props.history.push(`/bookings/${this.props.params.booking_auth_token}/${this.props.params.booking_id}/payment/`);
  }

  toggleUserModal = () => {
    this.setState({
      showUserModal: !this.state.showUserModal
    })
  }

  render() {
    const user = this.state.user
    const contract = this.state.contract
    const steps = [
      { number: 1, name: 'Address', component: <UserAddressFields key={1} user={this.state.user} updateUserAddressField={this.updateUserAddressField} /> },
      { number: 2, name: 'Contract', component: <SignContractFields key={2} contract={contract} updateContractField={this.updateContractField} /> },
      { number: 3, name: 'Complete', component: <div key={3}><span>Perfect, you're contract is now generated and ready for you to download.</span></div> },
    ]

    return[
      <div className="form-wrapper" key="formWrapper">
        <div className="form-info-container">
          {
            this.state.loading == false ?
              <span className={"form-info not-completed"}>
                Hi {contract && `${user?.first_name} ${user?.last_name}`}, <br/>
                Please complete the following information to generate the rental agreement.
              </span>
            :
              <div className="spinner">
                <Spinner animation="border" role="status">
                  <span className="sr-only">Loading...</span>
                </Spinner>
                <span>Loading Contract...</span>
              </div>
          }
          <button className="stacey-button" onClick={this.toggleUserModal}>Change Personal Data</button>
          {
            this.state.step > 1 &&
            <FontAwesomeIcon icon={faArrowLeft} onClick={this.prevStep} />
            // <span className="back-button" onClick={this.prevStep}>
          }
        </div>
        {
          user &&
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
                <div className={`form-container${this.state.step === 1 ? ' larger' : ''}`}>
                  {
                    [
                      steps.map(({ number, name, component}) => {
                        if (this.state.step == number) {
                          return component
                        }
                      }),
                      this.renderFormActions()
                    ]
                  }
                </div>
              </CSSTransition>
            </SwitchTransition>
        }
      </div>,
      <UpdateUserModal key="UpdateUserModal" show={this.state.showUserModal} closeModal={this.toggleUserModal} />
    ]
  }
}

function mapStateToProps(state) {
  return {
    contract: state.contract,
    booking: state.booking
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ signContract }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(ContractForm);
