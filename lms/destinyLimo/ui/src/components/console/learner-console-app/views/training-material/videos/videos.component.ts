import { Component } from '@angular/core';
import { Store, select } from '@ngrx/store';
import { take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';
import { CommonModule } from '@angular/common';

import { CardModule, ButtonDirective, GridModule, BorderDirective, ButtonGroupComponent, FormCheckLabelDirective } from '@coreui/angular';
import { ReactiveFormsModule, UntypedFormBuilder, UntypedFormControl, UntypedFormGroup } from '@angular/forms';

import { MaterialCategory } from '@src/store/models/MaterialCategory';
import { invokeMaterialCategoryFetchAPI, materialCategoryFetchAPI_Success, invokeMaterialVideoFetchAPI, materialVideoFetchAPI_Success } from '@src/store/actions/material.action';
import { selectMaterialCategorys, selectMaterialVideos } from '@src/store/selectors/material.selector';
import { MaterialVideo } from '@src/store/models/MaterialVideo';
import { FilePaths } from '@src/components/common/file-paths';

@Component({
  selector: 'app-videos',
  standalone: true,
  imports: [CommonModule, CardModule, GridModule, ButtonDirective, BorderDirective,
    ButtonGroupComponent, FormCheckLabelDirective, ReactiveFormsModule
  ],
  templateUrl: './videos.component.html',
  styleUrl: './videos.component.css'
})
export class VideosComponent {
  constructor(private readonly store: Store, private actions$: Actions) {
    // setup the data grid helper
  }

  cardColor = 'light';
  borderColor = "primary";
  topBorderColor = "primary";

  saveButtonEnabled = false;
  resetButtonEnabled = false;

  categories: MaterialCategory[] = [];
  videos: MaterialVideo[] = [];

  ngOnInit() {
    console.log('video component initialized');

    // set data
    this.store.dispatch(invokeMaterialCategoryFetchAPI());
    this.actions$.pipe(
      ofType(materialCategoryFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("cats fetch dispatched", data);

      this.categories = [...data.allMaterialCategory];
    });

    this.store.dispatch(invokeMaterialVideoFetchAPI({ isPublic: false }));
    this.actions$.pipe(
      ofType(materialVideoFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log('videos fetched', data);

      this.videos = data.allMaterialVideos.map((video: any) => {
        const isURL = video.url.toLowerCase().startsWith('http');

        const url = isURL ? video.url : FilePaths.GetTrainingMaterialFileURL(video.url);
        return {
          ...video,
          url: url,

          category_name: this.categories.find((c: any) => c.id === video.material_category_id)?.category_name || 'Not Categorized'
        };
      });

      console.log('videos modifiled', this.videos);
    });
  }

  formRadio1 = new UntypedFormGroup({
    radio1: new UntypedFormControl('All')
  });

  setRadioValue(value: string): void {
    this.formRadio1.setValue({ radio1: value });
  }

  onComplete() {
    console.log('onComplete');
  }
}
