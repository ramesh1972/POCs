import { Injectable } from '@angular/core';
import { ProgressAnimationType, ToastrService } from 'ngx-toastr';

@Injectable({
  providedIn: 'root'
})
export class MessageSnackBarService {
  constructor(private toastr: ToastrService) {}

  showMessage(message: string, type: 'success' | 'error' | 'info' | 'warning', duration: number = 10000): void {
    const toastrOptions = {
      timeOut: duration,
      positionClass: 'toast-top-right',
      progressBar: true, // Show progress bar
      progressAnimation: 'decreasing' as ProgressAnimationType  // or 'decreasing'
    };

    switch (type) {
      case 'success':
        this.toastr.success(message, 'Success', toastrOptions);
        break;
      case 'error':
        this.toastr.error(message, 'Error', toastrOptions);
        break;
      case 'info':
        this.toastr.info(message, 'Info', toastrOptions);
        break;
      case 'warning':
        this.toastr.warning(message, 'Warning', toastrOptions);
        break;
      default:
        this.toastr.show(message, '', toastrOptions);
        break;
    }
  }
}
