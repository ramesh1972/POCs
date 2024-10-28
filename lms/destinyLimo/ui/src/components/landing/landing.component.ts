import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { RouterLinkActive } from '@angular/router';
import { ChangeDetectorRef } from '@angular/core';

import { HeaderComponent } from './common/header/header.component';
import { FooterComponent } from './common/footer/footer.component';
import { MenuComponent } from './common/menu/menu.component';
import { HomeComponent } from './home/home.component';
import { AboutUsComponent } from './about-us/about-us.component';
import { LoginComponent } from './login/login.component';
import { VisibilityService } from '../common/VisibilityService';
import { ServicesComponent } from './services/services.component';

@Component({
  selector: 'app-landing',
  standalone: true,
  imports: [RouterOutlet, CommonModule, RouterLink, RouterLinkActive,HeaderComponent, FooterComponent, MenuComponent, HomeComponent, AboutUsComponent, LoginComponent, ServicesComponent ],
  templateUrl: './landing.component.html',
  styleUrl: './landing.component.css'
})
export class LandingComponent {
  constructor(private visibilityService: VisibilityService, private cdr: ChangeDetectorRef) { }

  isVisible: boolean = true;

  onNgInit() {
    console.log('Landing component initialized');
  
    this.visibilityService.headerVisible$.subscribe(visible => {
      this.isVisible = visible;
      this.cdr.detectChanges();
    });
  }

}
