import { CONTRACT_SIGNED } from '../actions';

export default function contractReducer(state = null, action) {
  switch (action.type) {
    case CONTRACT_SIGNED:
      return action.payload;
    default:
      return state;
  }
}
