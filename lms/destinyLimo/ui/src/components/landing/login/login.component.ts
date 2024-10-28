import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

import { IconDirective } from '@coreui/icons-angular';
import { ContainerComponent, RowComponent, ColComponent, TextColorDirective, CardComponent, CardBodyComponent, FormDirective, InputGroupComponent, InputGroupTextDirective, FormControlDirective, ButtonDirective } from '@coreui/angular';
import { Store } from '@ngrx/store';
import { AuthenticateUser_Failure, AuthenticateUser_Success, invokeAuthenticateUser } from '@src/store/actions/user.action';
import { Actions, ofType } from '@ngrx/effects';
import { take } from 'rxjs';
import { Router, RouterLink, RouterLinkActive } from '@angular/router';

@Component({
    selector: 'app-login',
    templateUrl: './login.component.html',
    styleUrls: ['./login.component.scss'],
    standalone: true,
    imports: [CommonModule, FormsModule, ContainerComponent, RowComponent, ColComponent, TextColorDirective, CardComponent, CardBodyComponent, FormDirective, InputGroupComponent, InputGroupTextDirective, IconDirective, FormControlDirective, ButtonDirective, RouterLink, RouterLinkActive]
})
export class LoginComponent {

  constructor(private store: Store, private actions$: Actions, private router: Router) { }

  username: string = '';
  password: string = '';
  errorMessage: string = '';

  onLogin() {
    console.log('Login');

    console.log('User Name:', this.username);
    console.log('Password:', this.password);

    this.store.dispatch(invokeAuthenticateUser({ userName: this.username, password: this.password }));

    // Wait for the action to complete
    this.actions$.pipe(
      ofType(AuthenticateUser_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("login data fetched:", data);

      // Redirect to the landing page
      this.router.navigate(['/']);
    });

    this.actions$.pipe(
      ofType(AuthenticateUser_Failure),
      take(1)
    ).subscribe((data: any) => {
      console.log("login data fetched:", data);    
      
      this.errorMessage = data.error.error.message;
    });
  }
}
