import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: 'faqs',
    loadComponent: () => import('./faqs/faqs.component').then(m => m.FAQsComponent),
    data: {
      title: 'Course Files'
    }
  }
];

