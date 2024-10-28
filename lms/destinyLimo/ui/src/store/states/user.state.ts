import { User } from '../models/User';

// state interface
export interface UserState {
    loggedInUser?: User;
    allUsers: User[];
    newUser?: User;
    currentUser?: User;
    message?: any;
}