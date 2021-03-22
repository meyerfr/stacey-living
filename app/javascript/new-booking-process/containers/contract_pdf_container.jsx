import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import Spinner from 'react-bootstrap/Spinner';
import { BlobProvider, PDFViewer } from '@react-pdf/renderer';

import ContractPdfDocument from '../components/contract_pdf_document'

class ContractPdfContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      loadingDocument: true
    }
  }

  render() {
    return(
      this.props.roomtype ?
        <div className="contract-pdf-wrapper">
          {
            <BlobProvider document={<ContractPdfDocument contract={this.props.contract} booking={this.props.booking} project={this.props.project} roomtype={this.props.roomtype} />}>
              {({ blob, url, loading, error }) => {
                return (
                  <div className="contract">
                    {
                      loading && this.props.loading ?
                        <div className="spinner">
                          <Spinner animation="border" role="status">
                            <span className="sr-only">Loading...</span>
                          </Spinner>
                          <span>Loading Contract...</span>
                        </div>
                      :
                        <PDFViewer><ContractPdfDocument contract={this.props.contract} booking={this.props.booking} project={this.props.project} roomtype={this.props.roomtype} /></PDFViewer>
                    }
                  </div>
                )
              }}
            </BlobProvider>
          }
        </div>
      :
        <span>Contract not Loaded</span>
    )
  }
};

function mapStateToProps(state, ownProps) {
  const projectId = parseInt(ownProps.project_id);
  const roomtypeId = parseInt(ownProps.roomtype_id);
  return {
    contract: state.contract,
    booking: state.booking,
    project: state.projects.find((project) => project.id === projectId),
    roomtype: state.roomtypes.find((roomtype) => roomtype.id === roomtypeId)
  };
}

export default connect(mapStateToProps, null)(ContractPdfContainer);
