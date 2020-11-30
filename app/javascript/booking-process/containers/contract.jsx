import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import { fetchContract, createUserAddress, updateUserAddress, createContract, updateContract } from '../actions';
import Spinner from 'react-bootstrap/Spinner';
import { PDFViewer, PDFDownloadLink } from '@react-pdf/renderer';

import ContractPdf from '../components/contract_pdf'

class Contract extends Component {
	constructor(props){
		super(props)
		this.state = {
      completed: false,
      userFormShow: true,
      contractFormShow: false,
      userForm: {
        street: '',
        zip: '',
        city: '',
        country: ''
      },
      contractForm: {
        id: props.contract ? props.contract.id : '',
        signature: props.contract ? props.contract.signature : ''
      }
		}
	}

  componentDidMount() {
  	this.props.fetchContract(this.props.match.params.booking_id);
  }

  // componentDidUpdate() {
  //   this.setState({
  //     userForm: {
  //       street: t,
  //       zip: '',
  //       city: '',
  //       country: ''
  //     },
  //     contractForm: {
  //       id: props.contract ? props.contract.id : '',
  //       signature: props.contract ? props.contract.signature : ''
  //     }
  //   })
  // }

  handleUserFormChange = () => {
    this.setState({
      userForm: {
        ...this.state.userForm,
        [event.target.name]: event.target.value
      }
    })
  }

  handleContractFormChange = () => {
    this.setState({
      contractForm: {
        ...this.state.userForm,
        [event.target.name]: event.target.value
      }
    })
  }

  changeForm = () => {
    this.setState({
      userFormShow: !this.state.userFormShow,
      contractFormShow: !this.state.contractFormShow
    })
  }

  componentDidUpdate(prevProps){
    if (prevProps.contract != this.props.contract) {
      const userAddress = (this.props.contract && this.props.contract.user.address) && this.props.contract.user.address
      if (userAddress) {
        this.setState({
          userForm: {
            street: userAddress.street,
            zip: userAddress.zip,
            city: userAddress.city,
            country: userAddress.country
          },
          contractForm: {
            id: this.props.contract ? this.props.contract.id : '',
            signature: this.props.contract ? this.props.contract.signature : ''
          }
        })
      }
    }
  }

  handleSubmit = () => {
    const contract = {id: this.props.contract.id, signature: this.state.contractForm.signature}
    const userAddress = {
      id: this.props.contract.user.address ? this.props.contract.user.address.id : null,
      street: this.state.contractForm.street,
      zip: this.state.contractForm.zip,
      city: this.state.contractForm.city,
      country: this.state.contractForm.country,
    }
    userAddress.id ?
      this.props.updateUserAddress(userAddress)
    :
      this.props.createUserAddress(this.props.contract.user.id, userAddress)

    setTimeout(() => {
      contract.id ?
        this.props.updateContract(contract)
      :
        this.props.createContract(this.props.match.params.booking_id, contract)
    }, 200)

    this.setState({
      completed: true,
      userFormShow: false,
      contractFormShow: false
    })
  }

  handleNextStep = () => {
    this.props.history.push(`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/payment`);
  }

  render () {
    const userForm = this.state.userForm
    const formFilledOut = (userForm.street && userForm.zip && userForm.city && userForm.country) ? true : false
    return (
      <div className="contract-wrapper">
        <div className="form-wrapper">
          <div className="form-info-container">
            <span className={this.state.completed ? "form-info not-completed hidden" : "form-info not-completed"}>
              Hi {this.props.contract && `${this.props.contract.user.first_name} ${this.props.contract.user.last_name}`}, <br/>
              Please complete the following information to generate the rental agreement.
            </span>
            <span className={this.state.completed ? "form-info completed" : "form-info completed hidden"}>
              Hi {this.props.contract && `${this.props.contract.user.first_name} ${this.props.contract.user.last_name}`}, <br/>
              Please complete the following information to generate the rental agreement.
            </span>
          </div>
          <div className="form-container">
            <div className={this.state.userFormShow ? "user-address-form-container" : "user-address-form-container hidden"}>
              {
                userForm &&
                [
                  <input
                    type="text"
                    placeholder="street..."
                    id="street-input"
                    name="street"
                    key="street"
                    className="form-control form-search"
                    value={userForm.street}
                    onChange={this.handleUserFormChange}
                  />,
                  <input
                    type="text"
                    placeholder="zip..."
                    id="zip-input"
                    name="zip"
                    key="zip"
                    className="form-control form-search"
                    value={userForm.zip}
                    onChange={this.handleUserFormChange}
                  />,
                  <input
                    type="text"
                    placeholder="city..."
                    id="city-input"
                    name="city"
                    key="city"
                    className="form-control form-search"
                    value={userForm.city}
                    onChange={this.handleUserFormChange}
                  />,
                  <input
                    type="text"
                    placeholder="country..."
                    id="country-input"
                    name="country"
                    key="country"
                    className="form-control form-search"
                    value={userForm.country}
                    onChange={this.handleUserFormChange}
                  />
                ]
              }
              <button className={formFilledOut ? "stacey-button" : "stacey-button hidden"} onClick={this.changeForm}>Next</button>
            </div>
            <div className={this.state.contractFormShow ? "contract-form-container" : "contract-form-container hidden"}>
              {
                this.state.contractForm &&
                <input
                  type="text"
                  placeholder="signature..."
                  id="signature-input"
                  name="signature"
                  className="form-control form-search"
                  value={this.state.contractForm.signature}
                  onChange={this.handleContractFormChange}
                />
              }
              <i className="fas fa-arrow-left back-arrow" onClick={this.changeForm}></i>
              <button className="stacey-button" onClick={this.handleSubmit}>Sign</button>
            </div>
            <div className={this.state.completed ? "completed" : 'completed hidden'}>
              <span>Perfect, you're contract is now generated and ready for you to download.</span>
               <PDFDownloadLink document={<ContractPdf />} fileName="stacey_rental_contract.pdf">
                {({ blob, url, loading, error }) => (loading ? 'Loading document...' : 'Download now!')}
              </PDFDownloadLink>
              <span>Plase proceed by clicking the button below.</span>
              <button className="stacey-button" onClick={this.handleNextStep}>Next Step</button>
            </div>
          </div>
        </div>

        <div className="contract-pdf-wrapper">
          {
            this.props.contract &&
            <PDFViewer>
              <ContractPdf contract={this.props.contract} />
            </PDFViewer>
          }
        <div>
      </div>
    </div>
  </div>
    )
  }
};

function mapStateToProps(state) {
  return {
    contract: state.contract
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchContract, createContract, updateContract, createUserAddress, updateUserAddress}, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Contract);
