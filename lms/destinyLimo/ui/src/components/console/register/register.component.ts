import { Component } from '@angular/core';
import { IconDirective } from '@coreui/icons-angular';
import { ContainerComponent, RowComponent, ColComponent, TextColorDirective, CardComponent, CardBodyComponent, FormDirective, InputGroupComponent, InputGroupTextDirective, FormControlDirective, ButtonDirective, ButtonGroupComponent, ColDirective, FormCheckComponent, FormCheckInputDirective, FormCheckLabelDirective, FormFeedbackComponent, FormLabelDirective } from '@coreui/angular';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';

import { RegisterFormValidationService } from '../../landing/home-register/register.validation.service';
import { Actions, ofType } from '@ngrx/effects';
import { Store } from '@ngrx/store';
import { PasswordValidators } from '@src/components/forgot-password/forgot-password.component';
import { User } from '@src/store/models/User';
import resizeImage from '@src/common/utils/imageUtils';
import { selectLoggedInUser } from '@src/store/selectors/user.selector';
import { FilePaths } from '@src/components/common/file-paths';
import { updateUser, updateUser_Failure, updateUser_Success } from '@src/store/actions/user.action';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss'],
  standalone: true,
  imports: [ContainerComponent, RowComponent, ColComponent, TextColorDirective, CardComponent, CardBodyComponent, FormDirective, InputGroupComponent, InputGroupTextDirective, IconDirective, FormControlDirective, ButtonDirective,
    CommonModule, FormsModule, ReactiveFormsModule,
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
    FormLabelDirective
  ],
  providers: [RegisterFormValidationService]
})
export class RegisterComponent {
  currentUser: any = {};
  constructor(private formBuilder: FormBuilder, public validationFormsService: RegisterFormValidationService, private store: Store, private actions$: Actions) {
    this.formErrors = this.validationFormsService.errorMessages;
    this.createForm();
  }

  registerForm!: FormGroup;
  submitted = false;
  formErrors: any;
  formControls!: string[];

  avatarFile: File | null = null;
  avatarPreview: string | ArrayBuffer | null = null;

  ngOnInit() {
    console.log('Register component initialized');
    this.store.select(selectLoggedInUser).subscribe((user: any) => {
      console.log('User', user);
      this.currentUser = {...user};
      this.currentUser.userProfile = {...this.currentUser.userProfile} || {};

      const formattedDob = user?.userProfile?.dob ? new Date(user.userProfile.dob).toISOString().split('T')[0] : '';
      console.log('User  DOB', formattedDob);

      const issueDate = user?.userProfile?.licenseIssueDate ? new Date(user.userProfile.licenseIssueDate).toISOString().split('T')[0] : '';
      const expiryDate = user?.userProfile?.licenseExpiryDate ? new Date(user.userProfile.licenseExpiryDate).toISOString().split('T')[0] : '';

      this.registerForm.setValue({
        username: user?.username,
        firstName: user?.userProfile?.firstName,
        lastName: user?.userProfile?.lastName,
        avatar: '',
        dob: formattedDob,
        email: user?.email,
        mobile: user?.userProfile?.phoneNumber,
        address: user?.userProfile?.address,
        license: user?.userProfile?.licenseNumber,
        issueDate: issueDate,
        expiryDate: expiryDate
      });

      this.avatarPreview = FilePaths.GetAvatarPath(user?.userProfile?.avatar);

      this.registerForm.get('username')?.disable();
    });
  }

  createForm() {
    this.registerForm = this.formBuilder.group(
      {
        username: ['', [Validators.required]],
  
        firstName: ['', [Validators.required]],
        lastName: ['', [Validators.required]],
        avatar: [null, []],
        dob: [null, [Validators.required]],
        email: ['', [Validators.required, Validators.email]],
        mobile: ['', [Validators.required]],
        address: ['', [Validators.required]],
        license: ['', [Validators.required]],
        issueDate: [null, [Validators.required]],
        expiryDate: [null, [Validators.required]]
      }
    );
    this.formControls = Object.keys(this.registerForm.controls);
  }

  onFileChange(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length) {
      const file = input.files[0];
      console.log('uploaded pic', file);

      resizeImage(file, 100, 100, (resizedImage: File) => {
        console.log('resized image', resizedImage);

        const reader = new FileReader();
        reader.onload = (e) => {
          this.avatarFile = resizedImage;
          this.avatarPreview = reader.result;
          this.currentUser.userProfile.avatar = resizedImage.name;
        };

        reader.readAsDataURL(resizedImage);
      });
    }
  }

  onValidate() {
    this.submitted = true;
    console.log('Register Form', this.registerForm);

    // stop here if form is invalid
    return this.registerForm.status === 'VALID';
  }

  onEditProfile() {
    console.log('Edit Profile');

    console.warn(this.onValidate(), this.registerForm.status);

    
    if (this.onValidate()) {
      console.log(this.registerForm.value);

      var newUser: any = {};
      newUser.userId = this.currentUser.userId;
      newUser.username = this.currentUser.username;
      newUser.email = this.registerForm.value.email;
      newUser.userProfile = {
        profileId: this.currentUser.userProfile.profileId,
        firstName: this.registerForm.value.firstName,
        lastName: this.registerForm.value.lastName,
        dob: this.registerForm.value.dob,
        avatar: this.registerForm.value.avatar || this.currentUser.userProfile.avatar,
        phoneNumber: this.registerForm.value.mobile,
        address: this.registerForm.value.address,
        licenseNumber: this.registerForm.value.license,
        licenseIssueDate: this.registerForm.value.issueDate,
        licenseExpiryDate: this.registerForm.value.expiryDate,
      };

      // get only the file name from the path
      newUser.userProfile.avatar =  newUser.userProfile.avatar?.split('\\').pop() || '';
      console.log('New User', newUser);

      this.store.dispatch(updateUser({ updatedUser: newUser, avatar: this.avatarFile! }));

      this.actions$.pipe(
        ofType(updateUser_Success),
      ).subscribe((action: any) => {
        console.log('Update User', action);
      });

      this.actions$.pipe(
        ofType(updateUser_Failure),
      ).subscribe((action: any) => {
        console.log('Update User Failed', action);
      });
    }
  }
}
