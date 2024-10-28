import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Store } from '@ngrx/store';
import { take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';

// CoreUI Modules
import { ButtonModule, DropdownModule } from '@coreui/angular';
import { CardModule } from '@coreui/angular';
import { FormModule, FormCheckComponent } from '@coreui/angular';
import { ButtonDirective } from '@coreui/angular';

import { invokeMaterialText_CreateAPI, invokeMaterialText_DeleteAPI, invokeMaterialText_UpdateAPI, invokeMaterialTextFetchAPI, materialText_CreateAPI_Success, materialText_DeleteAPI_Success, materialText_UpdateAPI_Success, materialTextFetchAPI_Success } from '@src/store/actions/material.action';
import { selectMaterialCategorys, selectMaterialTexts } from '@src/store/selectors/material.selector';

import { AccordianParentComponent } from '@src/components/common/components/accordian-parent/accordian-parent.component';
import { MaterialText } from '@src/store/models/MaterialText';

@Component({
  selector: 'app-text',
  standalone: true,
  imports: [CommonModule, FormModule, FormCheckComponent, ButtonDirective, DropdownModule,
    FormsModule,
    ButtonModule,
    CardModule,
    FormModule,
    AccordianParentComponent],
  templateUrl: './text.component.html',
  styleUrl: './text.component.css'
})
export class TextComponent {
  constructor(private readonly store: Store, private actions$: Actions) {
  }

  categories: any[] = [];
  text: any[] = [];
  newPostString = 'Add Text Content';
  selectedCategoryName = '';

  ngOnInit() {

    // set data
    this.store.select(selectMaterialCategorys).subscribe((cats) => {
      console.log("material fetch dispatched");

      this.categories = [...cats];
    });

    this.store.dispatch(invokeMaterialTextFetchAPI({ isPublic: false })); // Dispatch the action


    // Wait for the action to complete
    this.actions$.pipe(
      ofType(materialTextFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log('material fetched', data);

      this.text = data.allMaterialTexts.map((mcq: any) => {
        const catName = this.categories.find((cat: any) => cat.id === mcq.material_category_id)?.category_name;
        console.log('catName', catName);
        return {
          ...mcq,
          category_name: catName,
          editing: false,
          adding: false
        };
      });
    });
  }

  adjustTextareaHeight(event: Event): void {
    console.log('adjustTextareaHeight');
    const textarea = event.target as HTMLTextAreaElement;
    textarea.style.height = 'auto';
    textarea.style.height = `${textarea.scrollHeight}px`;
  }


  getCurrentCategoryName(mcq: any): string {
    return this.selectedCategoryName || mcq.category_name || 'Select a Category';
  }

  selectCategory(categoryName: string, index: number): void {
    console.log('selectCategory', categoryName, index, this.text[index]);
    this.selectedCategoryName = categoryName;
  }


  onAdd() {
    console.log('component onAdd');

    this.selectedCategoryName = '';

    this.text.unshift({
      title: 'Course Title',
      description: '',
      category_type_id: 5,
      adding: true,
      editing: false,
      is_active: true,
      is_public: true,
      is_deleted: false
    });

    this.text.forEach((item: any, index: number) => {
      item.editing = false;
    });
  }

  onEdit(i: number) {
    console.log('component edit', i);


    this.text.forEach((item: any, index: number) => {
      item.editing = false;
      item.adding = false;
    });

    this.text[i].editing = true;
    this.text[i].adding = false;
  }

  onDelete(i: number) {
    this.text[i].is_deleted = true;

    this.store.dispatch(invokeMaterialText_DeleteAPI({ material_id: this.text[i].material_id }));

    this.actions$.pipe(
      ofType(materialText_DeleteAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("content fetch dispatched", data);

      if (data.success)
        this.text.splice(i, 1);

      this.selectedCategoryName = '';
    });
  }

  onSave(i: number) {
    console.log('component save', i);

    // invoke dispatch
    const textChanged: MaterialText = this.text[i];

    if (this.selectedCategoryName !== '') {
      textChanged.category_name = this.selectedCategoryName; // Update the mcq object if needed
      textChanged.material_category_id = this.categories.find((cat: any) => cat.category_name === this.selectedCategoryName)?.id;
    }

    console.log('textChanged', textChanged);

    // dispatch the action
    if (this.text[i].adding) {
      this.store.dispatch(invokeMaterialText_CreateAPI({ materialText: textChanged }));

      this.actions$.pipe(
        ofType(materialText_CreateAPI_Success),
        take(1)
      ).subscribe((data: any) => {
        console.log("content fetch dispatched", data);

        const newText: any = { ...data.materialText };
        const catName = this.categories.find((cat: any) => cat.id === newText.material_category_id)?.category_name;
        console.log('catName', catName);
        newText.category_name = catName;
        newText.editing = false;
        newText.adding = false;

        this.text[i] = newText;
        this.selectedCategoryName = '';
      });
    }
    else if (this.text[i].editing) {
      this.store.dispatch(invokeMaterialText_UpdateAPI({ materialText: textChanged }));

      this.actions$.pipe(
        ofType(materialText_UpdateAPI_Success),
        take(1)
      ).subscribe((data: any) => {
        console.log("content fetch dispatched", data);

        const newText: any = { ...data.materialText };
        const catName = this.categories.find((cat: any) => cat.id === newText.material_category_id)?.category_name;
        console.log('catName', catName);
        newText.category_name = catName;
        newText.editing = false;
        newText.adding = false;

        this.text[i] = newText;
        this.selectedCategoryName = '';
      });
    }
  }

  onCancel(i: number) {
    console.log('component cancel', i);
    if (this.text[i].adding) {
      this.text.splice(i, 1);
    }
    this.selectedCategoryName = '';

    this.text[i].editing = false;
    this.text[i].adding = false;
  }
}
