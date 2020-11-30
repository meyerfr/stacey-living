import { FETCH_CONTRACT, CREATE_CONTRACT, UPDATE_CONTRACT } from '../actions'

export default function contractsReducer(state = null, action) {
  switch (action.type) {
    case FETCH_CONTRACT:
      return action.payload;
    case CREATE_CONTRACT:
    	return action.payload;
    case UPDATE_CONTRACT:
    	return action.payload;
    default:
      return state;
  }
}
