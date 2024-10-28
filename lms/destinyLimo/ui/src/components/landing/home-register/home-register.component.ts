import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

import {
  AbstractControl,
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  ValidationErrors,
  Validators,
  FormsModule, FormControl
} from '@angular/forms';

import { IconDirective } from '@coreui/icons-angular';

import { ContainerComponent, RowComponent, ColComponent, TextColorDirective, CardComponent, CardBodyComponent, FormDirective, InputGroupComponent, InputGroupTextDirective, FormControlDirective, ButtonDirective } from '@coreui/angular';
import {
  ButtonGroupComponent,
  ColDirective,
  FormCheckComponent,
  FormCheckInputDirective,
  FormCheckLabelDirective,
  FormFeedbackComponent,
  FormLabelDirective,
} from '@coreui/angular';

import { RegisterFormValidationService } from './register.validation.service';
import { User } from '@src/store/models/User';
import { Store } from '@ngrx/store';
import { registerUser, registerUser_Success } from '@src/store/actions/user.action';
import { Actions, ofType } from '@ngrx/effects';
import { take } from 'rxjs';
import resizeImage from '@src/common/utils/imageUtils';

/** passwords must match - custom validator */
export class PasswordValidators {
  static confirmPassword(control: AbstractControl): ValidationErrors | null {
    const password = control.get('password');
    const confirm = control.get('confirmPassword');
    if (password?.valid && password?.value === confirm?.value) {
      confirm?.setErrors(null);
      return null;
    }
    confirm?.setErrors({ passwordMismatch: true });
    return { passwordMismatch: true };
  }
}

export class NoSpaceValidator {
  static username(control: AbstractControl): ValidationErrors | null {
    console.log('NoSpaceValidator', control.value);
    const uname = control.get('username');
    if (uname?.value.toString().indexOf(' ') >= 0) {
      console.log('found space');
      uname?.setErrors({ noSpaces: true });
      return { noSpaces: true };
    }

    uname?.setErrors(null);
    return null;
  }
}

@Component({
  selector: 'app-home-register',
  standalone: true,
  imports: [CommonModule, FormsModule, ReactiveFormsModule,
    ContainerComponent,
    RowComponent,
    ColComponent,
    TextColorDirective,
    CardComponent,
    CardBodyComponent,
    FormDirective,
    InputGroupComponent,
    InputGroupTextDirective,
    IconDirective,
    FormControlDirective,
    ButtonDirective,
    ButtonGroupComponent,
    ColDirective,
    FormCheckComponent,
    FormCheckInputDirective,
    FormCheckLabelDirective,
    FormFeedbackComponent,
    FormLabelDirective],
  providers: [RegisterFormValidationService],
  templateUrl: './home-register.component.html',
  styleUrl: './home-register.component.css'
})
export class HomeRegisterComponent {
  constructor(private formBuilder: FormBuilder, public validationFormsService: RegisterFormValidationService, private store: Store, private actions$: Actions) {
    this.formErrors = this.validationFormsService.errorMessages;
    this.createForm();
  }

  registerForm!: FormGroup;
  submitted = false;
  formErrors: any;
  formControls!: string[];

  newUser: User = new User();
  avatarFile: File | null = null;
  avatarPreview: string | ArrayBuffer | null = null;

  createForm() {
    this.registerForm = this.formBuilder.group(
      {
        firstName: ['', [Validators.required]],
        lastName: ['', [Validators.required]],
        avatar: [null, [Validators.required]],
        dob: [null, [Validators.required]],
        username: ['',
          [
            Validators.required,
            Validators.minLength(this.validationFormsService.formRules.usernameMin),
            Validators.pattern(this.validationFormsService.formRules.nonEmpty)
          ]
        ],
        email: ['', [Validators.required, Validators.email]],
        mobile: ['', [Validators.required]],
        address: ['', [Validators.required]],
        password: ['',
          [
            Validators.required,
            Validators.minLength(this.validationFormsService.formRules.passwordMin),
            Validators.pattern(this.validationFormsService.formRules.passwordPattern)
          ]
        ],
        confirmPassword: ['',
          [
            Validators.required,
            Validators.minLength(this.validationFormsService.formRules.passwordMin),
            Validators.pattern(this.validationFormsService.formRules.passwordPattern)
          ]
        ],
        license: ['', [Validators.required]],
        issueDate: [null, [Validators.required]],
        expiryDate: [null, [Validators.required]],
        accept: [false, [Validators.requiredTrue]]
      },
      {
        validators: [
          PasswordValidators.confirmPassword
        ]
      }
    );
    this.formControls = Object.keys(this.registerForm.controls);
  }

  onFileChange(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length) {
      const file = input.files[0];

      resizeImage(file, 100, 100, (resizedImage: File) => {
        console.log('resized image', resizedImage);

        const reader = new FileReader();
        reader.onload = (e) => {
          this.avatarFile = resizedImage;
          this.avatarPreview = reader.result;
        };

        reader.readAsDataURL(resizedImage);
      });
    }
  }

  onValidate() {
    this.submitted = true;

    // stop here if form is invalid
    return this.registerForm.status === 'VALID';
  }

  onRegister() {
    console.log('Register');
    console.warn(this.onValidate(), this.registerForm.status);

    if (this.onValidate()) {
      console.warn(this.registerForm.value);

      console.log(this.registerForm.value);
      this.newUser = {
        username: this.registerForm.value.username,
        password: this.registerForm.value.password,
        email: this.registerForm.value.email,
        isApproved: false,
        approveRejectReason: '',
        approvedRejectedBy: -1,
        isLocked: false,
        isDeleted: false,

        userProfile: {
          firstName: this.registerForm.value.firstName,
          lastName: this.registerForm.value.lastName,
          dob: this.registerForm.value.dob,
          avatar: this.avatarFile!.name,
          phoneNumber: this.registerForm.value.mobile,
          address: this.registerForm.value.address,
          licenseNumber: this.registerForm.value.license,
          licenseIssueDate: this.registerForm.value.issueDate,
          licenseExpiryDate: this.registerForm.value.expiryDate,
        },

        roles: [{ role_id: 2 }]
      };

      // resize the image
      
      console.log("new user", this.newUser);
      this.store.dispatch(registerUser({ user: this.newUser, avatar: this.avatarFile! }));

      this.actions$.pipe(
        ofType(registerUser_Success),
        take(1)
      ).subscribe((data: any) => {
        console.log("user registered");

        this.newUser = data.user;
        console.log("new user", this.newUser);
      });
    }
  }
}
