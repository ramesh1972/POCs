import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { environment } from '../../environments/environment';

import { MaterialCategory } from "../models/MaterialCategory";
import { TrainingMaterial } from '../models/Material'
import { MaterialFile } from '../models/MaterialFile';
import { MaterialText } from '../models/MaterialText';
import { MaterialVideo } from '../models/MaterialVideo';
import { MaterialMCQ } from '../models/MaterialMCQ';

@Injectable({
  providedIn: 'root'
})
export class MaterialService {
  constructor(private _http: HttpClient) { }

  getMaterialCategory(): Observable<MaterialCategory[]> {
    return this._http.get<MaterialCategory[]>(environment.baseURL + "material/category");
  };

  getMaterial(): Observable<TrainingMaterial[]> {
    return this._http.get<TrainingMaterial[]>(environment.baseURL + "material");
  };

  getMaterialFile(isPublic: boolean): Observable<MaterialFile[]> {
    const url = environment.baseURL + "material/file/false/false?isPublic=" + (isPublic? "true" : "false");
    console.log("file url: ", url)
    return this._http.get<MaterialFile[]>(url);
  };

  getMaterialText(isPublic: boolean): Observable<MaterialText[]> {
    return this._http.get<MaterialText[]>(environment.baseURL + "material/text/false/false?isPublic=" + (isPublic? "true" : "false"));
  };

  getMaterialVideo(isPublic: boolean): Observable<MaterialVideo[]> {
    return this._http.get<MaterialVideo[]>(environment.baseURL + "material/video/false/false?isPublic=" + (isPublic? "true" : "false"));
  };

  getMaterialMCQ(isPublic: boolean): Observable<MaterialMCQ[]> {
    return this._http.get<MaterialMCQ[]>(environment.baseURL + "material/mcq/false/false?isPublic=" + (isPublic? "true" : "false"));
  };

  updateTrainingMaterial(trainingMaterial: TrainingMaterial): Observable<any> {
    console.log("TrainingMaterial service :", trainingMaterial);
    return this._http.post(environment.baseURL + "TrainingMaterial/" + trainingMaterial.material_id, trainingMaterial);
  }

  createTrainingMaterial(trainingMaterial: TrainingMaterial): Observable<any> {
    console.log("TrainingMaterial service :", trainingMaterial);
    return this._http.post(environment.baseURL + "TrainingMaterial", trainingMaterial);
  }

  deleteTrainingMaterial(Id: number): Observable<any> {
    console.log("TrainingMaterial service :", Id);
    return this._http.delete(environment.baseURL + "TrainingMaterial/" + Id);
  }

  // for text
  updateTrainingMaterialText(trainingMaterialText: MaterialText): Observable<any> {
    console.log("TrainingMaterialText service :", trainingMaterialText);
    return this._http.put(environment.baseURL + "material/text/", trainingMaterialText);
  }

  createTrainingMaterialText(trainingMaterialText: MaterialText): Observable<any> {
    console.log("TrainingMaterialText service :", trainingMaterialText);
    return this._http.post(environment.baseURL + "material/text/", trainingMaterialText);
  }

  deleteTrainingMaterialText(Id: number): Observable<any> {
    console.log("TrainingMaterialText service :", Id);
    return this._http.delete(environment.baseURL + "material/text/" + Id);
  }

  // for MCQs
  updateTrainingMaterialMCQ(trainingMaterialMCQ: MaterialMCQ): Observable<any> {
    console.log("TrainingMaterialMCQ service :", trainingMaterialMCQ);
    return this._http.put(environment.baseURL + "material/mcq/", trainingMaterialMCQ);
  }

  createTrainingMaterialMCQ(trainingMaterialMCQ: MaterialMCQ): Observable<any> {
    console.log("TrainingMaterialMCQ service :", trainingMaterialMCQ);
    return this._http.post(environment.baseURL + "material/mcq/", trainingMaterialMCQ);
  }

  deleteTrainingMaterialMCQ(Id: number): Observable<any> {
    console.log("TrainingMaterialMCQ service :", Id);
    return this._http.delete(environment.baseURL + "material/mcq/" + Id);
  }
}
