export const getUserCount = (users) => {
  return users.length;
};

export const getCurrentTime = () => {
  return new Date().toLocaleTimeString();
}