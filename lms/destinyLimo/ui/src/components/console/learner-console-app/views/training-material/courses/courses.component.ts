import { Component } from '@angular/core';
import { Store, select } from '@ngrx/store';
import { filter, take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';
import { CommonModule } from '@angular/common';

import { CardModule, ButtonDirective, GridModule, BorderDirective, ButtonGroupComponent, FormCheckLabelDirective } from '@coreui/angular';
import { ReactiveFormsModule, UntypedFormBuilder, UntypedFormControl, UntypedFormGroup } from '@angular/forms';

import { environment } from '@src/environments/environment';

import { MaterialCategory } from '@src/store/models/MaterialCategory';
import { invokeMaterialCategoryFetchAPI, invokeMaterialFileFetchAPI, materialCategoryFetchAPI_Success, materialFileFetchAPI_Success } from '@src/store/actions/material.action';
import { selectMaterialCategorys, selectMaterialFiles } from '@src/store/selectors/material.selector';
import { MaterialFile } from '@src/store/models/MaterialFile';
import { FilePaths } from '@src/components/common/file-paths';

@Component({
  selector: 'app-courses',
  standalone: true,
  imports: [CommonModule, CardModule, GridModule, ButtonDirective, BorderDirective,
    ButtonGroupComponent, FormCheckLabelDirective, ReactiveFormsModule
  ],
  templateUrl: './courses.component.html',
  styleUrl: './courses.component.css'
})
export class CoursesComponent {

  formRadio1 = new UntypedFormGroup({
    radio1: new UntypedFormControl('All')
  });

  setRadioValue(value: string): void {
    this.formRadio1.setValue({ radio1: value });
  }

  constructor(private readonly store: Store, private actions$: Actions, private readonly formBuilder: UntypedFormBuilder) {
  }

  saveButtonEnabled = false;
  resetButtonEnabled = false;
  cardColor = 'light';
  borderColor = "primary";
  topBorderColor = "primary";

  categories: MaterialCategory[] = [];
  files: MaterialFile[] = [];

  ngOnInit() {
    console.log('file component initialized');

    // set data
    this.store.dispatch(invokeMaterialCategoryFetchAPI());
    this.actions$.pipe(
      ofType(materialCategoryFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("cats fetch dispatched", data);

      this.categories = [...data.allMaterialCategory];
    });

    this.store.dispatch(invokeMaterialFileFetchAPI({ isPublic: false }));
    this.actions$.pipe(
      ofType(materialFileFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log('files fetched', data);

      this.files = data.allMaterialFiles.map((file: any) => {
        return {
          ...file,
          file_name: FilePaths.GetTrainingMaterialFileURL(file.file_name),

          category_name: this.categories.find((cat: MaterialCategory) => file.material_category_id == cat.id)?.category_name
        };
      });

      console.log("modified files :", this.files);
    });
  }

  fileTypeIcon(fileName: string): string {
    const extension = fileName.split('.').pop();
    switch (extension) {
      case 'pdf':
        return '/images/icons/files/pdf-105-48.png';
      case 'docx':
        return '/images/icons/files/word-98-48.png';
      case 'xlsx':
        return '/images/icons/files/excel-85-48.png';
      case 'pptx':
        return '/images/icons/files/powerpoint-33-48.png';
      case 'ppt':
        return '/images/icons/files/powerpoint-33-48.png';
      case 'txt':
        return '/images/icons/files/typora-48.png';
      case 'jpg':
        return '/images/icons/files/image.webp';
      case 'jpeg':
        return '/images/icons/files/image.webp';
      case 'png':
        return '/images/icons/files/image.webp';
      case 'mp4':
        return '/images/icons/files/video.png';
      // Add more cases as needed
      default:
        return '/images/icons/files/default-file-icon.png';
    }
  }

  onComplete() {
    console.log('onComplete');
  }
}