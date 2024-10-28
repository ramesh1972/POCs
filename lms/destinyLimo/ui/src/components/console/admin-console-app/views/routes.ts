import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdminConsoleAppComponent } from '@src/components/console/admin-console-app/admin-console-app.component';


export const adminConsoleRoutes: Routes = [
  { 
    path: '',
    component: AdminConsoleAppComponent,
  },
  {
    path: 'dashboard',
    loadChildren: () => import('./dashboard/routes').then(m => m.routes)
  },
  {
    path: 'users',
    loadChildren: () => import('./users/routes').then(m => m.routes)
  },
  {
    path: 'training-material',
    loadChildren: () => import('./training-material/routes').then(m => m.routes)
  },
  {
    path: 'public-info',
    loadChildren: () => import('./public-info/routes').then(m => m.routes)
  },
  {
    path: 'qna',
    loadChildren: () => import('./qna/routes').then(m => m.routes)
  },
  {
    path: 'user-exams',
    loadChildren: () => import('./user-exams/routes').then(m => m.routes)
  },
];

@NgModule({
  imports: [RouterModule.forRoot(adminConsoleRoutes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
