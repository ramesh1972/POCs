import { Routes } from '@angular/router';
import { AdminDefaultLayoutComponent } from './layout';

export const ddroutes: Routes = [
  {
    path: '',
    component: AdminDefaultLayoutComponent,
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