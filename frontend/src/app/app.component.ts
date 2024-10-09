import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { ApiService } from './services/api.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'Community Day GT';
  data: any;

  constructor(private apiService: ApiService) {};

  ngOnInit(): void {
    this.apiService.getData().subscribe(
      (response) => this.data = response,
      (error) => console.error('Error al obtener los datos de la API', error)
    );
  }
}
