import { Component } from '@angular/core';
import { Store, select } from '@ngrx/store';
import { filter, take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';
import { CommonModule } from '@angular/common';

// CoreUI Modules
import { ButtonModule, DropdownModule } from '@coreui/angular';
import { FormModule, FormCheckComponent } from '@coreui/angular';

import {
  AccordionButtonDirective,
  AccordionComponent,
  AccordionItemComponent,
  TemplateIdDirective,

} from '@coreui/angular';
import { CardModule, ButtonDirective, GridModule, BorderDirective, ButtonGroupComponent, FormCheckLabelDirective } from '@coreui/angular';
import { MaterialCategory } from '@src/store/models/MaterialCategory';
import { invokeMaterialCategoryFetchAPI, invokeMaterialFileFetchAPI, invokeMaterialMCQFetchAPI, invokeMaterialVideoFetchAPI, materialCategoryFetchAPI_Success, materialFileFetchAPI_Success, materialMCQFetchAPI_Success, materialVideoFetchAPI_Success } from '@src/store/actions/material.action';
import { selectMaterialCategorys, selectMaterialFiles, selectMaterialMCQs, selectMaterialVideos } from '@src/store/selectors/material.selector';
import { FilePaths } from '@src/components/common/file-paths';


@Component({
  selector: 'app-courses',
  standalone: true,
  imports: [CommonModule, CardModule, GridModule, ButtonDirective, BorderDirective, CommonModule, FormModule, FormCheckComponent, ButtonDirective,
    AccordionComponent,
    AccordionItemComponent,
    TemplateIdDirective,
    AccordionButtonDirective,
    ButtonDirective
  ],
  templateUrl: './courses.component.html',
  styleUrl: './courses.component.css'
})
export class CoursesComponent {
  constructor(private readonly store: Store, private actions$: Actions) {
  }

  categories: MaterialCategory[] = [];
  files: any[] = [];
  videos: any[] = [];
  texts: any[] = [];
  mcqs: any[] = [];

  ngOnInit() {
    console.log('courses component initialized');

    // set data
    this.store.dispatch(invokeMaterialCategoryFetchAPI());
    this.actions$.pipe(
      ofType(materialCategoryFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("cats fetch dispatched", data);

      this.categories = [...data.allMaterialCategory];
    });


    this.store.dispatch(invokeMaterialFileFetchAPI({ isPublic: true }));
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


    this.store.dispatch(invokeMaterialVideoFetchAPI({ isPublic: true }));
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

      console.log("modified videos :", this.videos);
    });

    this.store.dispatch(invokeMaterialMCQFetchAPI({ isPublic: true }));

    // Wait for the action to complete
    this.actions$.pipe(
      ofType(materialMCQFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
        console.log("cats ", this.categories);
        console.log('material fetched', data);

        const mcqs = data.allMaterialMCQs.map((mcq: any) => {
          console.log("mat cat", mcq.material_category_id);
          const catName = this.categories.find((cat: any) => cat.id === mcq.material_category_id)?.category_name || 'Undefined';
          console.log('catName', catName);

          return {
            ...mcq,
            title: mcq.question_text || 'MCQ Question',
            category_name: catName,
          };
        });

        this.mcqs = [...mcqs];
        console.log("mods mcqs", this.mcqs)
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
}