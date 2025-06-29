import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { environment } from '../../environments/environment';
import { ApiResponse } from '../models/ApiResponse';
import { TrainingMaterial } from '../models/Material'

import { MaterialMCQ } from '../models/MaterialMCQ';


@Injectable({
  providedIn: 'root'
})
export class MaterialService {
  constructor(private _http: HttpClient) { }

  getMaterialCategory(): Observable<ApiResponse> {
    const resp = this._http.get<ApiResponse>(environment.baseURL + "material/category");
    console.log("category resp: ", resp);
    return resp;
  };

  getMaterial(): Observable<ApiResponse> {
    return this._http.get<ApiResponse>(environment.baseURL + "material");
  };

  getMaterialFile(isPublic: boolean): Observable<ApiResponse> {
    const url = environment.baseURL + "material/file/false/false?isPublic=" + (isPublic? "true" : "false");
    console.log("file url: ", url)
    return this._http.get<ApiResponse>(url);
  };

  getMaterialText(isPublic: boolean): Observable<ApiResponse> {
    return this._http.get<ApiResponse>(environment.baseURL + "material/text/false/false?isPublic=" + (isPublic? "true" : "false"));
  };

  getMaterialVideo(isPublic: boolean): Observable<ApiResponse> {
    return this._http.get<ApiResponse>(environment.baseURL + "material/video/false/false?isPublic=" + (isPublic? "true" : "false"));
  };

  getMaterialMCQ(isPublic: boolean): Observable<ApiResponse> {
    return this._http.get<ApiResponse>(environment.baseURL + "material/mcq/false/false?isPublic=" + (isPublic? "true" : "false"));
  };

  updateTrainingMaterial(trainingMaterial: TrainingMaterial): Observable<ApiResponse> {
    console.log("TrainingMaterial service :", trainingMaterial);
    return this._http.post<ApiResponse>(environment.baseURL + "TrainingMaterial/" + trainingMaterial.material_id, trainingMaterial);
  }

  createTrainingMaterial(trainingMaterial: TrainingMaterial): Observable<ApiResponse> {
    console.log("TrainingMaterial service :", trainingMaterial);
    return this._http.post<ApiResponse>(environment.baseURL + "TrainingMaterial", trainingMaterial);
  }

  deleteTrainingMaterial(Id: number): Observable<ApiResponse> {
    console.log("TrainingMaterial service :", Id);
    return this._http.delete<ApiResponse>(environment.baseURL + "TrainingMaterial/" + Id);
  }

  // for text
  updateTrainingMaterialText(trainingMaterialText: ApiResponse): Observable<ApiResponse> {
    console.log("TrainingMaterialText service :", trainingMaterialText);
    return this._http.put<ApiResponse>(environment.baseURL + "material/text/", trainingMaterialText);
  }

  createTrainingMaterialText(trainingMaterialText: ApiResponse): Observable<ApiResponse> {
    console.log("TrainingMaterialText service :", trainingMaterialText);
    return this._http.post<ApiResponse>(environment.baseURL + "material/text/", trainingMaterialText);
  }

  deleteTrainingMaterialText(Id: number): Observable<ApiResponse> {
    console.log("TrainingMaterialText service :", Id);
    return this._http.delete<ApiResponse>(environment.baseURL + "material/text/" + Id);
  }

  // for MCQs
  updateTrainingMaterialMCQ(trainingMaterialMCQ: MaterialMCQ): Observable<ApiResponse> {
    console.log("TrainingMaterialMCQ service :", trainingMaterialMCQ);
    return this._http.put<ApiResponse>(environment.baseURL + "material/mcq/", trainingMaterialMCQ);
  }

  createTrainingMaterialMCQ(trainingMaterialMCQ: MaterialMCQ): Observable<ApiResponse> {
    console.log("TrainingMaterialMCQ service :", trainingMaterialMCQ);
    return this._http.post<ApiResponse>(environment.baseURL + "material/mcq/", trainingMaterialMCQ);
  }

  deleteTrainingMaterialMCQ(Id: number): Observable<ApiResponse> {
    console.log("TrainingMaterialMCQ service :", Id);
    return this._http.delete<ApiResponse>(environment.baseURL + "material/mcq/" + Id);
  }
}
