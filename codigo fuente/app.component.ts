import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./styles.css']
})
export class AppComponent {
  title = 'VirtualID';
  usuario = '';
  autenticado = false;

  iniciarSesion() {
    if (this.usuario !== '') {
      this.autenticado = true;
    }
  }

  cerrarSesion() {
    this.autenticado = false;
    this.usuario = '';
  }
}
