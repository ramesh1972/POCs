import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LearnerConsoleAppComponent } from '../learner-console-app.component';

export const learnerConsoleRoutes: Routes = [
  {
    path: '',
    component: LearnerConsoleAppComponent,
  },
  {
    path: 'dashboard',
    loadChildren: () => import('./dashboard/routes').then(m => m.routes)
  },
  {
    path: 'user-exams',
    loadChildren: () => import('./user-exams/routes').then(m => m.routes)
  },
  {
    path: 'training-material',
    loadChildren: () => import('./training-material/routes').then(m => m.routes)
  },
  {
    path: 'qna',
    loadChildren: () => import('./qna/routes').then(m => m.routes)
  },
  {
    path: 'profile',
    loadChildren: () => import('./profile/routes').then(m => m.routes)
  }
];

@NgModule({
  imports: [RouterModule.forRoot(learnerConsoleRoutes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
