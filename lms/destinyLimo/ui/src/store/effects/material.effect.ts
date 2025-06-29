import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { Store } from '@ngrx/store';
import { catchError, map, mergeMap } from 'rxjs/operators';
import { Observable, of } from 'rxjs';

import { MaterialCategory } from "../models/MaterialCategory";
import { TrainingMaterial } from '../models/Material'
import { MaterialFile } from '../models/MaterialFile';
import { MaterialText } from '../models/MaterialText';
import { MaterialVideo } from '../models/MaterialVideo';
import { MaterialMCQ } from '../models/MaterialMCQ';

import { MaterialService } from '../apis/material.service';

import {
  invokeMaterialCategoryFetchAPI, materialCategoryFetchAPI_Success
  , invokeMaterialFetchAPI, materialFetchAPI_Success
  , invokeMaterialFileFetchAPI, materialFileFetchAPI_Success
  , invokeMaterialTextFetchAPI, materialTextFetchAPI_Success
  , invokeMaterialVideoFetchAPI, materialVideoFetchAPI_Success
  , invokeMaterialMCQFetchAPI, materialMCQFetchAPI_Success,
  invokeMaterialMCQ_UpdateAPI, materialMCQ_UpdateAPI_Success,
  invokeMaterialMCQ_CreateAPI, materialMCQ_CreateAPI_Success,
  invokeMaterialMCQ_DeleteAPI, materialMCQ_DeleteAPI_Success,
  invokeMaterialText_CreateAPI,
  materialText_CreateAPI_Success,
  invokeMaterialText_UpdateAPI,
  materialText_UpdateAPI_Success,
  invokeMaterialText_DeleteAPI,
  materialText_DeleteAPI_Success,
  materialFetchAPI_Failure,
  materialFileFetchAPI_Failure,
  materialText_DeleteAPI_Failure,
  materialText_UpdateAPI_Failure,
  materialMCQ_UpdateAPI_Failure

} from '../actions/material.action';
import { ApiResponse } from '../models/ApiResponse';

@Injectable()
export class MaterialEffect {
  constructor(
    private actions$: Actions,
    private materialService: MaterialService,
    private store: Store
  ) { }


