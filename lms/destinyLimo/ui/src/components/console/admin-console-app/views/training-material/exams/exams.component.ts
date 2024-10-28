import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Store } from '@ngrx/store';
import { take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';

// CoreUI Modules
import { ButtonModule, DropdownModule } from '@coreui/angular';
import { CardModule } from '@coreui/angular';
import { FormModule, FormCheckComponent } from '@coreui/angular';
import { ButtonDirective } from '@coreui/angular';

import { AccordianParentComponent } from '@src/components/common/components/accordian-parent/accordian-parent.component';
import { invokeMaterialMCQFetchAPI, materialMCQ_CreateAPI_Success, materialMCQ_DeleteAPI_Success, materialMCQ_UpdateAPI_Success, materialMCQFetchAPI_Success } from '@src/store/actions/material.action';
import { invokeMaterialMCQ_CreateAPI, invokeMaterialMCQ_UpdateAPI, invokeMaterialMCQ_DeleteAPI } from '@src/store/actions/material.action';
import { selectMaterialCategorys, selectMaterialMCQs } from '@src/store/selectors/material.selector';
import { MaterialMCQ } from '@src/store/models/MaterialMCQ';

@Component({
  selector: 'app-exams',
  standalone: true,
  imports: [CommonModule, FormModule, FormCheckComponent, ButtonDirective,
    FormsModule,
    ButtonModule,
    CardModule,
    FormModule,
    DropdownModule,
    AccordianParentComponent],
  templateUrl: './exams.component.html',
  styleUrl: './exams.component.css'
})
export class ExamsComponent {
  constructor(private readonly store: Store, private actions$: Actions) {
  }

  categories: any[] = [];
  mcqs: any[] = [];
  newPostString = 'Add New MCQ';
  selectedCategoryName = '';

  ngOnInit() {

    // set data
    console.log("material fetch dispatched");
    this.store.select(selectMaterialCategorys).subscribe((data: any) => {
      console.log('cats fetched', data);

      this.categories = [...data];
    });

    this.store.dispatch(invokeMaterialMCQFetchAPI({ isPublic: false }));

    // Wait for the action to complete
    this.actions$.pipe(
      ofType(materialMCQFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log('material fetched', data);

      const mcqs = data.allMaterialMCQs.map((mcq: any) => {
        console.log("mat cat", mcq.material_category_id);
        const catName = this.categories.find((cat: any) => cat.id === mcq.material_category_id)?.category_name || 'Undefined';
        console.log('catName', catName);

        return {
          ...mcq,
          id: mcq.id,
          title: mcq.question_text || 'MCQ Question',
          category_name: catName,
          editing: false,
          adding: false
        };
      });

      this.mcqs = [...mcqs];
      console.log("mods mcqs", this.mcqs);
    });
  }

  getCurrentCategoryName(mcq: any): string {
    return this.selectedCategoryName || mcq.category_name || 'Select a Category';
  }

  selectCategory(categoryName: string, index: number): void {
    console.log('selectCategory', categoryName, index);
    this.selectedCategoryName = categoryName;
  }


  onAdd() {
    console.log('component onAdd');

    this.selectedCategoryName = '';

    this.mcqs.unshift({
      title: 'MCQ Title',
      description: '',
      content_type_id: 4,
      adding: true,
      editing: false,
      is_active: true,
      is_public: true,
      is_deleted: false
    });

    this.mcqs.forEach((item: any, index: number) => {
      item.editing = false;
    });
  }

  onEdit(i: number) {
    console.log('component edit', i);

    this.selectedCategoryName = '';

    this.mcqs.forEach((item: any, index: number) => {
      item.editing = false;
      item.adding = false;
    });

    this.mcqs[i].editing = true;
    this.mcqs[i].adding = false;
  }

  onDelete(i: number) {
    this.mcqs[i].is_deleted = true;
    this.store.dispatch(invokeMaterialMCQ_DeleteAPI({ material_id: this.mcqs[i].material_id }));

    this.actions$.pipe(
      ofType(materialMCQ_DeleteAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("content fetch dispatched", data);

      if (data.success)
        this.mcqs.splice(i, 1);
      this.selectedCategoryName = '';


    });
  }

  onSave(i: number) {
    console.log('component save', i);

    var mcqChanged: MaterialMCQ = this.mcqs[i];

    if (this.selectedCategoryName !== '') {
      mcqChanged.category_name = this.selectedCategoryName; // Update the mcq object if needed
      mcqChanged.material_category_id = this.categories.find((cat: any) => cat.category_name === this.selectedCategoryName)?.id;
    }

    if (this.mcqs[i].adding) {
      this.store.dispatch(invokeMaterialMCQ_CreateAPI({
        materialMCQ: mcqChanged
      }));

      this.actions$.pipe(
        ofType(materialMCQ_CreateAPI_Success),
        take(1)
      ).subscribe((data: any) => {
        console.log("content fetch dispatched", data);

        const newMCQ: any = { ...data.materialMCQ };
        const catName = this.categories.find((cat: any) => cat.id === newMCQ.material_category_id)?.category_name;
        console.log('catName', catName);
        newMCQ.category_name = catName;
        newMCQ.editing = false;
        newMCQ.adding = false;

        this.mcqs[i] = newMCQ;
        this.selectedCategoryName = '';
      });
    } else if (this.mcqs[i].editing) {
      this.store.dispatch(invokeMaterialMCQ_UpdateAPI({
        materialMCQ: mcqChanged
      }));

      this.actions$.pipe(
        ofType(materialMCQ_UpdateAPI_Success),
        take(1)
      ).subscribe((data: any) => {
        console.log("content fetch dispatched", data);

        const newMCQ: any = { ...data.materialMCQ };
        const catName = this.categories.find((cat: any) => cat.id === newMCQ.material_category_id)?.category_name;
        console.log('catName', catName);
        newMCQ.category_name = catName;
        newMCQ.editing = false;
        newMCQ.adding = false;

        this.mcqs[i] = newMCQ;
        this.selectedCategoryName = '';
      });
    }
  }

  onCancel(i: number) {
    console.log('component cancel', i);

    if (this.mcqs[i].adding) {
      this.mcqs.splice(i, 1);
    }

    this.mcqs[i].editing = false;
    this.mcqs[i].adding = false;
  }
}
