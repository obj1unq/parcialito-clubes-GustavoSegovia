class Club {
	
	var property actividades=[]
	var property sanciones
	var property socios
	var property evaluacionBruta
	var property gastoMensual
	
	method perfilDelClub(_jugador)
	
	method socios(_numero){
		socios=socios+_numero
	}
	
	method sancionar(){
		if(self.socios()>500){sanciones=true}
		else sanciones=false
	}
	method evaluacion(){
		return evaluacionBruta/socios
	}
	method sociosDestacados(){
		return actividades.map({actividad=>actividad.socioDestacado()})
	}
	method sociosEstrellas(){
		return self.sociosDestacados().map({socio=>socio.esEstrella()})
	} 
	method esPrestigioso(){
		 self.actividades().any({actividad=>actividad.esExperimentado()})
		 self.actividades().any({actividad=>actividad.participantesEstrellas()>5})		 
	}
	method transferir(_jugador,equipoA,equipoB){
		if (not actividades.contains(equipoA) and not actividades.contains(equipoB))
		if (not _jugador.esEstrella()){
			_jugador.resetearPartidos()
			equipoA.club().actividades().foreach(_jugador.remove())
			equipoB.plantel().add(_jugador)
			equipoA.socios(-1)
			equipoB.socios(1)
		}
	}
}

class ClubProfesional inherits Club{
	
	override method perfilDelClub(_jugador){
		return _jugador.pase() > valorDelSistema.valor()
	}

	override method evaluacion(){
		return (self.actividades().sum({actividad=>actividad.evaluacion()})) - self.gastoMensual()*5
	}
	
}


class ClubComunitario inherits Club{
	
	override method perfilDelClub(_jugador){
		
		return _jugador.participacion()>= 3
	}
	
	override method evaluacion(){
		return self.actividades().sum({actividad=>actividad.evaluacion()})
	}
	
}

class ClubTradicional inherits Club{
	
	override method perfilDelClub(_jugador){
		
		if (_jugador.pase() > valorDelSistema.valor()) return true
		 else  return   _jugador.participacion()>= 3
	}
	override method evaluacion(){
		return self.actividades().sum({actividad=>actividad.evaluacion()}) - self.gastoMensual()
	}
}



class ActividadSocial{
	
	var property sanciones
	var property evaluacion
	var property organizador
	var property participantes=#{}
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
	
	method evaluacion(){
		
		return if(self.estaSuspendida())0
		       else evaluacion
	}
	method socioDestacado(){
		return organizador
	}
	method participantesEstrellas(){
		return participantes.count({participante=>participante.esEstrella()})
	}
}


class Equipo {
	
	var property club
	
	var property sanciones
	
	var property plantel=#{}
	
	var property campeonatosObtenidos
	
	method sanciones()=sanciones
	
	method sancionar(){
		sanciones=sanciones+1
	}
	method evaluacion(){
		return campeonatosObtenidos*5 + plantel.size()*2 + self.evaluacionDelCapitan() -sanciones*20
	}
	
	method capitan(){
		
		return plantel.find({jugador=>jugador.capitan()})
	}
	
	method evaluacionDelCapitan()=if(self.capitan().esEStrella()){2} else {0}
	
	method jugadoresEstrellas(){
		
		return plantel.count({jugador=>jugador.esEstrella()})
	}
	method socioDestacado(){
		return self.capitan()
	}
	method esExperimentado(){
		return self.plantel().all({jugador=>jugador.partidosEnClub()>10})
	}
}

class EquipoDeFutbol inherits Equipo{
	
	override method evaluacion(){
		return campeonatosObtenidos*5 + plantel.size()*2 + self.evaluacionDelCapitan() + self.jugadoresEstrellas()*5 -sanciones*30
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
	method resetearParidos(){
		partidosEnClub=0
	}
	
	
}

object valorDelSistema{
	
	var property valor
	method valor(_valor){
		valor=valor+_valor
	}
}







































