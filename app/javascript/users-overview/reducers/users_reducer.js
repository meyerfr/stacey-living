import { FETCH_USERS, APPLY_FILTER, CREATE_BOOKING } from '../actions';

export default function usersReducer(state = null, action) {
  switch (action.type) {
    case FETCH_USERS:
      return action.payload;

    case APPLY_FILTER:
      return action.payload

    case CREATE_BOOKING:
      const copiedUsers = state.slice(0)
      console.log(action.payload)
      return copiedUsers.map((user) => {
        if (action.payload.user_id === user.id) {
          user.invite_send = true
          user.booking = action.payload
          return user
        }
        return user
      })

    // case UPDATE_USER:
    //   copiedUsers = state.users.slice(0)
    //   console.log(action.payload)
    //   return {
    //     users: copiedUsers.map((user) => {
    //       if (user.id === action.payload.id) {
    //         return action.payload
    //       }

    //       return user
    //     }),
    //     sortParams: state.sortParams
    //   }
      // return {bookings: newBookings, sortParams: state.sortParams}
    default:
      return state;
  }
}
