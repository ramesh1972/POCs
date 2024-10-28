import { Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { Content } from '@src/store/models/Content';
import { selectContents } from '@src/store/selectors/content.selector';

import * as VTable from '@visactor/vtable';

@Component({
  selector: 'app-faqs',
  standalone: true,
  imports: [],
  templateUrl: './faqs.component.html',
  styleUrl: './faqs.component.scss'
})
export class FAQsComponent {
  constructor(private store: Store) { }

  faqs: Content[] = [];

  ngOnInit() {
    console.log('faqs component initialized');

    this.store.select(selectContents).subscribe((content) => {
      this.faqs = content.filter((c) => c.content_type_id === 7);

      console.log('faqs ', this.faqs);

      this.drawVTable();
    });
  }

  getColDefs() {
    return [
      {
        title: "Question", field: "title",
        cellType: 'text',
        width: 70,
        sort: true,
        textStick: true,
        style: {
          bgColor: 'rgba(0,20,0, .6)',
          color: 'white',
        }
      },
      {
        title: "Answer", field: "description",
        cellType: 'text',
        width: 200,
        style: {
          bgColor: (args: any) => {
            return args.value !== 'Not Answered Yet' ? 'white' : 'red';
          }
        }
      }
    ]
  }

  getTableOptions() {

    const container = document.getElementById('tableContainer');

    // add delete column to the end
    const option = {
      container: container!,
      columns: this.getColDefs(),


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
        hover: { cellBgColor: 'lightgrey' }
      },

      bodyStyle: {
        borderColor: 'white',
        hover: {
          cellBgColor: 'lightgrey',
        }
      },
      checkboxStyle: { defaultFill: 'grey' },
      frameStyle: { cornerRadius: 0, borderColor: 'rgba(255, 255, 255, 1)', borderLineWidth: 7.456, shadowColor: 'rgba(0,0,0, 1)', shadowBlur: 4, shadowOffsetX: 0, shadowOffsetY: 0 },
    });

    return option;
  }

  // styling and drawing the table
  drawVTable() {
    // draw it up!
    const option: any = this.getTableOptions();

    // create table
    const table = new VTable.ListTable(option);

    table.setRecords(this.faqs);
  }
}
