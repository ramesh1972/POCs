import { Injectable } from '@angular/core';

@Injectable({
    providedIn: 'root'
})
export class RegisterFormValidationService {

    errorMessages: any;

    formRules = {
        nonEmpty: '^[a-zA-Z0-9]+([_ -]?[a-zA-Z0-9])*$',
        usernameMin: 5,
        passwordMin: 6,
        passwordPattern: '(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,}',
        emailPattern: '^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$'
    };

    formErrors = {
        username: '',
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        confirmPassword: '',
        dob: '',
        accept: false
    };

    constructor() {
        this.errorMessages = {
            firstName: {
                required: 'First name is required'
            },
            lastName: {
                required: 'Last name is required'
            },
            avatar: {
                required: 'Last name is required'
            },
            dob: {
                required: 'Date of Birth is required'
            },
            username: {
                required: 'Username is required',
                minLength: `Username must be ${this.formRules.usernameMin} characters or more`,
                pattern: 'Username must not contain spaces and special characters'
            },
            email: {
                required: 'required',
                email: 'Invalid email address',
                pattern: 'Invalid email address'
            },
            mobile: {
                required: 'Mobile is required'
            },
            address: {
                required: 'Address is required'
            },
            password: {
                required: 'Password is required',
                pattern: 'Password must contain: numbers, uppercase and lowercase letters',
                minLength: `Password must be at least ${this.formRules.passwordMin} characters`
            },
            confirmPassword: {
                required: 'Password confirmation is required',
                passwordMismatch: 'Passwords must match'
            },
            license: {
                required: 'License is required'
            },
            issueDate: {
                required: 'Issue date is required'
            },
            expiryDate: {
                required: 'Expiry date is required'
            },
            accept: {
                requiredTrue: 'You have to accept our Terms and Conditions'
            }
        };
    }
}