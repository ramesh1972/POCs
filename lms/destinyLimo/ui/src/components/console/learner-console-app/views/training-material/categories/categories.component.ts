import { Component } from '@angular/core';
import { Store, select } from '@ngrx/store';
import { take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';

import * as VTable from '@visactor/vtable';
import { InputEditor, TextAreaEditor } from '@visactor/vtable-editors';

import { invokeMaterialCategoryFetchAPI, materialCategoryFetchAPI_Success } from '@src/store/actions/material.action';
import { selectMaterialCategorys } from '@src/store/selectors/material.selector';

import { GridParentComponent } from '@src/components/common/components/grid-parent/grid-parent.component';
import { DataGridComponentHelper } from '@src/components/common/components/grid-parent/data-grid.helper';

@Component({
  selector: 'app-categories',
  standalone: true,
  imports: [GridParentComponent],
  templateUrl: './categories.component.html',
  styleUrls: ['./categories.component.css']
})
export class CategoriesComponent {

  constructor(private readonly store: Store, private actions$: Actions) {
    // setup the data grid helper
    this.dataGridHelper = new DataGridComponentHelper(this, this.store);
  }

  dataGridHelper?: DataGridComponentHelper;

  saveButtonEnabled = false;
  resetButtonEnabled = false;

  ngOnInit() {
    console.log('Categories component initialized');

    // set content table info
    const defaultColumns = [
      { colName: "is_active", defaultValue: "true" },
      { colName: "is_deleted", defaultValue: "false" }
    ];

    // set category table info
    this.dataGridHelper?.setTableInfo('training_material_category', "material_category_id", true, defaultColumns);

    // set columns
    this.dataGridHelper?.setColumns(this.getColDefs());

    // set data
    this.store.dispatch(invokeMaterialCategoryFetchAPI());

    // Wait for the action to complete
    this.actions$.pipe(
      ofType(materialCategoryFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
        console.log('categories fetched', data);
        this.dataGridHelper!.setData(data.allMaterialCategory);

        // ----> draw the table
        this.drawVTable();
      });
  }

  // columns definition
  getColDefs() {
    return [
      {
        title: "Category", field: "category_name",
        cellType: 'text',
        editor: 'name-editor',
        width: 200,
        sort: true,
        textStick: true,
        style: {
          bgColor: 'lightyellow',
          textBaseline: "middle",
        },
        fieldFormat: (record: any) => record.category_name !== null && record.category_name !== undefined ? record.category_name.toUpperCase() : ''
      },
      {
        title: "Description", field: "category_description",
        editor: 'textArea-editor',
        disableColumnResize: true,
        width: 500,
        style: {
          bgColor: 'white'
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
        borderLineWidth: .5,
        autoWrapText: true,
        color: 'black',
        textBaseline: "top",
        borderColor: '#a881e1',
      },
      headerStyle: {
        bgColor: '#a881e1',
        borderColor: '#a881e1',
        color: 'white',
        lineHeight: 40,
        textBaseline: "middle",
        autoWrapText: false
      },

      bodyStyle: {
        borderColor: '#a881e1',
      },
      checkboxStyle: { defaultFill: 'grey' },
      frameStyle: { cornerRadius: 8, borderColor: 'rgba(0,0,0, .5)', borderLineWidth: 2.456, shadowColor: 'rgba(0,0,0, .5)', shadowBlur: 8, shadowOffsetX: 0, shadowOffsetY: 0 },
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
