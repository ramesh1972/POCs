import { Component } from '@angular/core';
import {Store} from '@ngrx/store';

import { CommonModule } from '@angular/common';

import { selectMaterialCategorys } from '../../../../store/selectors/material.selector';
import { MaterialCategory } from '../../../../store/models/MaterialCategory';

@Component({
  selector: 'app-popular',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './popular.component.html',
  styleUrl: './popular.component.css'
})
export class PopularComponent {
  constructor(private store: Store) { }

  categories: MaterialCategory[] = [];
  
  ngOnInit() {
    console.log('Home component initialized');

    this.store.select(selectMaterialCategorys).subscribe((categories) => {
      this.categories = categories.slice(0, 8); 

      console.log('cats ', this.categories);
    });
  }
}
