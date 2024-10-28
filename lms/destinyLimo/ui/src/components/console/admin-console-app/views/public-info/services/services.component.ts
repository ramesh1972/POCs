import { Component } from '@angular/core';
import { Store, select } from '@ngrx/store';
import { take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';

import * as VTable from '@visactor/vtable';
import { InputEditor, TextAreaEditor } from '@visactor/vtable-editors';

import { invokeContentFetchAPI, contentFetchAPI_Success } from '@src/store/actions/content.action';
import { selectServices } from '@src/store/selectors/content.selector';
import { GridParentComponent } from '../../../../../common/components/grid-parent/grid-parent.component';
import { DataGridComponentHelper } from '@src/components/common/components/grid-parent/data-grid.helper';

@Component({
  selector: 'app-services',
  standalone: true,
  imports: [GridParentComponent],
  templateUrl: './services.component.html',
  styleUrl: './services.component.scss'
})
export class ServicesComponent {
  constructor(private readonly store: Store, private actions$: Actions) {
    // setup the data grid helper
    this.dataGridHelper = new DataGridComponentHelper(this, this.store);
  }

  dataGridHelper?: DataGridComponentHelper;

  saveButtonEnabled = false;
  resetButtonEnabled = false;

  ngOnInit() {
    console.log('process component initialized');

    // set content table info
    const defaultColumns = [
      { colName: "content_type_id", defaultValue: "2" },
      { colName: "is_public", defaultValue: "true" },
      { colName: "is_active", defaultValue: "true" },
      { colName: "is_deleted", defaultValue: "false" }
    ];

    this.dataGridHelper?.setTableInfo('content', "content_id", true, defaultColumns);

    // set columns
    this.dataGridHelper?.setColumns(this.getColDefs());

    // set data
    this.store.dispatch(invokeContentFetchAPI());

    // Wait for the action to complete
    this.actions$.pipe(
      ofType(contentFetchAPI_Success),
      take(1)
    ).subscribe(() => {
      console.log("content fetch dispatched");

      this.store.select(selectServices).subscribe((data: any) => {
        console.log('content fetched', data);

        this.dataGridHelper!.setData(data);

        // ----> draw the table
        this.drawVTable();
      });
    });
  }

  // columns definition
  getColDefs() {
    return [
      {
        title: "Service Title", field: "title",
        cellType: 'text',
        editor: 'name-editor',
        width: 200,
        sort: true,
        textStick: true,
        style: {
          bgColor: 'rgba(183, 239, 8, .55)',
          color: 'black',
        }
      },
      {
        title: "Service Description", field: "description",
        editor: 'textArea-editor',
        width: 350,
        columnResizeMode: 'none',
        disableColumnResize: true,
        style: {
          bgColor: 'white',
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

 
      widthMode: 'autoWidth',
      heightMode: 'autoHeight',
      autoFillHeight: false,
      autoFillWidth: true,

      animationAppear: {
        duration: 100,
        delay: 50,
        type: 'one-by-one', // all
        direction: 'row' // colunm
      },

      defaultHeaderRowHeight: 40,

      theme: VTable.themes.BRIGHT
    };

    option.theme = VTable.themes.BRIGHT.extends({
      underlayBackgroundColor: 'transparent',
      scrollStyle: {
        visible: 'always',
        scrollSliderColor: 'purple',
        scrollRailColor: '#bac3cc',
        scrollSliderCornerRadius: 6,
        hoverOn: false,
        barToSide: false,
        width:16,
      },
      defaultStyle: {
        borderColor: 'black',
        borderLineWidth: .7,
        autoWrapText: true,
        color: 'black',
        textBaseline: "top",
      },
      headerStyle: {
        lineHeight: 40,
        textBaseline: "middle",
        fontSize: 16,
        color: 'black',
        bgColor: 'rgba(143, 239, 139,.3)',
        autoWrapText: false,
        fontWeight: '400',
        hover: { cellBgColor: 'rgba(143, 239, 239, .5)' },
        borderColor: 'rgba(143, 239, 139)',
      },

      bodyStyle: {
        borderColor: 'rgba(0, 0, 0, .2)',
        hover: {
          cellBgColor: 'lightgrey',
        },
      },
      checkboxStyle: { defaultFill: 'grey' },
      frameStyle: { cornerRadius: 8, borderColor: 'rgba(255, 24, 255, .6)', borderLineWidth: 7.623},
    });

    return option;
  }

  // styling and drawing the table
  drawVTable() {

    // editiors
    this.dataGridHelper?.registerEditors([{ name: 'name-editor', editor: new InputEditor() }, { name: 'textArea-editor', editor: new TextAreaEditor() }]);

    // draw it up!
    const option = this.getTableOptions();

    // create table
    this.dataGridHelper?.createTable(option);
  }
}
