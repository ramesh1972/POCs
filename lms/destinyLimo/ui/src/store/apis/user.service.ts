import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';

import { environment } from '../../environments/environment';
import { User } from '../models/User';
import { UserProfile } from '../models/UserProfile';
import { ResetPassword } from '../models/ResetPassword';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  constructor(private _http: HttpClient) { }

  // --------------------------------------------
  registerUser(user: User, avatar: File): Observable<any> {
    console.log("User service :", environment.baseURL);

    const formData: FormData = new FormData();
    formData.append('user', JSON.stringify(user));
    formData.append('avatar', avatar);

    return this._http.post<any>(environment.baseURL + "User", formData);
  }

  // --------------------------------------------
  authenticateUser(userName: string, password: string): Observable<User> {
    console.log("User service :", environment.baseURL, userName);
    return this._http.post<User>(environment.baseURL + "User/authenticate", { userName, password });
  }

  logoutUser(): Observable<User> {
    console.log("User service :", environment.baseURL);
    return of(new User());

    // TODO mark logout in the backedn
    //return this._http.post<User>(environment.baseURL + "User/logout", {});
  }

  changePassword(userId: number, oldPassword: string, newPassword: string): Observable<User> {
    console.log("User service :", environment.baseURL);
    return this._http.put<User>(environment.baseURL + "User/password", { userId, oldPassword, newPassword });
  }

  forgotPassword(email: string): Observable<User> {
    console.log("User service :", environment.baseURL);
    return this._http.post<User>(environment.baseURL + "User/forgotPassword", { email });
  }

  resetPassword(username: string, newPassword: string): Observable<User> {
    console.log("User service :", environment.baseURL);

    const resetPassword: ResetPassword = { username, newPassword };
    return this._http.post<User>(environment.baseURL + "User/resetPassword", { username, newPassword });
  }

  // --------------------------------------------
  approveRejectUser(userId: number, isApproved: boolean, approveRejectReason: string, approvedRejectedBy: number): Observable<User> {
    console.log("User service :", environment.baseURL);
    return this._http.post<User>(environment.baseURL + "User/approveReject", { userId, isApproved, approveRejectReason, approvedRejectedBy });
  }

  lockUser(userId: number, isLocked: boolean): Observable<User> {
    console.log("User service :", environment.baseURL, userId, isLocked);
    return this._http.post<User>(environment.baseURL + "User/lockUser", { userId, isLocked });
  }

  // --------------------------------------------
  getUsers(): Observable<User[]> {
    console.log("User service :", environment.baseURL);
    return this._http.get<User[]>(environment.baseURL + "User");
  }

  updateUser(user: User, avatar: File): Observable<User> {
    console.log("User service :", environment.baseURL);
    const formData: FormData = new FormData();
    formData.append('user', JSON.stringify(user));
    formData.append('avatar', avatar);

    return this._http.put<any>(environment.baseURL + "User", formData);
  }
}
