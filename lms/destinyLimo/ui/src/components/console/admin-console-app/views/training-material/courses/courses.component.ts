import { Component } from '@angular/core';
import { Store, select } from '@ngrx/store';
import { filter, take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';

import * as VTable from '@visactor/vtable';
import { InputEditor, TextAreaEditor, ListEditor } from '@visactor/vtable-editors';

import { MaterialCategory } from '@src/store/models/MaterialCategory';
import { invokeMaterialCategoryFetchAPI, invokeMaterialFileFetchAPI, materialCategoryFetchAPI_Success, materialFileFetchAPI_Success } from '@src/store/actions/material.action';
import { selectMaterialCategorys } from '@src/store/selectors/material.selector';

import { GridParentComponent } from '../../../../../common/components/grid-parent/grid-parent.component';
import { DataGridComponentHelper } from '@src/components/common/components/grid-parent/data-grid.helper';
import { DataGridFileUploadEditor } from '@src/components/common/components/grid-parent/data-grid-file-upload.editor';
import { DataGridDropDownEditor } from '@src/components/common/components/grid-parent/data-grid-drop-down.editor';

import { FilePaths } from '@src/components/common/file-paths';

@Component({
  selector: 'app-courses',
  standalone: true,
  imports: [GridParentComponent],
  templateUrl: './courses.component.html',
  styleUrl: './courses.component.css'
})
export class CoursesComponent {
  constructor(private readonly store: Store, private actions$: Actions) {
    // setup the data grid helper
    this.dataGridHelper = new DataGridComponentHelper(this, this.store);
  }

  dataGridHelper?: DataGridComponentHelper;

  saveButtonEnabled = false;
  resetButtonEnabled = false;

  categories: MaterialCategory[] = [];

  ngOnInit() {
    console.log('file component initialized');

    // set content table info
    const defaultColumns = [
      { colName: "material_type_id", defaultValue: "1" },
      { colName: "is_active", defaultValue: "true" },
      { colName: "is_public", defaultValue: "false" },
      { colName: "is_deleted", defaultValue: "false" }
    ];

    this.dataGridHelper?.setTableInfo('training_material_files', "file_id", true, defaultColumns);
    this.dataGridHelper?.setParentTableInfo("training_material", "material_id");

    // set columns
    this.dataGridHelper?.setColumns(this.getColDefs());

    this.setEditHanders();

    // set data
    this.store.dispatch(invokeMaterialCategoryFetchAPI());
    this.actions$.pipe(
      ofType(materialCategoryFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log("cats fetch dispatched", data);

      this.categories = [...data.allMaterialCategory];
    });

    this.store.dispatch(invokeMaterialFileFetchAPI({ isPublic: false }));
    this.actions$.pipe(
      ofType(materialFileFetchAPI_Success),
      take(1)
    ).subscribe((data2: any) => {
      console.log("files fetch dispatched", data2.allMaterialFiles);

      const files = data2.allMaterialFiles.map((file: any) => {
        var cat_option = { value: file.material_category_id, label: this.categories.find((c: any) => c.id === file.material_category_id)?.category_name.toUpperCase() };

        return {
          ...file,
          file_name: FilePaths.GetTrainingMaterialFileURL(file.file_name),
          cat_option: cat_option,
        };
      });

      console.log("modified files :", files)
      this.dataGridHelper!.setData(files);

      // ----> draw the table
      this.drawVTable();
    });
  }

  setEditHanders() {
    const uploadFileHandler = (record: any, value: any) => {
      console.log("upload file handler", record, value);

      var changedValues = [];

      changedValues.push({ field: 'file_name', value: value.fileName });
      changedValues.push({ field: 'file', value: value.file });

      return changedValues;
    }

    const handler = { col: 'file_name', handler: uploadFileHandler };

    const selectCatHandler = (record: any, value: any) => {
      console.log("select cat handler", record, value);

      var changedValues = [];

      changedValues.push({ field: 'material_category_id', value: value.value });

      return changedValues;
    }

    const catHandler = { col: 'cat_option', handler: selectCatHandler };

    this.dataGridHelper?.setEditorHandlers([handler, catHandler]);
  }

  // columns definition
  getColDefs() {
    return [
      {
        title: "File Title", field: "title",
        cellType: 'text',
        editor: 'name-editor',
        width: 150,
        sort: true,
        textStick: true,
        style: {
          bgColor: 'lightgoldenrodyellow',
          fontWeight: 'bold',
          textBaseline: "middle",
        },
        fieldFormat: (record: any) => {
          return record.title !== null && record.title !== undefined ? record.title.toUpperCase() : '';
        }
      },
      {
        title: "Category", field: "cat_option",
        editor: 'cat-selector',
        cellType: 'text',
        width: 150,
        style: {
          bgColor: 'lightyellow',
          textBaseline: "middle",
        },
        fieldFormat: (record: any) => {
          return record.cat_option !== null && record.cat_option !== undefined ? record.cat_option.label?.toUpperCase() : '';
        }
      },
      {
        title: "File Description", field: "description",
        editor: 'textArea-editor',
        cellType: 'text',
        width: 150,

        style: {
          bgColor: 'white'
        },
      },
      {
        field: 'file_name',
        title: 'Document',
        cellType: 'link',
        editor: 'file_uploader',
        width: 200,
        columnResizeMode: 'none',
        disableColumnResize: true,
        fieldFormat: (record: any) => {
          let fileName = record.file_name?.fileName ?? record?.file_name ?? '';

          if (fileName !== '') {
            // get only the filename from path
            const parts = fileName.split('/');
            fileName = parts[parts.length - 1];
            return fileName;
          }

          return record.file_name?.fileName ?? record?.file_name ?? 'Click to upload';
        },
        style: {
          textAlign: 'center',
          bgColor: 'white',
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
      theme: VTable.themes.ARCO,
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
      },
      headerStyle: {
        bgColor: '#a881e1',
        borderColor: '#a881e1',
        borderLineWidth: .3,
        color: 'white',
        lineHeight: 40,
        textBaseline: "middle",
        autoWrapText: false
      },
      checkboxStyle: { defaultFill: 'grey' },
      frameStyle: { cornerRadius: 6, borderColor: '#a881e1', borderLineWidth: .4, shadowColor: 'rgba(0,0,0,.6)', shadowBlur: 2.5, shadowOffsetX: 1.5, shadowOffsetY: 1.5 },
    });

    return option;
  }

  // styling and drawing the table
  drawVTable() {

    // editiors
    const dropDownOptions = this.categories.map((c: any) => {
      return { value: c.id, label: c.category_name.toUpperCase() };
    });

    const ListEditorConfig: any = { options: dropDownOptions };
    const list_editor = new DataGridDropDownEditor(ListEditorConfig);

    const file_upload_editor = new DataGridFileUploadEditor({}, 'Upload Document');

    this.dataGridHelper?.registerEditors([
      { name: 'name-editor', editor: new InputEditor() },
      { name: 'textArea-editor', editor: new TextAreaEditor() },
      { name: 'cat-selector', editor: list_editor },
      { name: 'file_uploader', editor: file_upload_editor }
    ]);

    // draw it up!
    const option = this.getTableOptions();

    // create table
    this.dataGridHelper?.createTable(option);

    // set events
    this.setTableEvents();
  }

  // set table events
  setTableEvents() {
    let clickTimeout: any;

    this.dataGridHelper?.table?.on('click_cell', (args: any) => {
      if (clickTimeout) {
        clearTimeout(clickTimeout);
        clickTimeout = null;
      }

      clickTimeout = setTimeout(() => {
        console.log('click cell', args);

        const { col, row } = args;
        if (col === 3) {
          let fileName = args.dataValue;
          fileName = fileName;
          console.log('file name', fileName);

          window.open(fileName, '_blank');
        }
      }, 300);
    });

    this.dataGridHelper?.table?.on('dblclick_cell', (args: any) => {
      if (clickTimeout) {
        clearTimeout(clickTimeout);
        clickTimeout = null;
      }

      console.log('double click cell', args);
      // cancel cascading
      args.cancel = true;
    });
  }
}