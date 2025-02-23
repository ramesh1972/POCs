import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ExecutionService } from '../../services/execution.service';

@Component({
  standalone: true,
  selector: 'app-playground',
  imports: [CommonModule],
  templateUrl: './playground.component.html',
  styleUrls: ['./playground.component.css']
})
export class PlaygroundComponent {
  projects = ['project1', 'project2'];
  output: string = '';

  constructor(private executionService: ExecutionService) {}

  executeScript(project: string) {
    this.output = 'Executing...';
    this.executionService.executeScript(project).subscribe(
      (data) => this.output = data,
      (error) => this.output = 'Error executing script'
    );
  }
}
