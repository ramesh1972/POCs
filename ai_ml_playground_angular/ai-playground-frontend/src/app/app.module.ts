import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { AppComponent } from './app.component';
import { AppRoutingModule } from './app-routing.module';
import { PlaygroundComponent } from '../components/playground/playground.component';
import { ExecutionService } from '../services/execution.service';

@NgModule({
  declarations: [PlaygroundComponent],
  imports: [BrowserModule, FormsModule, PlaygroundComponent],
  providers: [ExecutionService],
  bootstrap: [],
})
export class AppModule {}