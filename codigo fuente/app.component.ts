import { Component, OnInit } from '@angular/core';
import { AuthService } from './services/auth.service';

@Component({
  selector: 'virtualid-root'',
  templateUrl: './app.component.html',
  styleUrls: ['./styles.css']
})
export class AppComponent implements OnInit {
  title = 'VirtualID';
  usuario = '';
  autenticado = false;
  cargando = false;
  errorMensaje = '';

  constructor(private authService: AuthService) {}

  ngOnInit(): void {
    this.verificarSesion();
  }

  verificarSesion(): void {
    const token = localStorage.getItem('token');
    if (token) {
      this.autenticado = true;
    }
  }

  async iniciarSesion(): Promise<void> {
    this.cargando = true;
    this.errorMensaje = '';
    try {
      const resultado = await this.authService.autenticarRostro(this.usuario);
      if (resultado.exito) {
        this.autenticado = true;
        localStorage.setItem('token', resultado.token);
      } else {
        this.errorMensaje = 'Rostro no reconocido. Intenta de nuevo.';
      }
    } catch (error) {
      this.errorMensaje = 'Error de conexion. Verifica tu internet.';
    } finally {
      this.cargando = false;
    }
  }

  cerrarSesion(): void {
    this.autenticado = false;
    this.usuario = '';
    localStorage.removeItem('token');
  }
}
