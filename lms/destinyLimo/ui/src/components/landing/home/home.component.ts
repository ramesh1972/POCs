import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Store } from '@ngrx/store';

import { selectContents, selectContentState } from '../../../store/selectors/content.selector';
import { Content } from '../../../store/models/Content';

import { MenuComponent } from '../common/menu/menu.component';
import { MainHomeComponent } from './main-home/main-home.component';
import { PopularComponent } from './popular/popular.component';
import { HomeRegisterComponent } from '../home-register/home-register.component';
import { HomeServicesComponent } from './home-services/home-services.component';
import { TestimonialsComponent } from './testimonials/testimonials.component';
import { VisibilityService } from '@src/components/common/VisibilityService';


@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, MenuComponent, MainHomeComponent, PopularComponent, HomeRegisterComponent, HomeServicesComponent, TestimonialsComponent],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {

  constructor(private store: Store, private visibilityService: VisibilityService) { }

  contents$: readonly Content[] = [];

  ngOnInit() {
    console.log('Home component initialized');

    this.visibilityService.setHeaderVisible(true);
    this.visibilityService.setHomeVisible(true);
    this.visibilityService.setConsoleVisible(false);
    
    this.store.select(selectContentState).subscribe((state) => {
      console.log('state ', state);
      this.contents$ = state.content;

      console.log('contents ', this.contents$);
    });
  }


}
