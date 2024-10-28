import { INavData } from '@coreui/angular';

export const navItems: INavData[] = [
  {
    name: 'Dashboard (Sample)',
    url: '/admin/console/dashboard',
    iconComponent: { name: 'cil-speedometer' },
  },
  {
    name: 'Users',
    url: '/admin/console/users',
    iconComponent: { name: 'cil-people' },
    badge: {
      text: '9',
      color: 'primary'
    },
  },
  {
    name: 'Training Material',
    title: true
  },
  {
    name: 'Course Files',
    url: '/admin/console/training-material/courses',
    iconComponent: { name: 'cil-library', className: 'child-menu' }
  },
  {
    name: 'Course Content',
    url: '/admin/console/training-material/text',
    iconComponent: { name: 'cil-library', className: 'child-menu' }
  },
  {
    name: 'Videos',
    url: '/admin/console/training-material/videos',
    iconComponent: { name: 'cil-video' }
  },
  {
    name: 'MCQs',
    url: '/admin/console/training-material/exams',
    iconComponent: { name: 'cil-pencil', className: 'child-menu' }
  },
  {
    name: "Categories",
    url: '/admin/console/training-material/categories',
    iconComponent: { name: 'cil-opentype', className: 'child-menu' }
  },
  {
    name: 'Public Information',
    title: true
  },
  {
    name: 'Services',
    url: '/admin/console/public-info/services',
    iconComponent: { name: 'cil-info', className: 'child-menu' }
  },
  {
    name: 'Processes',
    url: '/admin/console/public-info/processes',
    iconComponent: { name: 'cil-info', className: 'child-menu' }
  },
  {
    name: 'Posts',
    url: '/admin/console/public-info/posts',
    iconComponent: { name: 'cil-info', className: 'child-menu' }
  },
  {
    name: 'FAQs',
    url: '/admin/console/public-info/faqs',
    iconComponent: { name: 'cil-info', className: 'child-menu' }
  },
  {
    name: 'Learner\'s Corner',
    title: true,
  },
  {
    name: 'All Questions',
    url: '/admin/console/qna/faqs',
    iconComponent: { name: 'cil-comment-bubble' },
    badge: {
      text: '10',
      color: 'primary'
    },
  },
  {
    name: 'Learn\'s Exams',
    url: 'conole/exams',
    iconComponent: { name: 'cil-puzzle' },
    children: [
      {
        name: 'All Exams',
        url: '/admin/console/user-exams/all-exams',
        icon: 'nav-icon-bullet'
      },
      {
        name: "New Exams",
        url: '/admin/console/user-exams/new-exams',
        icon: 'nav-icon-bullet'
      },
      {
        name: 'Certificates',
        url: 'certificates',
        icon: 'nav-icon-bullet'
      }
    ]
  },
];
