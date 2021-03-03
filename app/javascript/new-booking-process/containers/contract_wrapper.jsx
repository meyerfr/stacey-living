import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

// import ContractForm from './contract_form';
import ContractPdfDocument from '../components/contract_pdf_document';

import Spinner from 'react-bootstrap/Spinner';
import { BlobProvider, PDFViewer } from '@react-pdf/renderer';

import { fetchProjects, fetchRoomtypes, signContract } from '../actions';

class ContractWrapper extends Component {
  constructor(props) {
    super(props);
    this.state = {
      loadingDocument: true
    }
  }

  componentDidMount(){
    // this.setState({
    //   user: this.props.booking.user
    // })
    if (this.props.projects.length == 0) {this.props.fetchProjects()}
    if (this.props.roomtypes.length == 0) {this.props.fetchRoomtypes(this.props.match.params.booking_id)}
    // this.props.fetchContract(this.props.match.params.booking_auth_token, this.props.match.params.booking_id)
    // this.props.fetchUser(this.props.booking.user_id)
  }

  signContract = () => {
    const contract = {
      signature: this.state.contract.signature,
      signedDate: this.state.contract.signedDate
    }
    if (this.props.projects.length === 0) { this.props.fetchProjects() }
    if (this.props.roomtypes.length === 0) { this.props.fetchRoomtypes(this.props.match.params.project_id) }
    this.props.signContract(contract)
    this.props.history.push(`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/payment`);
  }

  // renderContract(loading) {
  //   return (
  //     <div className="contract">
  //       {!loading
  //         ? <PDFViewer><ContractPdf contract={this.props.contract} /></PDFViewer>
  //         : <div className="spinner">
  //             <Spinner animation="border" role="status">
  //               <span className="sr-only">Loading...</span>
  //             </Spinner>
  //             <span>Loading Contract...</span>
  //           </div>
  //       }
  //     </div>
  //   );
  // }



  render() {
    console.log(this.props.roomtypes)
    return(
      <div className="contract-wrapper">
        {
          // <ContractForm />
        }
        <div className="form-wrapper">
        </div>
        {
          this.props.roomtype &&
          <div className="contract-pdf-wrapper">
            <BlobProvider document={<ContractPdfDocument contract={this.props.contract} booking={this.props.booking} project={this.props.project} roomtype={this.props.roomtype} />}>
              {({ blob, url, loading, error }) => {
                return (
                  <div className="contract">
                    {
                      !loading ?
                        <PDFViewer><ContractPdfDocument contract={this.props.contract} booking={this.props.booking} project={this.props.project} roomtype={this.props.roomtype} /></PDFViewer>
                      :
                        <div className="spinner">
                          <Spinner animation="border" role="status">
                            <span className="sr-only">Loading...</span>
                          </Spinner>
                          <span>Loading Contract...</span>
                        </div>
                    }
                  </div>
                )
              }}
            </BlobProvider>
          </div>
        }
      </div>
    )
  }
};

function mapStateToProps(state, ownProps) {
  const projectId = parseInt(ownProps.match.params.project_id);
  const roomtypeId = parseInt(ownProps.match.params.roomtype_id);
  return {
    contract: state.contract,
    booking: state.booking,
    projects: state.projects,
    project: state.projects.find((project) => project.id === projectId),
    roomtypes: state.roomtypes,
    roomtype: state.roomtypes.find((roomtype) => roomtype.id === roomtypeId)
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ signContract, fetchProjects, fetchRoomtypes }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(ContractWrapper);
