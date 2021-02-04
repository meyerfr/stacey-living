import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import { PDFDownloadLink } from '@react-pdf/renderer';

import ContractPdf from '../components/contract_pdf'

import { fetchContract } from '../actions';

// import {loadStripe} from '@stripe/stripe-js';

// const stripePromise = loadStripe("pk_test_FSjxxtkIfO0UtESzFKdjLarS");
// Make sure to call `loadStripe` outside of a component’s render to avoid
// recreating the `Stripe` object on every render.

class Success extends Component {
	constructor(props) {
		super(props)
		this.state = {

		}
	}

	componentDidMount() {
		this.props.fetchContract(this.props.match.params.booking_auth_token, this.props.match.params.booking_id)
	}

	// componentDidUpdate(prevProps) {
	// }

	render() {
		return(
			<div className="success-wrapper">
				<div className="success-container">
					<div className="header">
						<i>!</i>
						<h3>Just one more step left.</h3>
					</div>
					<div className="body">
						<span>
							We are looking forward to welcoming you at STACEY {this.props.contract?.project_name} soon!
						</span>
						<span className="important">The only step that's missing now is for you to send your Deposit to the following Account.</span>
						<div className="account-info important">
              <span>STACEY Real Estate UG</span>
              <span>Amount: {(this.props.contract?.price_per_month * 2).toFixed(0)} €</span>
              <span>IBAN: DE61 2005 0550 1500 8679 06</span>
              <span>BIC: HASPDEHHXXX</span>
            </div>

						<span>You can find all the information regarding your reservation in your email inbox. (Please check your spam ordner if you can't find the email)</span>
						<div className="d-grid">
							<span>Furthermore you have another chance to Download the Rental Agreement you just signed here:</span>
							{
								this.props.contract &&
								<PDFDownloadLink document={<ContractPdf contract={this.props.contract} />} fileName="stacey_rental_contract.pdf">
	                {({ blob, url, loading, error }) => (loading ? 'Loading document...' : 'Download Rental Agreement!')}
	              </PDFDownloadLink>
							}
						</div>
					</div>
					<div className="footer">
						<span>
							We are so excited to welcome you as our new member and for you to meet our amazing community.
						</span>
						<span className="smaller">If you have anything else you would like to ask or talk about, please don't hesitate to contact us: <a href={"mailto:team@stacey-living.de"}>team@staces-living.de</a></span>
					</div>
				</div>
			</div>
		)
	}
}

function mapStateToProps(state) {
  return {
  	contract: state.contract
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchContract }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Success);
