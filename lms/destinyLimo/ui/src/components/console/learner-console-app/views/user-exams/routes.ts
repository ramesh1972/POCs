import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: 'exams',
    loadComponent: () => import('./exams/user-exams.component').then(m => m.UserExamsComponent),
    data: {
      title: "User's Exams"
    },
  },
  {
    path: 'new-exam',
    loadComponent: () => import('./new-exam/exams.component').then(m => m.ExamsComponent),
    data: {
      title: 'New Exam'
    },
  }
];

