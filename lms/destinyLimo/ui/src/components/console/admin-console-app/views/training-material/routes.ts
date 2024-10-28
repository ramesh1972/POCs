import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: 'courses',
    loadComponent: () => import('./courses/courses.component').then(m => m.CoursesComponent),
    data: {
      title: 'Course Files'
    }
  },
  {
    path: 'text',
    loadComponent: () => import('./text/text.component').then(m => m.TextComponent),
    data: {
      title: 'Course Content'
    }
  },
  {
    path: 'videos',
    loadComponent: () => import('./videos/videos.component').then(m => m.VideosComponent),
    data: {
      title: 'Videos - Make Multiple Changes & Save'
    }
  },
  {
    path: 'exams',
    loadComponent: () => import('./exams/exams.component').then(m => m.ExamsComponent),
    data: {
      title: 'MCQs'
    }
  },
  {
    path: 'categories',
    loadComponent: () => import('./categories/categories.component').then(m => m.CategoriesComponent),
    data: {
      title: 'Training Material Categories'
    }
  },
];

