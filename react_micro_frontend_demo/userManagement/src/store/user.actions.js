export const AddUser = (name, email) => {
  return {
    type: "ADD_USER",
    payload: { name, email }
  };
}

export const DeleteUser = (userId) => {
  return {
    type: 'DELETE_USER',
    payload: userId
  };
}