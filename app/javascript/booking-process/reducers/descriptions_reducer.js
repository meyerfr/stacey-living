import { FETCH_DESCRIPTIONS } from '../actions'

export default function descriptionsReducer(state = null, action) {
  switch (action.type) {
    case FETCH_DESCRIPTIONS:
      return action.payload;
    default:
      return state;
  }
}
