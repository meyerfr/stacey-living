import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { fetchAmenities } from '../actions';
import { SRLWrapper } from "simple-react-lightbox";
import Spinner from 'react-bootstrap/Spinner';

class Card extends Component {
	constructor(props) {
		super(props)
		this.state = {
			amenities: []
		}
	}

	componentDidMount() {
		fetch(`http://localhost:3000/api/v1/projects/${this.props.input.id}/amenities`)
			.then(res => res.json())
	  		.then(data => this.setState({amenities: data}))
	}

	render() {
		const input = this.props.input
		const amenities = this.state.amenities
		const photos = this.props.input.photos
		// console.log(photos[0]);
		const options = {
		  	buttons: {
			    showDownloadButton: false,
			    showNextButton: true,
			    showPrevButton: true,
			    size: '40px'
		  	},
		  	caption: {
		  		showCaption: false
		  	}
		}
		return (
		  	<div key={input.id} className="stacey-card">
		  		{
		  			photos.length === 0 ?
						<div className="no-photos" key="nophotos">No photos yet</div>
					:
						<div className="stacey-card-photos">
							<SRLWrapper options={options}>
								{photos.map((photo, index) => {
							        return <img key={`${input.name}${index}`} src={photo} alt={index}/>
							    })}
						    </SRLWrapper>
						</div>
		  		}
				{/* <LightBox images={project.images} /> */}
				<div className="stacey-card-header">
					<div className="name">
						<span>STACEY</span>
						<span>{input.name}</span>
					</div>
					<span className="price">
					  from €{input.cheapest_price}
					</span>
				</div>
				<div className="stacey-card-amenities">
					{
			        	amenities.length === 0 ?
				   //      	<Spinner animation="border" role="status">
							//   <span className="sr-only">Loading...</span>
							// </Spinner>
							<div className="no-amenities" key="noamenities">No amenities yet</div>
						:
						amenities.map((amenity) => {
							return (
								<div className="amenity" key={amenity.id}>
									{amenity.photo ? <img src={amenity.photo} alt="photo" className='photo large bordered' /> : <i className="fa fa-user img-prev"></i>}
									<span>{amenity.title}</span>
								</div>
							);
						})
			        }
				</div>
			  	{this.props.children}
		    </div>
		);
	}
}

// function mapStateToProps(state) {
// 	return {
// 		amenities: []
// 	};
// }

// function mapDispatchToProps(dispatch) {
// 	return bindActionCreators({ fetchAmenities }, dispatch);
// }

export default Card;
