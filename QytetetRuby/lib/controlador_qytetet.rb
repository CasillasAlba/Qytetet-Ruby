#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


#Si usas require, haces include y si haces require_relative no haces include
#Ejemplo: require singleton coge to pero al hacer el include coges justo el singleton ese raro


#NO se hace el require_relative de modulos ya que este se indica en los metodos.

require "singleton"
require_relative "estado_juego"
require_relative "metodo_salir_carcel"
require_relative "qytetet"
require_relative "opcion_menu"

module ControladorQytetet
  
  class ControladorQytetet
    include Singleton
    
 
    @@controlador  = nil #No se hace la instancia de un objeto de tu misma clase!!
    @@modelo = ModeloQytetet::Qytetet.instance #Hacemos la instancia porque qytetet es singleton, pero
                                #hay que indicar que Qyetet pertenece A OTRO MODULO
    
    attr_accessor :nombre_jugadores, :opcion, :modelo, :controlador
    
    def initialize
      @nombre_jugadores = Array.new
      @opcion = nil
    end
    private :initialize
    
    def obtener_operaciones_juego_validas
     opciones_validas = Array.new
     
      if @@modelo.jugadores.size == 0
        opciones_validas << OpcionMenu.index(:INICIARJUEGO)
      else
        opciones_validas << OpcionMenu.index(:TERMINARJUEGO)
        opciones_validas << OpcionMenu.index(:MOSTRARJUGADORACTUAL)
        opciones_validas << OpcionMenu.index(:MOSTRARJUGADORES)
        opciones_validas << OpcionMenu.index(:MOSTRARTABLERO)
        
        case  @@modelo.estado_juego
        when ModeloQytetet::EstadoJuego::JA_PREPARADO
          opciones_validas << OpcionMenu.index(:JUGAR)
          
        when ModeloQytetet::EstadoJuego::JA_ENCARCELADO
          opciones_validas << OpcionMenu.index(:PASARTURNO)
         
        when ModeloQytetet::EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
          opciones_validas << OpcionMenu.index(:INTENTARSALIRCARCELPAGANDOLIBERTAD)
          opciones_validas << OpcionMenu.index(:INTENTARSALIRCARCELTIRANDODADO)
          
        when ModeloQytetet::EstadoJuego::JA_PUEDECOMPRAROGESTIONAR
          opciones_validas << OpcionMenu.index(:PASARTURNO)
          opciones_validas << OpcionMenu.index(:COMPRARTITULOPROPIEDAD)
          opciones_validas << OpcionMenu.index(:VENDERPROPIEDAD)
          opciones_validas << OpcionMenu.index(:HIPOTECARPROPIEDAD)
          opciones_validas << OpcionMenu.index(:CANCELARHIPOTECA)
          opciones_validas << OpcionMenu.index(:EDIFICARCASA)
          opciones_validas << OpcionMenu.index(:EDIFICARHOTEL)
          
        when ModeloQytetet::EstadoJuego::JA_PUEDEGESTIONAR
          opciones_validas << OpcionMenu.index(:PASARTURNO)
          opciones_validas << OpcionMenu.index(:VENDERPROPIEDAD)
          opciones_validas << OpcionMenu.index(:HIPOTECARPROPIEDAD)
          opciones_validas << OpcionMenu.index(:CANCELARHIPOTECA)
          opciones_validas << OpcionMenu.index(:EDIFICARCASA)
          opciones_validas << OpcionMenu.index(:EDIFICARHOTEL)
          
        when ModeloQytetet::EstadoJuego::JA_CONSORPRESA
          opciones_validas << OpcionMenu.index(:APLICARSORPRESA)
          
        when ModeloQytetet::EstadoJuego::ALGUNJUGADORENBANCARROTA
          opciones_validas << OpcionMenu.index(:OBTENERRANKING)
        end
      end
      
      opciones_validas = opciones_validas.sort
      opciones_validas
      
    end
    
    def necesita_elegir_casilla(opcion_menu)
      elegida = false
      opcion_modifica = Array.new
      
      opcion_modifica << OpcionMenu.index(:HIPOTECARPROPIEDAD)
      opcion_modifica << OpcionMenu.index(:CANCELARHIPOTECA)
      opcion_modifica << OpcionMenu.index(:EDIFICARCASA)
      opcion_modifica << OpcionMenu.index(:EDIFICARHOTEL)
      opcion_modifica << OpcionMenu.index(:VENDERPROPIEDAD)
      
      for i in opcion_modifica
        if opcion_menu == i
          elegida = true
        end
      end
      
      elegida
    end
    
    def obtener_casillas_validas (opcion_menu)
      props = Array.new
      
      #aux = OpcionMenu.at(opcion_menu) Aux ahora vale el nombre del elemento (ej: EDIFICARCASA)
      #@opcion = OpcionMenu.index(aux)
      #if @opcion == OpcionMenu.index(:HIPOTECARPROPIEDAD)
      
      if opcion_menu == OpcionMenu.index(:HIPOTECARPROPIEDAD)
        props = @@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(false)
       else if opcion_menu == OpcionMenu.index(:CANCELARHIPOTECA)
          props = @@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(true)
        else if opcion_menu == OpcionMenu.index(:EDIFICARCASA)
           props = @@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(false)
         else if opcion_menu == OpcionMenu.index(:EDIFICARHOTEL)
            props = @@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(false)
          else if opcion_menu == OpcionMenu.index(:VENDERPROPIEDAD)
             props = @@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(false)
          end
         end
        end
       end
      end
      
      props
    end
    
    def realizar_operacion(opcion_elegida, casilla_elegida)
      s = " "
      
      @opcion = OpcionMenu.at(opcion_elegida)
      
      case @opcion
      when :INICIARJUEGO
       s = "¡Que empiece el juego!"
       @@modelo.inicializar_juego(@nombre_jugadores)
      when :APLICARSORPRESA
        s = "Se aplica la carta sorpresa: #{@@modelo.carta_actual.to_s} "
        @@modelo.aplicar_sorpresa
      when :CANCELARHIPOTECA
        s = "El jugador: #{@@modelo.jugador_actual.nombre} cancela la hipoteca de la #{casilla_elegida}"
        @@modelo.cancelar_hipoteca(casilla_elegida)
      when :COMPRARTITULOPROPIEDAD
        s = "El jugador: #{@@modelo.jugador_actual.nombre} va a compar la calle #{@@modelo.obtener_casilla_jugador_actual.num_casilla}"
        @@modelo.comprar_titulo_propiedad
      when :EDIFICARCASA
          s = "Edificando una casa en la calle #{casilla_elegida}"
        @@modelo.edificar_casa(casilla_elegida)
      when :EDIFICARHOTEL
        if @@modelo.obtener_casilla_jugador_actual.titulo.num_casas != 4
          s = "¡¡No puedes edificar un hotel hasta que tengas 4 casas!!"
        else
          s = "Edificando un hotel en la calle #{casilla_elegida}"
        end
        @@modelo.edificar_hotel(casilla_elegida)
      when :HIPOTECARPROPIEDAD
        s = "El jugador: #{@@modelo.jugador_actual.nombre} hipoteca la propiedad #{casilla_elegida}"
        @@modelo.hipotecar_propiedad(casilla_elegida)
      when :INTENTARSALIRCARCELPAGANDOLIBERTAD
        s = "El jugador: #{@@modelo.jugador_actual.nombre} intenta salir de la carcel PAGANDOLIBERTAD"
        @@modelo.intentar_salir_carcel(ModeloQytetet::MetodoSalirCarcel::PAGANDOLIBERTAD)
      when :INTENTARSALIRCARCELTIRANDODADO
        s = "El jugador: #{@@modelo.jugador_actual.nombre} intenta salir de la carcel TIRANDODADO"
        @@modelo.intentar_salir_carcel(ModeloQytetet::MetodoSalirCarcel::TIRANDODADO)
      when :JUGAR
        s = "\nEl jugador " + @@modelo.jugador_actual.nombre + " va a jugar su turno\n"
        cas = @@modelo.obtener_casilla_jugador_actual
        s = s + "\n\tCasilla Actual del jugador #{cas.num_casilla}\n"
        @@modelo.jugar()
        cas = @@modelo.obtener_casilla_jugador_actual
        s = s + "\tAl lanzar el dado ha salido #{@@modelo.dado.valor} y ha avanzado hasta la casilla #{cas.num_casilla}" 
      when :MOSTRARJUGADORACTUAL
        s = "Jugador actual: #{@@modelo.jugador_actual.to_s}"
      when :MOSTRARJUGADORES
        for jug in @@modelo.jugadores
          s += jug.to_s + "\n"
        end
      when :MOSTRARTABLERO
        s = @@modelo.tablero.to_s
      when :OBTENERRANKING
        s = "Obteniendo ranking de los jugadores..."
        @@modelo.obtener_ranking
        for a in @@modelo.jugadores
          s+= "#{a.nombre} con capital: #{a.obtener_capital}\n"  
        end
      when :PASARTURNO
        s = "¡Turno del siguiente jugador!"
        @@modelo.siguiente_jugador
        s += "\nEl jugador pasa a ser: #{@@modelo.jugador_actual.nombre}"
      when :TERMINARJUEGO
        s = "El juego ha terminado. Calculando ranking de los jugadores..."
        @@modelo.obtener_ranking
        for a in @@modelo.jugadores
          s+= "#{a.nombre} con capital: #{a.obtener_capital}\n"  
        end
      when :VENDERPROPIEDAD
        s = "El jugador: #{@@modelo.jugador_actual.nombre}  va a vender la propiedad"
        @@modelo.vender_propiedad(casilla_elegida)
      end
      
      s
    end

  end
end
