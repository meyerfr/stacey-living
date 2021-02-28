import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import ContractForm from './contract_form'
import ContractPdf from '../components/contract_pdf'

import Spinner from 'react-bootstrap/Spinner';
import { BlobProvider, PDFViewer } from '@react-pdf/renderer';

import { fetchContract } from '../actions';


class Contract extends Component {
	constructor(props) {
		super(props);
		this.state = {
			loadingDocument: true
		}
	}
	componentDidMount(){
		this.props.fetchContract(this.props.match.params.booking_auth_token, this.props.match.params.booking_id)
	}

	handleNextStep = () => {
    this.props.history.push(`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/payment`);
  }

  renderContract(loading) {
  	return (
	    <div className="contract">
	      {!loading
	        ? <PDFViewer><ContractPdf contract={this.props.contract} /></PDFViewer>
	        : <div className="spinner">
	        		<Spinner animation="border" role="status">
	        			<span className="sr-only">Loading...</span>
	        		</Spinner>
	        		<span>Loading Contract...</span>
	        	</div>
	      }
	    </div>
	  );
  }

	render() {
    // console.log(this.props.contract ? true : false)
		return(
			<div className="contract-wrapper">
				{
					this.props.contract &&
					[
						<ContractForm key="ContractForm" handleNextStep={this.handleNextStep} booking_id={this.props.match.params.booking_id} booking_auth_token={this.props.match.params.booking_auth_token} />,
						<div key="ContractPdfWrapper" className="contract-pdf-wrapper">
							 <BlobProvider document={<ContractPdf contract={this.props.contract} />}>
					      {({ blob, url, loading, error }) => {
					        // Do whatever you need with blob here
                  return this.renderContract(loading)
					      }}
					    </BlobProvider>
	        	</div>
					]
				}
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
  return bindActionCreators({ fetchContract }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Contract);
