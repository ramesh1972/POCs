import { Component } from '@angular/core';
import { UntypedFormControl, UntypedFormGroup } from '@angular/forms';
import { Actions, ofType } from '@ngrx/effects';
import { Store } from '@ngrx/store';

import { ButtonDirective, WidgetModule } from '@coreui/angular';
import { FormCheckLabelDirective } from '@coreui/angular';
import { ButtonGroupComponent } from '@coreui/angular';
import { ReactiveFormsModule, UntypedFormBuilder } from '@angular/forms';
import { FormCheckComponent } from '@coreui/angular';


import * as VTable from '@visactor/vtable';
import { DataGridComponentHelper } from '@src/components/common/components/grid-parent/data-grid.helper';
import { invokeUserExamsFetchAPI, UserExamsFetchAPI_Success } from '@src/store/actions/exam.action';
import { selectUsers } from '@src/store/selectors/user.selector';
import { take } from 'rxjs';
import { invokeUserProfilesFetchAPI, UserProfilesFetchAPI_Success } from '@src/store/actions/user-profile.action';
import { CommonModule } from '@angular/common';
import { invokeUsersFetchAPI, UsersFetchAPI_Success } from '@src/store/actions/user.action';
import { UserProfileComponent } from './user-profile/user-profile.component';
import { pad } from 'lodash-es';
import { FilePaths } from '@src/components/common/file-paths';

@Component({
  selector: 'app-users',
  standalone: true,
  imports: [CommonModule, FormCheckComponent, ButtonDirective, FormCheckLabelDirective,
    ButtonGroupComponent, ReactiveFormsModule, UserProfileComponent],
  templateUrl: './users.component.html',
  styleUrl: './users.component.scss'
})
export class UsersComponent {
  constructor(private readonly store: Store, private actions$: Actions) {
    // setup the data grid helper
    this.dataGridHelper = new DataGridComponentHelper(this, this.store);
  }

  formRadio1 = new UntypedFormGroup({
    radio1: new UntypedFormControl('All')
  });

  setRadioValue(value: string): void {
    this.formRadio1.setValue({ radio1: value });

    if (value === 'All') {
      this.dataGridHelper?.table?.updateFilterRules([]);
    }
    else if (value === 'Approved') {
      this.dataGridHelper?.table?.updateFilterRules([{
        filterFunc: (record: Record<string, any>) => {

          return record["isApproved"] == true && record["isLocked"] == false;
        }
      }]);
    }
    else if (value === 'NotApproved') {
      this.dataGridHelper?.table?.updateFilterRules([{
        filterFunc: (record: Record<string, any>) => {

          return record["isApproved"] == false && record["isLocked"] == false && record["approveRejectReason"] == null;
        }
      }]);
    }
    else if (value === 'Locked') {
      this.dataGridHelper?.table?.updateFilterRules([{
        filterFunc: (record: Record<string, any>) => {

          return record["isLocked"] == true;
        }
      }]);
    }
    else if (value === 'Rejected') {
      this.dataGridHelper?.table?.updateFilterRules([{
        filterFunc: (record: Record<string, any>) => {

          return record["isApproved"] == false && record["isLocked"] == false;
        }
      }]);
    }
  }

  dataGridHelper?: DataGridComponentHelper;

  saveButtonEnabled = false;
  resetButtonEnabled = false;

  users: any[] = [];
  selectedUser: any = null;

  ngOnInit() {
    console.log('file component initialized');

    this.dataGridHelper?.setTableInfo('user_profiles', "exam_id", false);

    // set columns
    this.dataGridHelper?.setColumns(this.getColDefs());

    // fetch data
    // users
    this.store.dispatch(invokeUsersFetchAPI());

    this.actions$.pipe(
      ofType(UsersFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("users fetch dispatched", data);

      this.users = data?.allUsers?.map((user: any) => {
        let { userStatus, statusBGColor } = this.setUserStatus(user);
        
        var userProfileNew = {
          ...user.userProfile,
          avatar: FilePaths.GetAvatarPath(user.userProfile?.avatar || 'blank-avatar.webp')
        };

        return {
          ...user,
          userProfile: userProfileNew,
          userStatus: userStatus,
  
          userStatusBGColor: statusBGColor
        };
      });

      this.dataGridHelper!.setData(this.users);

      this.selectedUser = this.users[0];

      console.log('selected user', this.selectedUser);

      // ----> draw the table
      this.drawVTable();
    });
  }

