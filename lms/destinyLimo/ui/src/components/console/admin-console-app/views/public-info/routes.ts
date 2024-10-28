import { Routes } from '@angular/router';

export const routes: Routes = [

  {
    path: 'services',
    loadComponent: () => import('./services/services.component').then(m => m.ServicesComponent),
    data: {
      title: 'Services'
    }
  },
  {
    path: 'processes',
    loadComponent: () => import('./processes/processes.component').then(m => m.ProcessesComponent),
    data: {
      title: 'Processes'
    }
  },
  {
    path: 'posts',
    loadComponent: () => import('./posts/posts.component').then(m => m.PostsComponent),
    data: {
      title: 'Posts'
    }
  },
  {
    path: 'faqs',
    loadComponent: () => import('./faqs/faqs.component').then(m => m.FAQsComponent),
    data: {
      title: 'FAQs'
    }
  },
];

