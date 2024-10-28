import { UserProfile } from '../models/UserProfile';

// state interface
export interface UserProfileState {
    loggedInUser?: UserProfile;
    allUserProfiles: UserProfile[];
    userProfile?: UserProfile;
    newUserProfile?: UserProfile;
}