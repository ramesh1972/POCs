var initialState = {
  users: [],
};

export const UserReducer = (state = initialState, action) => {
  switch (action.type) {
    case 'FETCH_USERS':
      console.log('Reducer received action:', action);
      return {
        ...state
      };
    default:
      return state;
  }
};