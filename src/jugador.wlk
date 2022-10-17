import wollok.game.*
import secuencia.*
import powerUp.*
import menu.*

object jugador{
	var property desbloqueado=true
	var property listajugador=[]
	var property vidas = 3
	const powers = [aumentarTiempo, reducirTiempo, aumentarVidas, reducirVidas, aumentarColores, reducirColores]
	var puntuacionMasAlta=0
	
	method enciendeColor(color){
		if(desbloqueado){
			desbloqueado=false
			color.encendido()
			listajugador.add(color)
			game.schedule(200,{desbloqueado=true})
			self.secuenciaCorrecta()
		}
	}
	
method secuenciaCorrecta(){
		const listaSecuencia=secuencia.listaSecuencia()
		const tam=listajugador.size()
		if (listaSecuencia.take(tam)!=listajugador){
				self.restarVida()
		}
		else if(listaSecuencia==listajugador){
			if(tam%5==0){
				self.agregarPowerUp()
			}
			game.schedule(250,{desbloqueado=false})
			listajugador=[]
			secuencia.iniciarSecuencia()
		}
		puntuacionMasAlta=(tam).max(puntuacionMasAlta)
	}

	method sumarVida(){
		vidas=(vidas+1).min(3)
	}
	
	method restarVida(){
		vidas=(vidas-1)
		listajugador=[]
		if(vidas == 0 ){			
			gameOver.activar()
		}
		else{
			game.sound("incorrecto.mp3").play()
			secuencia.encenderColores()
		}
	}

	method cantidadVidas()=vidas

	method agregarPowerUp(){
		powers.anyOne().aplicarPowerUp()
	}
}