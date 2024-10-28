import { Component, OnInit } from '@angular/core';
import { NavigationEnd, Router, RouterOutlet } from '@angular/router';
import { Title } from '@angular/platform-browser';

import { IconSetService } from '@coreui/icons-angular';
import { iconSubset } from '../icons/icon-subset';

import { LearnerDefaultLayoutComponent } from './layout';

@Component({
  selector: 'app-learner-console-root',
  template: '<app-learner-dashboard></app-learner-dashboard>',
  standalone: true,
  imports: [RouterOutlet, LearnerDefaultLayoutComponent]
})
export class LearnerConsoleAppComponent implements OnInit {
  title = 'Destiny Limo LMS - Learner\'s Console';

  constructor(
    private router: Router,
    private titleService: Title,
    private iconSetService: IconSetService
  ) {
    this.titleService.setTitle(this.title);
    
    // iconSet singleton
    this.iconSetService.icons = { ...iconSubset };
  }

  ngOnInit(): void {
    this.router.events.subscribe((evt) => {
      if (!(evt instanceof NavigationEnd)) {
        return;
      }
    });

    
    this.router.navigate(['/learner/console/training-material/courses']);
  }
}
