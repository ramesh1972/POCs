const initialState = {
    users: [],
  };
  
  export const UserReducer = (state = initialState, action) => {
    switch (action.type) {
      case 'FETCH_USERS_COUNT':
        console.log('Reducer received action:', action);
        return state.length;
      default:
        return state;
    }
  };