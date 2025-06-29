import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { environment } from '../../environments/environment';
import { ApiResponse }  from '../models/ApiResponse';
import { UserProfile } from '../models/UserProfile';

@Injectable({
  providedIn: 'root'
})
export class UserProfileService {
  constructor(private _http: HttpClient) { }

  getUserProfiles(): Observable<ApiResponse> {
    console.log("User profile service :", environment.baseURL);
    return this._http.get<ApiResponse>(environment.baseURL + "User/Profile");
  }

  getUserProfile(userId: number): Observable<ApiResponse> {
    console.log("User profile service :", environment.baseURL);
    return this._http.get<ApiResponse>(environment.baseURL + "User/Profile/" + userId);
  }

  createUserProfile(userProfile: UserProfile): Observable<ApiResponse> {
    console.log("User profile service :", environment.baseURL);
    return this._http.post<ApiResponse>(environment.baseURL + "User/Profile", userProfile);
  }

  updateUserProfile(userProfile: UserProfile): Observable<ApiResponse> {
    console.log("User profile service :", environment.baseURL);
    return this._http.put<ApiResponse>(environment.baseURL + "User/Profile", userProfile);
  }

  deleteUserProfile(userId: number): Observable<ApiResponse> {
    console.log("User profile service :", environment.baseURL);
    return this._http.delete<ApiResponse>(environment.baseURL + "User/Profile/" + userId);
  }
}
