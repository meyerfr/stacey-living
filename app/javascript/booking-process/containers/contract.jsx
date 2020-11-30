import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import ContractForm from './contract_form'
import ContractPdf from '../components/contract_pdf'

import { PDFViewer } from '@react-pdf/renderer';

import { fetchContract } from '../actions';


class Contract extends Component {
	componentDidMount(){
		this.props.fetchContract(this.props.match.params.booking_id)
	}

	render() {
    // console.log(this.props.contract ? true : false)
		return(
			<div className="contract-wrapper">
				{
					this.props.contract &&
					[
						<ContractForm key="ContractForm" booking_auth_token={this.props.match.params.booking_auth_token} booking_id={this.props.match.params.booking_id} />,
						<div key="ContractPdfWrapper" className="contract-pdf-wrapper">
	            <PDFViewer>
	              <ContractPdf contract={this.props.contract} />
	            </PDFViewer>
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
