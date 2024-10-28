import { Role } from "./Role";

export interface UserProfile {
    profileId?: number;              // Maps to `ProfileId`
    userId?: number;                 // Maps to `UserId`
 
    firstName?: string;              // Maps to `FirstName`, required field
    lastName?: string;              // Maps to `LastName`
    avatar?: string;                // Maps to `Avatar`
    address?: string;               // Maps to `Address`
    phoneNumber?: string;           // Maps to `PhoneNumber`
    dob?: Date;                     // Maps to `Dob`, nullable Date
    licenseNumber?: string;         // Maps to `LicenseNumber`
    licenseIssueDate?: Date;        // Maps to `LicenseIssueDate`, nullable Date
    licenseExpiryDate?: Date;       // Maps to `LicenseExpiryDate`, nullable Date
    createdAt?: Date;                // Maps to `CreatedAt`
    updatedAt?: Date;               // Maps to `UpdatedAt`, nullable Date
  }
  