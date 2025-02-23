import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';

import { PlaygroundComponent } from '../components/playground/playground.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterModule, PlaygroundComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'ai-playground-frontend';
}
