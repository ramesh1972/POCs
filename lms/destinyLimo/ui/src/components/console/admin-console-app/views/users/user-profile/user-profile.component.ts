import { Component, EventEmitter, Input, Output } from '@angular/core';
import { IconDirective } from '@coreui/icons-angular';
import { ContainerComponent, RowComponent, ColComponent, TextColorDirective, CardComponent, CardBodyComponent, FormDirective, InputGroupComponent, InputGroupTextDirective, FormControlDirective, ButtonDirective } from '@coreui/angular';
import { UserProfile } from '@src/store/models/UserProfile';
import { CommonModule } from '@angular/common';
import { User } from '@src/store/models/User';
import { FormsModule } from '@angular/forms';
import { Store } from '@ngrx/store';
import { Actions, ofType } from '@ngrx/effects';
import { approveRejectUser, approveRejectUser_Success, lockUser, lockUser_Success } from '@src/store/actions/user.action';
import { selectLoggedInUser } from '@src/store/selectors/user.selector';
import { FilePaths } from '@src/components/common/file-paths';

@Component({
  selector: 'app-user-profile',
  templateUrl: './user-profile.component.html',
  styleUrls: ['./user-profile.component.scss'],
  standalone: true,
  imports: [CommonModule, FormsModule, ContainerComponent, RowComponent, ColComponent, TextColorDirective, CardComponent, CardBodyComponent, FormDirective, InputGroupComponent, InputGroupTextDirective, IconDirective, FormControlDirective, ButtonDirective]
})
export class UserProfileComponent {

  constructor(private store: Store, private actions: Actions) { }

  @Input() user: any | undefined;
  @Output() userUpdated = new EventEmitter<any>();

  loggedInUser: User | undefined;
  successResponse: string = '';

  ngOnInit() {
     
    this.store.select(selectLoggedInUser).subscribe((user2: any) => {
      this.loggedInUser = user2;
    });
  }

  onApprove() {
    console.log('Approve', this.user.approveRejectReason);

    this.store.dispatch(approveRejectUser({ userId: this.user.userId, isApproved: true, approveRejectReason: this.user.approveRejectReason, approvedRejectedBy: this.loggedInUser?.userId! }));

    this.actions.pipe(ofType(approveRejectUser_Success)).subscribe((action: any) => {
      console.log('Action:', action);

      if (action.message.success) {
        this.user.isApproved = true;
        this.successResponse = "User Approved Successfully";
        this.setUserStatus();
      }
    });
  }

  onReject() {
    console.log('Reject', this.user.approveRejectReason);

    this.store.dispatch(approveRejectUser({ userId: this.user.userId, isApproved: false, approveRejectReason: this.user.approveRejectReason, approvedRejectedBy: this.loggedInUser?.userId! }));

    this.actions.pipe(ofType(approveRejectUser_Success)).subscribe((action: any) => {
      console.log('Action:', action);

      if (action.message.success) {
        this.user.isApproved = false;

        this.successResponse = "User Rejected Successfully";
        this.setUserStatus();
      }
    });

  }

  onLock() {
    console.log('Lock', this.user.approveRejectReason);
    this.store.dispatch(lockUser({ userId: this.user.userId, isLocked: true }));

    this.actions.pipe(ofType(lockUser_Success)).subscribe((action: any) => {
      console.log('Action:', action);

      if (action.message.success) {
        this.user.isLocked = true;

        this.successResponse = "User Locked Successfully";
        this.setUserStatus();
      }
    });

  }

  onUnlock() {
    console.log('Unlock', this.user.approveRejectReason, this.user);

    this.store.dispatch(lockUser({ userId: this.user.userId, isLocked: false }));

    this.actions.pipe(ofType(lockUser_Success)).subscribe((action: any) => {
      console.log('Action:', action);

      if (action.message.success) {
        this.user.isLocked = false;

        this.successResponse = "User Unlocked Successfully";

        this.setUserStatus();
      }
    });
  }

  setUserStatus() {
    const isRejected = this.user.isApproved === false;
    let userStatus = isRejected ? "Rejected" : (this.user.isApproved ? "Approved" : "Pending Approval");
    userStatus = this.user.isLocked ? "Locked" : userStatus;
    this.user.userStatus = userStatus;

    this.userUpdated.emit(this.user);
    console.log('user post change', this.user);
  }

}
