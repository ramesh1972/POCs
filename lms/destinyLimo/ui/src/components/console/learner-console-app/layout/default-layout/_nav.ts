import { INavData } from '@coreui/angular';

export const navItems: INavData[] = [
  {
    name: 'Training Material',
    title: true
  },
  {
    name: 'Course Files',
    url: '/learner/console/training-material/courses',
    iconComponent: { name: 'cil-library', className: 'child-menu' },
    badge: {
      text: '2',
      color: 'success'
    }
  },
  {
    name: 'Course Content',
    url: '/learner/console/training-material/text',
    iconComponent: { name: 'cil-library', className: 'child-menu' },
    badge: {
      text: '5',
      color: 'success'
    }
  },
  {
    name: 'Videos',
    url: '/learner/console/training-material/videos',
    iconComponent: { name: 'cil-video' },
    badge: {
      text: '3',
      color: 'success'
    }
  },
  {
    name: 'Q & A',
    title: true
  },
  {
    name: 'All Questions',
    url: '/learner/console/qna/faqs',
    iconComponent: { name: 'cil-comment-bubble' },
    badge: {
      text: '10',
      color: 'primary'
    }
  },
  {
    name: 'Exams',
    title: true
  },
  {
    name: 'Exams Taken',
    url: '/learner/console/user-exams/exams',
    iconComponent: { name: 'cil-pencil' }
  },
  {
    name: 'Take a New Exam',
    url: '/learner/console/user-exams/new-exam',
    iconComponent: { name: 'cil-pencil' },
    badge: {
      text: 'new',
      color: 'primary'
    }
  }
];