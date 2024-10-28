import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  FormsModule
} from '@angular/forms';
import {
  AccordionButtonDirective,
  AccordionComponent,
  AccordionItemComponent,
  TemplateIdDirective,
  FormCheckComponent
} from '@coreui/angular';

import { ButtonDirective, FormModule } from '@coreui/angular';

import { Store } from '@ngrx/store';
import { take } from 'rxjs/operators';
import { Actions, ofType } from '@ngrx/effects';

import { AccordianParentComponent } from '@src/components/common/components/accordian-parent/accordian-parent.component';

import { invokeContentFetchAPI, contentFetchAPI_Success, invokeContentCreateAPI, invokeUpdateContentAPI, invokeDeleteContentAPI } from '@src/store/actions/content.action';
import { selectContents, selectPosts } from '@src/store/selectors/content.selector';

import { Content } from '@src/store/models/Content';

@Component({
  selector: 'app-posts',
  standalone: true,
  imports: [
    CommonModule, FormsModule, FormModule, FormCheckComponent, AccordianParentComponent,
    AccordionComponent,
    AccordionItemComponent,
    TemplateIdDirective,
    AccordionButtonDirective,
    ButtonDirective
  ],
  templateUrl: './posts.component.html',
  styleUrl: './posts.component.scss'
})
export class PostsComponent {
  constructor(private readonly store: Store, private actions$: Actions) {
  }

  posts: any[] = [];
  newPostString = 'Add Post';

  ngOnInit() {

    this.store.select(selectContents).subscribe((content) => {
      this.posts = content.filter((c) => c.content_type_id === 6);

      console.log('proceses ', this.posts);
    });
  }
}
