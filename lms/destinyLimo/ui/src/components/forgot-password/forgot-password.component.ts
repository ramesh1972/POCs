import { Component } from '@angular/core';
import { IconDirective } from '@coreui/icons-angular';
import { ContainerComponent, RowComponent, ColComponent, TextColorDirective, CardComponent, CardBodyComponent, FormDirective, InputGroupComponent, InputGroupTextDirective, FormControlDirective, ButtonDirective, FormLabelDirective, FormFeedbackComponent } from '@coreui/angular';
import { RegisterFormValidationService } from '../landing/home-register/register.validation.service';
import { AbstractControl, FormBuilder, FormGroup, ReactiveFormsModule, ValidationErrors, Validators } from '@angular/forms';
import { Actions, ofType } from '@ngrx/effects';
import { Store } from '@ngrx/store';
import { CommonModule } from '@angular/common';
import { changePassword, resetPassword, resetPassword_Failure, resetPassword_Success } from '@src/store/actions/user.action';
import { take } from 'rxjs';
import { RouterLink, RouterLinkActive } from '@angular/router';

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

@Component({
    selector: 'app-forgot-password',
    templateUrl: './forgot-password.component.html',
    styleUrls: ['./forgot-password.component.scss'],
    standalone: true,
    providers: [RegisterFormValidationService],
    imports: [CommonModule, ContainerComponent, RowComponent, ColComponent, TextColorDirective, CardComponent, CardBodyComponent, FormDirective, InputGroupComponent, InputGroupTextDirective, IconDirective, FormControlDirective, ButtonDirective,  FormFeedbackComponent, FormLabelDirective,
      FormDirective,
    InputGroupComponent,
    InputGroupTextDirective,
    IconDirective,
    FormControlDirective,
    ButtonDirective,

    FormFeedbackComponent,
    FormLabelDirective,
    ReactiveFormsModule,
    RouterLink, 
    RouterLinkActive
    ]
})
export class ForgotPasswordComponent {
  errorMessage: any;
  resetSuccess: boolean = false;

  constructor(private formBuilder: FormBuilder, public validationFormsService: RegisterFormValidationService, private store: Store, private actions$: Actions) {
    this.formErrors = this.validationFormsService.errorMessages;
    this.createForm();
  }


  registerForm!: FormGroup;
  submitted = false;
  formErrors: any;
  formControls!: string[];

  createForm() {
    this.registerForm = this.formBuilder.group(
      {
        username: ['',
          [
            Validators.required,
            Validators.minLength(this.validationFormsService.formRules.usernameMin),
            Validators.pattern(this.validationFormsService.formRules.nonEmpty)
          ]
        ],
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
      },
      {
        validators: [
          PasswordValidators.confirmPassword
        ]
      }
    );
    this.formControls = Object.keys(this.registerForm.controls);
  }

  
  onValidate() {
    this.submitted = true;

    // stop here if form is invalid
    return this.registerForm.status === 'VALID';
  }

  resetPassword() {
    console.log('Reset Password');

    console.warn(this.onValidate(), this.registerForm.status);

    if (this.onValidate()) {
      console.log(this.registerForm.value);
      
      const username: string =  this.registerForm.value.username;
      const password: string = this.registerForm.value.password;

      console.log('User Name:', username, "Password:",  password);

      this.store.dispatch(resetPassword({ username: username, newPassword: password }));

      // Wait for the action to complete
      this.actions$.pipe(
        ofType(resetPassword_Success),
        take(1)
      ).subscribe((data: any) => {
        console.log("reset password data fetched:", data);
        this.resetSuccess = true;
      });

      this.actions$.pipe(
        ofType(resetPassword_Failure),
        take(1)
      ).subscribe((data: any) => {
        console.log("reset password data fetched:", data);    
        
        this.errorMessage = data.error.error.message;
      });
    }
  }

}
