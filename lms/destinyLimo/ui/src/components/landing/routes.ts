import { Routes } from '@angular/router';

export const landingRoutes: Routes = [
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
    path: 'faqs',
    loadComponent: () => import('./faqs/faqs.component').then(m => m.FAQsComponent),
    data: {
      title: 'FAQs'
    }
  },
  {
    path: 'posts',
    loadComponent: () => import('./posts/posts.component').then(m => m.PostsComponent),
    data: {
      title: 'FAQs'
    }
  },
  {
    path: 'courses',
    loadComponent: () => import('./courses/courses.component').then(m => m.CoursesComponent),
    data: {
      title: 'Courses'
    }
  },
  
  {
    path: 'about-us',
    loadComponent: () => import('./about-us/about-us.component').then(m => m.AboutUsComponent),
    data: {
      title: 'About Us'
    }
  },
  {
    path: 'register',
    loadComponent: () => import('./home-register/home-register.component').then(m => m.HomeRegisterComponent),
    data: {
      title: 'Change Password'
    }
  },
  {
    path: 'login',
    loadComponent: () => import('./login/login.component').then(m => m.LoginComponent),
    data: {
      title: 'Login'
    }
  },
  {
    path: 'console',
    loadComponent: () => import('../console/console.component').then(m => m.ConsoleComponent),
    data: {
      title: 'Console'
    }
  }
];