  private setUserStatus(user: any) {
    const isRejected = user.isApproved === false;
    let userStatus = isRejected ? "Rejected" : (user.isApproved ? "Approved" : "Pending Approval");
    userStatus = user.isLocked ? "Locked" : userStatus;

    console.log('user status', userStatus);
    console.log('user approved', user.isApproved);
    console.log('user lockec', user.isLocked);

    let statusBGColor = 'lightgreen';
    if (userStatus === 'Rejected') {
      statusBGColor = 'red';
    }
    else if (userStatus === 'Pending Approval') {
      statusBGColor = 'yellow';
    }
    else if (userStatus === 'Locked') {
      statusBGColor = 'lightgrey';
    }
    return { userStatus, statusBGColor };
  }

  // columns definition
  // columns definition
  getColDefs() {
    return [
      {
        field: 'userId',
        title: 'View User',
        width: 100,
        columnResizeMode: 'none',
        disableColumnResize: true,
        maxWidth: 100,
        style: {
          textAlign: 'center',
          bgColor: 'rgba(184, 132, 132, 0.1)',
          textBaseline: "middle",
        },
        fieldFormat: ((record: any) => {
          return "";
        }),
        icon: [
          {
            name: 'view',
            type: 'svg',
            positionType: VTable.TYPES.IconPosition.left,
            marginLeft: 20,
            width: 20,
            height: 20,
            svg: '/images/buttons/view.png',
            tooltip: {
              title: 'View user profile',
              placement: VTable.TYPES.Placement.right
            }
          },
        ]
      },
      {
        title: "User", field: "userId",
        cellType: 'text',
        width: 240,
        maxWidth: 240,
        textStick: true,
        columnResizeMode: 'none',
        disableColumnResize: true,
        style: {
          bgColor: 'rgba(184, 132, 132, 0.3)',
          textBaseline: "middle",
        },
        customLayout: (args: any) => {
          const { table, row, col, rect } = args;
          const record = table.getCellOriginRecord(col, row);
          const { height, width } = rect ?? table.getCellRect(col, row);
          const percentCalc = VTable.CustomLayout.percentCalc;

          const container = new VTable.CustomLayout.Group({
            height: 240,
            width,
            display: 'flex',
            flexDirection: 'row',
            flexWrap: 'nowrap',
            alignItems: 'center',
            boundsPadding: [4, 4, 4, 4],
          });

          const containerLeft: any = new VTable.CustomLayout.Group({
            height: 240,
            width: 180,

            display: 'flex',
            flexDirection: 'row',
            background: 'transparent',
            boundsPadding: [10, 10],
            cornerRadius: 6,
            alignItems: 'flex-start',
          });

          container.add(containerLeft);
          

          const avatar = new VTable.CustomLayout.Image({
            src: record["userProfile"]["avatar"],
            width: 40,
            height: 40,
            cornerRadius: 20,
          });

          containerLeft.add(avatar);

          const userFullName: string = record.userProfile.firstName + " " + record.userProfile.lastName;
          const userName = new VTable.CustomLayout.Text({
            text: userFullName,
            fontSize: 13,
            fontFamily: 'sans-serif',
            fill: 'black',
            boundsPadding: [4, 10],
            marginTop: 15
          });

          containerLeft.add(userName);

          return {
            rootContainer: container,
            renderDefault: false
          };
        }
      },
      {
        title: "Email", field: "email",
        cellType: 'text',
        width: 300,
        maxWidth: 300,
        columnResizeMode: 'none',
        disableColumnResize: true,
        style: {
          textBaseline: "middle",
          textAlign: 'center',
        },
      },
      {
        title: "Registered Date", field: "createdAt",
        cellType: 'text',

        maxWidth: 160,
        columnResizeMode: 'none',
        disableColumnResize: true,
        style: {
          textBaseline: "middle",
          textAlign: 'center',
        },
        fieldFormat: ((record: any) => {
          return new Date(record.createdAt).toLocaleDateString();
        }),
      },
      {
        title: "User Status", field: "userStatus",
        cellType: 'text',
        width: 150,
        maxWidth: 150,
        columnResizeMode: 'none',
        disableColumnResize: true,
      
        style: {
          bgColor: (args: any) => {
            console.log('args', args);

            const record = this.dataGridHelper?.table?.getCellOriginRecord(args.col, args.row);
            return record.userStatusBGColor;
          },
          textAlign: 'center',
          textBaseline: "middle",
        },
      }
    ];
  }