  loadAllMaterialCategory$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeMaterialCategoryFetchAPI),
      mergeMap(() => {
        return this.materialService
          .getMaterialCategory()
          .pipe(map((data: ApiResponse) => materialCategoryFetchAPI_Success({ msg: data.message, allMaterialCategory: data.data as MaterialCategory[] })),
            catchError((error: any) => {
              console.error('error fetching material category', error);
              return of(materialCategoryFetchAPI_Success({ msg: error.message, allMaterialCategory: [] }));
            }
            ));
      }));
  });

  loadAllMaterial$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeMaterialFetchAPI),
      mergeMap(() => {
        return this.materialService
          .getMaterial()
          .pipe(map((data: ApiResponse) => materialFetchAPI_Success({ allMaterials: data.data as TrainingMaterial[] })),
            catchError((error: any) => {
              console.error('error fetching material', error);
              return of(materialFetchAPI_Failure({ error: error.message, data: error.data }));
            }
            ));
      }
      ));
  });

  loadAllMaterialFile$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeMaterialFileFetchAPI),
      mergeMap((action) => {
        return this.materialService
          .getMaterialFile(action.isPublic)
          .pipe(map((data: ApiResponse) => materialFileFetchAPI_Success({ allMaterialFiles: data.data as MaterialFile[] })),
            catchError((error: any) => {
              console.error('error fetching material file', error);
              return of(materialFileFetchAPI_Failure({ error: error.message, data: error.data }));
            }
            ));
      }));
  });

  loadAllMaterialText$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeMaterialTextFetchAPI),
      mergeMap((action) => {
        return this.materialService
          .getMaterialText(action.isPublic)
          .pipe(map((data: ApiResponse) => materialTextFetchAPI_Success({ allMaterialTexts: data.data as MaterialText[] })),
            catchError((error: any) => {
              console.error('error fetching material text', error);
              return of(materialFetchAPI_Failure({ error: error.message, data: error.data }));
            }
            ));
      }
      ));
  });

  loadAllMaterialVideo$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeMaterialVideoFetchAPI),
      mergeMap((action) => {
        return this.materialService
          .getMaterialVideo(action.isPublic)
          .pipe(map((data: ApiResponse) => materialVideoFetchAPI_Success({ allMaterialVideos: data.data as MaterialVideo[] })),
            catchError((error: any) => {
              console.error('error fetching material video', error);
              return of(materialFetchAPI_Failure({ error: error.message, data: error.data }));
            }
            ));
      }
      ));
  });

  loadAllMaterialMCQ$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeMaterialMCQFetchAPI),
      mergeMap((action) => {
        return this.materialService
          .getMaterialMCQ(action.isPublic)
          .pipe(map((data: ApiResponse) => materialMCQFetchAPI_Success({ allMaterialMCQs: data.data as MaterialMCQ[] })),
            catchError((error: any) => {
              console.error('error fetching material MCQ', error);
              return of(materialFetchAPI_Failure({ error: error.message, data: error.data }));
            }
            ));
      }
      ));
  });

  createMaterialText$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeMaterialText_CreateAPI),
      mergeMap((action: any) => {
        return this.materialService
          .createTrainingMaterialText(action.materialText)
          .pipe(map((data: ApiResponse) => {
            console.log('material text created', data);
            return materialText_CreateAPI_Success({ materialText: data.data as MaterialText });
          }
          ), catchError((error: any) => {
            console.error('error creating material text', error);
            return of(materialFetchAPI_Failure({ error: error.message, data: error.data }));
          }
          ));
      }
      ));
  });


  updateMaterialText$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeMaterialText_UpdateAPI),
      mergeMap((action: any) => {
        return this.materialService
          .updateTrainingMaterialText(action.materialText)
          .pipe(map((data: ApiResponse) => materialText_UpdateAPI_Success({ materialText: data.data as MaterialText })),
            catchError((error: any) => {
              console.error('error updating material text', error);
              return of(materialText_UpdateAPI_Failure({ error: error.message }));
            }
            ));
      }
      ));
  });


  deleteMaterialText$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeMaterialText_DeleteAPI),
      mergeMap((action: any) => {
        return this.materialService
          .deleteTrainingMaterialText(action.material_id)
          .pipe(map((data: ApiResponse) => materialText_DeleteAPI_Success({ success: data.data as boolean })),
            catchError((error: any) => {
              console.error('error deleting material text', error);
              return of(materialText_DeleteAPI_Failure({ error: error.message }));
            }
            ));
      }
      ));
  });

  updateMaterialMCQ$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeMaterialMCQ_UpdateAPI),
      mergeMap((action: any) => {
        return this.materialService
          .updateTrainingMaterialMCQ(action.materialMCQ)
          .pipe(map((data: ApiResponse) => materialMCQ_UpdateAPI_Success({ materialMCQ: data.data as MaterialMCQ })),
            catchError((error: any) => {
              console.error('error updating material MCQ', error);
              return of(materialMCQ_UpdateAPI_Failure({ error: error.message }));
            }
            ));
      }
      ));
  });

  createMaterialMCQ$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeMaterialMCQ_CreateAPI),
      mergeMap((action: any) => {
        return this.materialService
          .createTrainingMaterialMCQ(action.materialMCQ)
          .pipe(map((data: ApiResponse) => materialMCQ_CreateAPI_Success({ materialMCQ: data.data as MaterialMCQ })),
            catchError((error: any) => {
              console.error('error creating material MCQ', error);
              return of(materialMCQ_UpdateAPI_Failure({ error: error.message }));
            }));
      }));
  });

  deleteMaterialMCQ$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(invokeMaterialMCQ_DeleteAPI),
      mergeMap((action: any) => {
        return this.materialService
          .deleteTrainingMaterialMCQ(action.material_id)
          .pipe(map((data: ApiResponse) => materialMCQ_DeleteAPI_Success({ success: data.data as boolean })),
            catchError((error: any) => {
              console.error('error deleting material MCQ', error);
              return of(materialMCQ_UpdateAPI_Failure({ error: error.message }));
            }
          ));
        })
      );
  });
}
