import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { environment } from '../../environments/environment';
import { ApiResponse } from '../models/ApiResponse';

@Injectable({
  providedIn: 'root'
})
export class BulkUpdateService {
  constructor(private _http: HttpClient) { }

  bulkUpdate(tableName: string, actions: any[], uploads: any[]): Observable<ApiResponse> {
    console.log("bulkUpdate", tableName, actions, uploads);

    // convert to form data
    const formData = new FormData();
    formData.append("actions", JSON.stringify(actions));

    // Append files to form data
    const files = [];
    uploads.forEach((file, index) => {
      console.log("upload in loop", file);
      formData.append("files", file);
    });


    return this._http.post<ApiResponse>(environment.baseURL + "bulkUpdate/" + tableName, formData);
  }
}