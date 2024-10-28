import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: 'edit-profile',
    loadComponent: () => import('../../../register/register.component').then(m => m.RegisterComponent),
    data: {
      title: 'Edit Profile'
    }
  },
  {
    path: 'change-password',
    loadComponent: () => import('../../../change-password/change-password.component').then(m => m.ChangePasswordComponent),
    data: {
      title: 'Change Password'
    }
  }
];

