import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { environment } from '../../environments/environment';
import { UserProfile }  from '../models/UserProfile';

@Injectable({
  providedIn: 'root'
})
export class UserProfileService {
  constructor(private _http: HttpClient) { }

  getUserProfiles(): Observable<UserProfile[]> {
    console.log("User profile service :", environment.baseURL);
    return this._http.get<UserProfile[]>(environment.baseURL + "User/Profile");
  }

  getUserProfile(userId: number): Observable<UserProfile> {
    console.log("User profile service :", environment.baseURL);
    return this._http.get<UserProfile>(environment.baseURL + "User/Profile/" + userId);
  }

  createUserProfile(userProfile: UserProfile): Observable<UserProfile> {
    console.log("User profile service :", environment.baseURL);
    return this._http.post<UserProfile>(environment.baseURL + "User/Profile", userProfile);
  }

  updateUserProfile(userProfile: UserProfile): Observable<UserProfile> {
    console.log("User profile service :", environment.baseURL);
    return this._http.put<UserProfile>(environment.baseURL + "User/Profile", userProfile);
  }

  deleteUserProfile(userId: number): Observable<UserProfile> {
    console.log("User profile service :", environment.baseURL);
    return this._http.delete<UserProfile>(environment.baseURL + "User/Profile/" + userId);
  }
}
