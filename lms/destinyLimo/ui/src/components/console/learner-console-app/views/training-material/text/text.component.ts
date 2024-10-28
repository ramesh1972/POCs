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
import { ButtonGroupComponent, FormCheckLabelDirective } from '@coreui/angular';
import { ReactiveFormsModule, UntypedFormBuilder, UntypedFormControl, UntypedFormGroup } from '@angular/forms';

import { invokeMaterialTextFetchAPI, materialTextFetchAPI_Success } from '@src/store/actions/material.action';
import { selectMaterialCategorys, selectMaterialTexts } from '@src/store/selectors/material.selector';

import { AccordianParentComponent } from '../../../common/accordian-parent/accordian-parent.component';

@Component({
  selector: 'app-text',
  standalone: true,
  imports: [CommonModule, FormModule, FormCheckComponent, ButtonDirective, DropdownModule,
    ButtonGroupComponent, FormCheckLabelDirective, ReactiveFormsModule,
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

  ngOnInit() {

    // set data
    this.store.select(selectMaterialCategorys).subscribe((cats) => {
      console.log("material fetch dispatched");

      this.categories = [...cats];
    });

    this.store.dispatch((invokeMaterialTextFetchAPI({ isPublic: false })));


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
        };
      });

      this.text[0]!.visible = true;
    });
  }

  formRadio1 = new UntypedFormGroup({
    radio1: new UntypedFormControl('All')
  });

  setRadioValue(value: string): void {
    this.formRadio1.setValue({ radio1: value });
  }

  onComplete(i: number) {
    console.log('component compelte', i);

    // TODO update DB
  }
}
