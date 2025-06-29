import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { environment } from '../../environments/environment';
import { Content } from '../models/Content';
import { ApiResponse } from '../models/ApiResponse';

@Injectable({
  providedIn: 'root'
})
export class ContentService {
  constructor(private _http: HttpClient) { }

  getContent(): Observable<ApiResponse> {
    console.log("content service :", environment.baseURL);
    const resp: any = this._http.get<ApiResponse>(environment.baseURL + "content");
      return resp;
  }

  updateContent(content: Content): Observable<any> {
    console.log("content service :", content);
    return this._http.post(environment.baseURL + "content/" + content.Id, content);
  }

  createContent(content: Content): Observable<any> {
    console.log("content service :", content);
    return this._http.post(environment.baseURL + "content", content);
  }

  deleteContent(Id: number): Observable<any> {
    console.log("content service :", Id);
    return this._http.delete(environment.baseURL + "content/" + Id);
  }
}
