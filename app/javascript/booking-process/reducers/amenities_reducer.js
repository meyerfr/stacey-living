import { FETCH_AMENITIES } from '../actions'

export default function amenitiesReducer(state = null, action) {
  switch (action.type) {
    case FETCH_AMENITIES:
      return action.payload;
    default:
      return state;
  }
}
