import { Component } from '@angular/core';
import { Store, select } from '@ngrx/store';
import { take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';

import * as VTable from '@visactor/vtable';
import { InputEditor, TextAreaEditor, ListEditor } from '@visactor/vtable-editors';

import { MaterialCategory } from '@src/store/models/MaterialCategory';
import { invokeMaterialCategoryFetchAPI, materialCategoryFetchAPI_Success, invokeMaterialVideoFetchAPI, materialVideoFetchAPI_Success } from '@src/store/actions/material.action';
import { selectMaterialCategorys, selectMaterialVideos } from '@src/store/selectors/material.selector';
import { GridParentComponent } from '@src/components/common/components/grid-parent/grid-parent.component';
import { DataGridComponentHelper } from '@src/components/common/components/grid-parent/data-grid.helper';
import { DataGridFileUploadEditor } from '@src/components/common/components/grid-parent/data-grid-file-upload.editor';
import { DataGridVideoEditor } from '@src/components/common/components/grid-parent/data-grid-video.editor';
import { cilLineWeight } from '@coreui/icons';
import { BorderDirective } from '@coreui/angular';
import { environment } from '@src/environments/environment';
import { DataGridDropDownEditor } from '@src/components/common/components/grid-parent/data-grid-drop-down.editor';
import { FilePaths } from '@src/components/common/file-paths';

@Component({
  selector: 'app-videos',
  standalone: true,
  imports: [GridParentComponent],
  templateUrl: './videos.component.html',
  styleUrl: './videos.component.css'
})
export class VideosComponent {
  constructor(private readonly store: Store, private actions$: Actions) {
    // setup the data grid helper
    this.dataGridHelper = new DataGridComponentHelper(this, this.store);
  }

  dataGridHelper?: DataGridComponentHelper;

  saveButtonEnabled = false;
  resetButtonEnabled = false;

  categories: MaterialCategory[] = [];

  ngOnInit() {
    console.log('video component initialized');

    // set content table info
    const defaultColumns = [
      { colName: "material_type_id", defaultValue: "2" },
      { colName: "is_active", defaultValue: "true" },
      { colName: "is_public", defaultValue: "false" },
      { colName: "is_deleted", defaultValue: "false" }
    ];

    this.dataGridHelper?.setTableInfo('training_material_videos', "video_id", true, defaultColumns);
    this.dataGridHelper?.setParentTableInfo("training_material", "material_id");

    // set columns
    this.dataGridHelper?.setColumns(this.getColDefs());

    // set edit handlers
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

    this.store.dispatch(invokeMaterialVideoFetchAPI({ isPublic: false }));
    this.actions$.pipe(
      ofType(materialVideoFetchAPI_Success),
      take(1)
    ).subscribe((data: any) => {
      console.log('content fetched', data);

      const data2 = data.allMaterialVideos.map((d: any) => {
        console.log('processing content', d.url);
        var isURL: string = d.url.toLowerCase().startsWith('http') ? 'url' : 'file';

        var videoFilePath = FilePaths.GetTrainingMaterialVideoURL(d.url);

        var cat_option = { value: d.material_category_id, label: this.categories.find((c: any) => c.id === d.material_category_id)?.category_name.toUpperCase() };
        return {
          ...d,
          cat_option: cat_option,
          video2: { video: isURL === 'url' ? d.url : videoFilePath, type: isURL, is_vimeo: d.is_vimeo }
        };
      });

      console.log('content processed', data2);
      this.dataGridHelper!.setData(data2);

      // ----> draw the table
      this.drawVTable();
    });
  }

  // columns definition
  getColDefs() {
    return [
      {
        title: "Video Title", field: "title",
        cellType: 'text',
        editor: 'name-editor',
        width: 100,
        sort: true,
        textStick: true,
        style: {
          bgColor: 'lightgoldenrodyellow',
          fontWeight: 'bold',
          textBaseline: "middle",
        },
        fieldFormat: (record: any) => record.title !== null && record.title !== undefined ? record.title.toUpperCase() : ''
      },
      {
        title: "Category", field: "cat_option",
        editor: 'cat-selector',
        cellType: 'text',
        width: 100,
        style: {
          bgColor: 'lightyellow',
          textBaseline: "middle",
        },
        fieldFormat: (record: any) => {
          return record.cat_option !== null && record.cat_option !== undefined ? record.cat_option?.label?.toUpperCase() : '';
        }

      },
      {
        title: "Video Description", field: "description",
        editor: 'textArea-editor',
        cellType: 'text',
        width: 150,

        style: {
          bgColor: 'white'
        },
      },
      {
        field: 'video2',
        title: 'Video',
        cellType: 'video',
        width: 100,
        columnResizeMode: 'none',
        disableColumnResize: true,
        style: {
          textAlign: 'center',
          bgColor: 'white',
          textBaseline: "middle",
          lineHeight: 60,
        },
        fieldFormat: (record: any) => {
          return record.video2 === null || record.video2 === undefined ? '' : record.video2.video;  
        }
      },
      {
        field: 'video2',
        title: 'Video URL',
        cellType: 'text',
        textStick: true,
        editor: 'video-editor',
        width: 200,
        columnResizeMode: 'none',
        disableColumnResize: true,
        style: {
          textAlign: 'center',
          bgColor: 'white',
          lineHeight: 40,
          autoWrapText: true,
        },
        fieldFormat: (record: any) => {
          // if this is a file then streip the http and path and return the file name
          console.log('video2', record.video2);

          if (record.video2 === null || record.video2 === undefined) {
            return '';
          }
          
          if (record.video2.type === 'file') {
            console.log('file', record.video2.video);
            const parts = record.video2.video.split('/');
            return parts[parts.length - 1];
          }

          return record.video2.video;
        },
      }
    ];
  }

  setEditHanders() {
    const videoEditHandler = (record: any, value: any) => {
      console.log("video edit handler", record, value);

      var changedValues = [];

      changedValues.push({ field: 'url', value: value.video });
      changedValues.push({ field: 'is_vimeo', value: value.is_vimeo });
      changedValues.push({ field: 'file', value: value.file });

      return changedValues;
    }

    const handler = { col: 'video2', handler: videoEditHandler };

    const selectCatHandler = (record: any, value: any) => {
      console.log("select cat handler", record, value);

      var changedValues = [];

      changedValues.push({ field: 'material_category_id', value: value.value });

      return changedValues;
    }

    const catHandler = { col: 'cat_option', handler: selectCatHandler };

    this.dataGridHelper?.setEditorHandlers([handler, catHandler]);
  }

  getTableOptions() {

    const container = document.getElementById('tableContainer');

    // add delete column to the end
    const option = {
      container: container!,
      columns: this.dataGridHelper?.columns,

      widthMode: 'adaptive',
      heightMode: 'autoHeight',
      autoFillWidth: true,
      autoFillHeight: false,

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
      bodyStyle: {
        hover: {
          cellBgColor: 'lightblue',
        }
      },
      checkboxStyle: { defaultFill: 'grey' },
      frameStyle: { cornerRadius: 6, borderColor: '#a881e1', borderLineWidth: .4, shadowColor: 'rgba(0,0,0,.6)', shadowBlur: 2.5, shadowOffsetX: 1.5, shadowOffsetY: 1.5 },
    });

    return option;
  }

  // styling and drawing the table
  drawVTable() {

    // editiors
    // editiors
    const dropDownOptions = this.categories.map((c: any) => {
      return { value: c.id, label: c.category_name.toUpperCase() };
    });

    const ListEditorConfig: any = { options: dropDownOptions };
    const list_editor = new DataGridDropDownEditor(ListEditorConfig);

    const file_upload_editor = new DataGridFileUploadEditor({}, 'Upload Document');


    const videoEditorConfig = { is_vimeo: false, url: '' };
    const video_editor = new DataGridVideoEditor(videoEditorConfig);

    this.dataGridHelper?.registerEditors([
      { name: 'name-editor', editor: new InputEditor() },
      { name: 'textArea-editor', editor: new TextAreaEditor() },
      { name: 'cat-selector', editor: list_editor },
      { name: 'video-editor', editor: video_editor }
    ]);

    // draw it up!
    const option = this.getTableOptions();

    // create table
    this.dataGridHelper?.createTable(option);
  }
}
