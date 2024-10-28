import { Component } from '@angular/core';
import { NgFor } from '@angular/common';
import { RouterLink } from '@angular/router';

import {
  CarouselCaptionComponent,
  CarouselComponent,
  CarouselControlComponent,
  CarouselIndicatorsComponent,
  CarouselInnerComponent,
  CarouselItemComponent,
  ThemeDirective
} from '@coreui/angular';

@Component({
  selector: 'app-main-home',
  standalone: true,
  imports: [ThemeDirective, CarouselComponent, CarouselIndicatorsComponent, CarouselInnerComponent, NgFor, CarouselItemComponent, CarouselCaptionComponent, CarouselControlComponent, RouterLink],
  templateUrl: './main-home.component.html',
  styleUrl: './main-home.component.css'
})
export class MainHomeComponent {

  slides: any[] = new Array(3).fill({ id: -1, src: '', title: '', subtitle: '' });

  ngOnInit(): void {
    this.slides[0] = {
      id: 0,
      src: '/images/backgrounds/bg3.jpg',
      title: 'Get your Learning started today!',
      subtitle: ''
    };
    this.slides[1] = {
      id: 1,
      src: '/images/backgrounds/bg2.webp',
      title: 'Help yourself with Online Courses today!',
      subtitle: ''
    };
    this.slides[2] = {
      id: 2,
      src: '/images/backgrounds/testbg.jpg',
      title: 'Test Drive with Exams when you finish!',
      subtitle: ''
    };
  }
}