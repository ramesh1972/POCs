import { Component } from '@angular/core';
import { Store, select } from '@ngrx/store';
import { take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';

import * as VTable from '@visactor/vtable';
import { InputEditor, TextAreaEditor } from '@visactor/vtable-editors';

import { invokeContentFetchAPI, contentFetchAPI_Success } from '@src/store/actions/content.action';
import { selectFAQs } from '@src/store/selectors/content.selector';
import { GridParentComponent } from '../../../../../common/components/grid-parent/grid-parent.component';
import { DataGridComponentHelper } from '@src/components/common/components/grid-parent/data-grid.helper';

@Component({
  selector: 'app-faqs',
  standalone: true,
  imports: [GridParentComponent],
  templateUrl: './faqs.component.html',
  styleUrl: './faqs.component.scss'
})
export class FAQsComponent {
  constructor(private readonly store: Store, private actions$: Actions) {
    // setup the data grid helper
    this.dataGridHelper = new DataGridComponentHelper(this, this.store);
  }

  dataGridHelper?: DataGridComponentHelper;

  saveButtonEnabled = false;
  resetButtonEnabled = false;

  ngOnInit() {
    console.log('faq component initialized');

    // set content table info
    const defaultColumns = [
      { colName: "content_type_id", defaultValue: "7" },
      { colName: "is_public", defaultValue: "false" },
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

      this.store.select(selectFAQs).subscribe((data: any) => {
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
        title: "Question", field: "title",
        cellType: 'text',
        editor: 'name-editor',
        width: 250,
        sort: true,
        textStick: true,
        style: {
          bgColor: 'rgba(0,20,0, .6)',
          color: 'white',
        }
      },
      {
        title: "Answer", field: "description",
        editor: 'textArea-editor',
        cellType: 'text',
        width: 400,   
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

      textOverflow: 'string',

      animationAppear: {
        duration: 100,
        delay: 50,
        type: 'one-by-one', // all
        direction: 'row' // colunm
      },

      defaultHeaderRowHeight: 40,

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
        width:16,
      },
      defaultStyle: {
        borderLineWidth: .6,
        autoWrapText: true,
        color: 'black',
        textBaseline: "top",
        borderColor: 'white'
      },
      headerStyle: {
        lineHeight: 40,
        textBaseline: "middle",
        fontSize: 16,
        color: 'white',
        bgColor: 'rgba(0,0,0, .9)',
        autoWrapText: false,
        fontWeight: 400,
        hover: { cellBgColor: 'lightgrey'}
      },
       

      bodyStyle: {
        borderColor: 'white',
        hover: {
          cellBgColor: 'lightgrey',
        }
      },
      checkboxStyle: { defaultFill: 'grey' },
      frameStyle: { cornerRadius: 0, borderColor: 'rgba(255, 255, 255, 1)', borderLineWidth: 7.456, shadowColor: 'rgba(0,0,0, 1)', shadowBlur:4, shadowOffsetX: 0, shadowOffsetY: 0 },
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
