import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { environment } from '../../environments/environment';
import { User } from '../models/User';
import { ResetPassword } from '../models/ResetPassword';
import { ApiResponse } from '../models/ApiResponse';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  constructor(private _http: HttpClient) { }

  // --------------------------------------------
  registerUser(user: User, avatar: File): Observable<ApiResponse> {
    console.log("User service :", environment.baseURL);

    const formData: FormData = new FormData();
    formData.append('user', JSON.stringify(user));
    formData.append('avatar', avatar);

    return this._http.post<ApiResponse>(environment.baseURL + "User", formData);
  }

  // --------------------------------------------
  authenticateUser(userName: string, password: string): Observable<ApiResponse> {
    console.log("User service :", environment.baseURL, userName);
    return this._http.post<ApiResponse>(environment.baseURL + "User/authenticate", { userName, password });
  }

  logoutUser(): Observable<ApiResponse> {
    console.log("User service :", environment.baseURL);
    
    // TODO mark logout in the backedn
    return this._http.post<ApiResponse>(environment.baseURL + "User/logout", {});
  }

  changePassword(userId: number, oldPassword: string, newPassword: string): Observable<ApiResponse> {
    console.log("User service :", environment.baseURL);
    return this._http.put<ApiResponse>(environment.baseURL + "User/password", { userId, oldPassword, newPassword });
  }

  forgotPassword(email: string): Observable<ApiResponse> {
    console.log("User service :", environment.baseURL);
    return this._http.post<ApiResponse>(environment.baseURL + "User/forgotPassword", { email });
  }

  resetPassword(username: string, newPassword: string): Observable<ApiResponse> {
    console.log("User service :", environment.baseURL);

    const resetPassword: ResetPassword = { username, newPassword };
    return this._http.post<ApiResponse>(environment.baseURL + "User/resetPassword", { username, newPassword });
  }

  // --------------------------------------------
  approveRejectUser(userId: number, isApproved: boolean, approveRejectReason: string, approvedRejectedBy: number): Observable<ApiResponse> {
    console.log("User service :", environment.baseURL);
    return this._http.post<ApiResponse>(environment.baseURL + "User/approveReject", { userId, isApproved, approveRejectReason, approvedRejectedBy });
  }

  lockUser(userId: number, isLocked: boolean): Observable<ApiResponse> {
    console.log("User service :", environment.baseURL, userId, isLocked);
    return this._http.post<ApiResponse>(environment.baseURL + "User/lockUser", { userId, isLocked });
  }

  // --------------------------------------------
  getUsers(): Observable<ApiResponse> {
    console.log("User service :", environment.baseURL);
    return this._http.get<ApiResponse>(environment.baseURL + "User");
  }

  updateUser(user: User, avatar: File): Observable<ApiResponse> {
    console.log("User service :", environment.baseURL);
    const formData: FormData = new FormData();
    formData.append('user', JSON.stringify(user));
    formData.append('avatar', avatar);

    return this._http.put<ApiResponse>(environment.baseURL + "User", formData);
  }
}
