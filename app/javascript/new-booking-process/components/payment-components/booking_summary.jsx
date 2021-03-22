import React from 'react'
import moment from 'moment'


const BookingSummary = (props) => {
  const booking = props.booking
  const roomtype = booking.roomtype
  const move_in = moment(booking.move_in)
  const move_out = moment(booking.move_out)
  const duration = moment.duration(move_out.diff(move_in, 'days'))+1
  return[
    <h3 key="rightSzeneHeader" className="szene-header header-margin">Booking Summary</h3>,
    <div key="rightSzeneList" className="booking-summary-list">
      <div className="booking-section">
        <div className="booking-summary-list-item">
          <span className="light">Room Category</span>
          <span>{roomtype?.name}</span>
        </div>
        <div className="booking-summary-list-item">
          <span className="light">Move-in</span>
          <span>{move_in.format('DD/MM/YYYY')}</span>
        </div>
        <div className="booking-summary-list-item">
          <span className="light">Move-out</span>
          <span>{move_out.format('DD/MM/YYYY')}</span>
        </div>
        <div className="booking-summary-list-item">
          <span className="light">Duration of your stay</span>
          <span>{duration} days</span>
        </div>
      </div>
      <div className="booking-section">
        <span className="booking-section-header">Monthly Cost</span>
        <div className="booking-summary-list-item">
          <span className="light">All-inclusive Monthly Rent</span>
          <span>{booking.price?.amount} €</span>
        </div>
      </div>
      <div className="booking-section important">
        <span className="booking-section-header">Total Now</span>
        <div className="booking-summary-list-item">
          <span>Booking Fee</span>
          <span>80 €</span>
        </div>
      </div>
    </div>
  ]
}

export default BookingSummary;
