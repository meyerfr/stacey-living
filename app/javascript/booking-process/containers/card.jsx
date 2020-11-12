import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { fetchAmenities } from '../actions';
import SimpleReactLightbox, { SRLWrapper } from "simple-react-lightbox";
import Spinner from 'react-bootstrap/Spinner';

class Card extends Component {
	constructor(props) {
		super(props)
		this.state = {
			amenities: []
		}
	}

	componentDidMount() {
		const url = `http://localhost:3000/api/v1/amenities?type=${this.props.type}&type_id=${this.props.input.id}`
		fetch(url)
			.then(res => res.json())
	  		.then(data => this.setState({amenities: data}))
	}

	openLightbox = () => {
		event.target.previousElementSibling.children[0].click()
	}

	render() {
		const input = this.props.input
		const amenities = this.state.amenities
		// console.log(amenities)
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
			<SimpleReactLightbox key={input.id}>
		  	<div key={input.id} className="stacey-card">
		  		{
		  			photos === undefined ?
						<div className="no-photos" key="nophotos">No photos yet</div>
					:
						<div className="stacey-card-photos">
							<SRLWrapper options={options}>
								{photos.map((photo, index) => {
					        		return <img key={`${input.name}${index}`} src={photo} alt={index}/>
							  	})}
						  	</SRLWrapper>
					  		<i className="far fa-image photo-aligned"
						  		key={`camera${input.id}`}
						  		onClick={() => this.openLightbox()}
					  		></i>
						  <div className="available photo-aligned">
						  	<span className='bolder'>Available</span>
						  	<span>{input.next_available_move_in}</span>
						  </div>
						</div>
		  		}
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
								this.props.type === 'project' ?
									amenities.map((amenity) => {
										return (
											<div className="amenity" key={amenity.id}>
												{amenity.photo ? <img src={amenity.photo} alt="photo" className='photo large bordered' /> : <i className="fa fa-user img-prev"></i>}
												<span>{amenity.title}</span>
											</div>
										);
									})
								:
									[
										amenities.roomtype_index_inventory_amenities.map((amenity) => {
											return (
												<div className="amenity" key={amenity.id}>
													{amenity.photo ? <img src={amenity.photo} alt="photo" className='photo large bordered' /> : <i className="fa fa-user img-prev"></i>}
													<span>{amenity.title}</span>
												</div>
											);
										}),
										amenities.roomtype_index_inclusion_amenities.map((amenity) => {
											return (
												<div className="amenity" key={amenity.id}>
													{amenity.photo ? <img src={amenity.photo} alt="photo" className='photo large bordered' /> : <i className="fa fa-user img-prev"></i>}
													<span>{amenity.title}</span>
												</div>
											);
										}),
									]
				    }
					</div>
			  	{this.props.children}
		    </div>
		  </SimpleReactLightbox>
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
