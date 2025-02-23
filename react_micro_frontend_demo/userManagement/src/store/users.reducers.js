const initialState = {
    users: [],
  };
  
  export const UserReducer = (state = initialState, action) => {
    switch (action.type) {
      case 'ADD_USER':
        console.log('Reducer received action:', action);
        return {
          ...state,
          users: [...state.users, { id: state.users.length + 1, ...action.payload }],
        };
      default:
        return state;
    }
  };