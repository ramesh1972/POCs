import { Routes } from '@angular/router';
import { LearnerDefaultLayoutComponent } from './layout';

export const ddroutes: Routes = [
  {
    path: '',
    component: LearnerDefaultLayoutComponent,
    data: {
      title: 'Home'
    },
    children: [
      {
        path: 'dashboard',
        loadChildren: () => import('./views/dashboard/routes').then((m) => m.routes)
      },
      { path: '**', redirectTo: 'dashboard' }
    ],
  }
];