  getTableOptions() {

    const container = document.getElementById('tableContainer');

    // add delete column to the end
    const option = {
      container: container!,

      columns: this.dataGridHelper?.columns,
      data: this.users,
      widthMode: 'autoWidth',
      heightMode: 'standard',
      heightAdaptiveMode: 'only-body',
      autoFillHeight: false,
      autoFillWidth: true,


      animationAppear: {
        duration: 100,
        delay: 50,
        type: 'one-by-one', // all
        direction: 'row' // colunm
      },

      theme: VTable.themes.ARCO
    };

    option.theme = VTable.themes.ARCO.extends({
      underlayBackgroundColor: 'transparent',
      scrollStyle: {
        visible: 'always',
        scrollSliderColor: 'purple',
        scrollRailColor: '#bac3cc',
        scrollSliderCornerRadius: 6,
        hoverOn: false,
        barToSide: false,
        width: 16,
      },
      defaultStyle: {
        autoWrapText: true,
        color: 'black',
        textBaseline: "top",
        lineHeight: 50,
      },
      headerStyle: {
        bgColor: '#a881e1',
        borderColor: '#a881e1',
        borderLineWidth: .3,
        color: 'white',
        textBaseline: "middle",
        autoWrapText: false,
        textAlign: 'center',
      },
      bodyStyle: {
        bgColor: 'white',
        borderColor: 'black',
        borderLineWidth: .3,
        color: 'black',
        textBaseline: "middle",
        autoWrapText: true,
        padding: [20, 20, 20, 20],
      },
      checkboxStyle: { defaultFill: 'grey' },
      frameStyle: { cornerRadius: 6, borderColor: 'black', borderLineWidth: .5, shadowColor: 'rgba(0,0,0,.6)', shadowBlur: 3, shadowOffsetX: 1.5, shadowOffsetY: 1.5 },
    });

    return option;
  }

  // styling and drawing the table
  drawVTable() {

    const option = this.getTableOptions();

    // create table
    this.dataGridHelper?.createTable(option);

    this.dataGridHelper?.table?.on('click_cell', (args: any) => {
      console.log('cell clicked', args);
      //this.showingUser = true;

      if (args.col === 0) {
        this.selectedUser = args.originData;
      }
    });
  }

  onUserUpdated(updatedUser: any) {
    // Find the index of the updated user in the users list
    const index = this.users.findIndex(user => user.id === updatedUser.id);
    if (index !== -1) {

      let { userStatus, statusBGColor} = this.setUserStatus(updatedUser);

      updatedUser.userStatus = userStatus;
      updatedUser.statusBGColor = statusBGColor;

      // Update the user in the users list
      this.users[index] = updatedUser;

      this.dataGridHelper?.table?.setRecords(this.users);

      // refresh the table
      this.dataGridHelper?.table?.render();
    }
  }
}
