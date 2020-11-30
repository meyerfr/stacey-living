import { FETCH_INTENT } from '../actions'

export default function clientSecretsReducer(state = null, action) {
  switch (action.type) {
    case FETCH_INTENT:
      return action.payload;
    default:
      return state;
  }
}
