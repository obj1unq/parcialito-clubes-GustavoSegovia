class Club {
	
	var property actividades=[]
	var property sanciones
	var property socios//s
	
	method perfilDelClub(_jugador)
	
	method sancionar(){
		if(self.socios()>500){sanciones=true}
		else sanciones=false
	}
}

class ClubProfesional inherits Club{
	
	override method perfilDelClub(_jugador){
		return _jugador.pase() > valorDelSistema.valor()
	}
	
}

class ClubComunitario inherits Club{
	
	override method perfilDelClub(_jugador){
		
		return _jugador.participacion()>= 3
	}
	
}

class ClubTradicional inherits Club{
	
	override method perfilDelClub(_jugador){
		
		if (_jugador.pase() > valorDelSistema.valor()) return true
		 else  return   _jugador.participacion()>= 3
	}
}



class ActividadSocial{
	
	var sanciones
	
	
	method sanciones()=sanciones
	
	method sancionar(){
		sanciones=true
	}
	method estaSuspendida(){
		return sanciones
	}
	method reanudar(){
		if(sanciones=true)sanciones=false
	}
}


class Equipo {
	
	var property sanciones
	
	var plantel=#{}
	
	method sanciones()=sanciones
	
	method sancionar(){
		sanciones=sanciones+1
	}
	
}

class Socio {
	
	var property antiguedad
	
	var property participacion
	
	method esEstrella()= antiguedad>20
}





class Jugador inherits Socio {
	
	var property partidosEnClub
	
	var property pase
	
	var property club
	
	var property capitan
	
	override method esEstrella(){
		
		if (partidosEnClub > 50)return true
		
		else return self.club().perfilDelClub(self)
		
	}
	
	
}

object valorDelSistema{
	
	var property valor
	method valor(_valor){
		valor=valor+_valor
	}
}







































