import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: 'all-exams',
    loadComponent: () => import('./all-exams/user-exams.component').then(m => m.UserExamsComponent),
    data: {
      title: "User's Exams"
    },
  },
  {
    path: 'new-exams',
    loadComponent: () => import('./new-exams/new-exams.component').then(m => m.NewExamsComponent),
    data: {
      title: "User's Exams"
    },
  }
];

