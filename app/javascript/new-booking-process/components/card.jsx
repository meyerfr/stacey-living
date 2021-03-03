import React, { Component } from 'react';
import SimpleReactLightbox, { SRLWrapper } from "simple-react-lightbox";
import Spinner from 'react-bootstrap/Spinner';
import moment from 'moment'

export default class Card extends Component {
  openLightbox = () => {
    event.target.previousElementSibling.children[0].click()
  }

  render() {
    const input = this.props.input
    const amenities = this.props.input.amenities
    const photos = this.props.input.photos
    const lightboxOptions = {
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

    return(
      <SimpleReactLightbox key={input.id}>
        <div key={input.id} className="stacey-card">
          {
            photos === undefined ?
            <Spinner animation="border" role="status">
              <span className="sr-only">Loading...</span>
            </Spinner>
          :
            <div className="stacey-card-photos">
              <SRLWrapper options={lightboxOptions}>
                {
                  photos.map((photo, index) => {
                    return <img key={`${input.name}${index}`} src={photo} alt={index}/>
                  })
                }
                </SRLWrapper>
                <i className="far fa-image photo-aligned"
                  key={`camera${input.id}`}
                  onClick={() => this.openLightbox()}
                ></i>
              <div className="available photo-aligned">
                <span className='bolder'>Available</span>
                <span>{moment(input.next_available_move_in).format('Do MMMM')}</span>
              </div>
            </div>
          }
          <div className="stacey-card-header">
            <div className="name">
              <span>STACEY</span>
              <span style={{marginTop: '-7px'}}>{input.name}</span>
            </div>
            <span className="price" style={{fontSize: '14px'}}>
              from €{input.prices[0].amount}
            </span>
          </div>
          <div className={`stacey-card-amenities ${this.props.type}`}>
            {
              amenities.length === 0 ?
             //       <Spinner animation="border" role="status">
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
                    <div key="card-item1">
                      <span><strong>Size</strong>: {this.props.input.size} m<sup>2</sup></span>
                    </div>,
                    <div key="card-item2" className="amentity-list-wrapper">
                      <div>
                        <span><strong>Room Inventory</strong>: </span>
                        {
                          amenities.roomtype_index_inventory_amenities.map((amenity, index) => {
                            return (
                              <span key={amenity.id}>{amenity.title}{index < amenities.roomtype_index_inventory_amenities.length-1 && ', '}</span>
                            );
                          })
                        }
                      </div>
                      <div>
                        <span><strong>Includes</strong>: </span>
                        {
                          amenities.roomtype_index_inclusion_amenities.map((amenity, index) => {
                            return (
                              <span key={amenity.id}>{amenity.title}{index < amenities.roomtype_index_inclusion_amenities.length-1 && ','} </span>
                            );
                          })
                        }
                      </div>
                    </div>,
                    <div key="card-item3">
                      <span><strong>Person</strong>: For {this.props.input.amount_of_people} {this.props.input.amount_of_people > 1 ? 'people' : 'person'}</span>
                    </div>
                  ]
            }
          </div>
          {this.props.children}
        </div>
      </SimpleReactLightbox>
    )
  }
}
