import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

// import {loadStripe} from '@stripe/stripe-js';

// import {  } from '../actions';

// const stripePromise = loadStripe("pk_test_FSjxxtkIfO0UtESzFKdjLarS");
// Make sure to call `loadStripe` outside of a component’s render to avoid
// recreating the `Stripe` object on every render.

class Success extends Component {
	constructor(props) {
		super(props)
		this.state = {

		}
	}

	// componentDidMount() {
	// }

	// componentDidUpdate(prevProps) {
	// }

	render() {
		return(
			<div className="success-wrapper">
				<div className="header">
				</div>
				<div className="body">
					<p>
						We are looking forward to welcoming you at STACEY (Location) soon! The reservation of your suite can be found below.
					</p>
				</div>

			</div>
		)
	}
}

// function mapStateToProps(state) {
//   return {
//   };
// }

// function mapDispatchToProps(dispatch) {
//   return bindActionCreators({  }, dispatch);
// }

export default connect(null, null)(Success);
