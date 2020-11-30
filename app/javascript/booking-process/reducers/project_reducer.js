import { FETCH_PROJECT } from '../actions'

export default function projectReducer(state = null, action) {
  switch (action.type) {
    case FETCH_PROJECT:
      return action.payload;
    default:
      return state;
  }
}
