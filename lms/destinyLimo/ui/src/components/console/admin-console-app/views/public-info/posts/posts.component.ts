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

import { AccordianParentComponent } from '../../../../../common/components/accordian-parent/accordian-parent.component';

import { invokeContentFetchAPI, contentFetchAPI_Success, invokeContentCreateAPI, invokeUpdateContentAPI, invokeDeleteContentAPI } from '@src/store/actions/content.action';
import { selectPosts } from '@src/store/selectors/content.selector';

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

    // set data
    this.store.dispatch(invokeContentFetchAPI());

    // Wait for the action to complete
    this.actions$.pipe(
      ofType(contentFetchAPI_Success),
      take(1)
    ).subscribe(() => {
      console.log("content fetch dispatched");

      this.store.select(selectPosts).subscribe((data: any) => {
        console.log('content fetched', data);

        this.posts = data.map((post: any) => {
          return {
            ...post,
            editing: false,
            adding: false
          };
        });
      });
    });
  }

  adjustTextareaHeight(event: Event): void {
    console.log('adjustTextareaHeight');
    const textarea = event.target as HTMLTextAreaElement;
    textarea.style.height = 'auto';
    textarea.style.height = `${textarea.scrollHeight}px`;
  }

  onAdd() {
    console.log('component onAdd');

    this.posts.unshift({
      title: 'Post Title',
      description: '',
      content_type_id: 6,
      adding: true,
      editing: false,
      is_active: true,
      is_public: true,
      is_deleted: false
    });

    this.posts.forEach((item: any, index: number) => {
      item.editing = false;
    });
  }

  onEdit(i: number) {
    console.log('component edit', i);

    this.posts.forEach((item: any, index: number) => {
      item.editing = false;
      item.adding = false;
    });

    this.posts[i].editing = true;
    this.posts[i].adding = false;
  }

  onDelete(i: number) {
    this.posts[i].is_deleted = true;
    this.store.dispatch(invokeUpdateContentAPI(this.posts[i]));

    // remove from the list array
    this.posts.splice(i, 1);

    this.posts[i].editing = false;
    this.posts[i].adding = false;
  }

  onSave(i: number) {
    console.log('component save', i);

    if (this.posts[i].adding) {
      this.store.dispatch(invokeContentCreateAPI({
        content: {
          Id: -1,
          content_type_id: this.posts[i].content_type_id,
          title: this.posts[i].title,
          description: this.posts[i].description,
          is_public: this.posts[i].is_public,
          is_active: this.posts[i].is_active,
          is_deleted: this.posts[i].is_deleted
        }
      }));
    } else if (this.posts[i].editing) {
      this.store.dispatch(invokeUpdateContentAPI({
        content: {
          Id: this.posts[i].id || -1,
          content_type_id: this.posts[i].content_type_id,
          title: this.posts[i].title,
          description: this.posts[i].description,
          is_public: this.posts[i].is_public,
          is_active: this.posts[i].is_active,
          is_deleted: this.posts[i].is_deleted
        }
      }));
    }

    this.posts[i].editing = false;
    this.posts[i].adding = false;
  }

  onCancel(i: number) {
    console.log('component cancel', i);
    if (this.posts[i].adding) {
      this.posts.splice(i, 1);
    }
    
    this.posts[i].editing = false;
    this.posts[i].adding = false;
  }
}
