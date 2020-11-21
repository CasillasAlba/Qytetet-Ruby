#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require_relative "sorpresa"
require_relative "tipo_sorpresa"
require_relative "tipo_casilla"
require_relative "casilla"
require_relative "otra_casilla"
require_relative "calle"
require_relative "titulo_propiedad"
require_relative "tablero"
require_relative "jugador"
require_relative "dado"
require_relative "metodo_salir_carcel"
require_relative "estado_juego"
require_relative "especulador"
require "singleton"

module ModeloQytetet
    class Qytetet
      
    include Singleton
    
    @@MAX_JUGADORES = 4
    @@NUM_SORPRESAS = 10
    @@NUM_CASILLAS = 20
    @@PRECIO_LIBERTAD = 200
    @@SALDO_SALIDA = 1000
    
    attr_reader :mazo, :tablero, :jugador_actual, :dado, :jugadores, :estado_juego
    attr_accessor :carta_actual
    
    def initialize
      @dado = Dado.instance
      @jugador_actual = nil
      @carta_actual = nil
      @estado_juego = EstadoJuego::JA_PREPARADO
      @jugadores = Array.new
    end
    
    def inicializar_jugadores(nombres)
      nombres.each do |i|
        j = Jugador.nuevo(i)
        @jugadores << j
      end
      
    end
    
    def inicializar_tablero
      @tablero = Tablero.new
    end
    
    def inicializar_cartas_sorpresa
      @mazo = Array.new
        #CONVERTIRME
        @mazo << Sorpresa.new("Como eres el más chulo del barrio, te vuelves un Especulador", 
                3000, TipoSorpresa::CONVERTIRME)
        @mazo << Sorpresa.new("¡Wow! Te has convertido en Especulador", 5000, TipoSorpresa::CONVERTIRME)       
        #PAGARCOBRAR
        @mazo << Sorpresa.new("Te has encontrado una cartera en la calle.
                Ganas 275 euros", 275, TipoSorpresa::PAGARCOBRAR)
        @mazo << Sorpresa.new("Invitas a tu novia a una cita romantica y quieres
                 estar a la altura. Te gastas en ella 100 euros",
                 -100, TipoSorpresa::PAGARCOBRAR)
        #IRACASILLA
        @mazo << Sorpresa.new("Quieres ir a la discoteca Copera, obviamente en la
                 calle Copera. Avanzas a la casilla 13.", 13, TipoSorpresa::IRACASILLA)
        @mazo << Sorpresa.new("Tu novia vive en la calle Salsipuedes y vas a su
                casa para darle una sorpresa. Avanzas a la casilla 18",18,
                TipoSorpresa::IRACASILLA)
        @mazo << Sorpresa.new("Te han pillado consumiendo droga. Vas a la carcel",
                 9, TipoSorpresa::IRACASILLA)
        #PORCASAOTEL
        @mazo << Sorpresa.new("Tu amigo de la infancia es arquitecto, y te ha hecho
                unas construcciones de lujo. Cobras 60 euros por casa/hotel",60,
                TipoSorpresa::PORCASAHOTEL)
        @mazo << Sorpresa.new("Han descubierto el escondite de unos narcotraficanes
                en una de tus construcciones. Ahora debes pagar 95 euros por
                cada casa/hotel", -95, TipoSorpresa::PORCASAHOTEL)
        #PORJUGADOR
        @mazo << Sorpresa.new("Es tu cumpleaños. Tus amigos te dan 20 euros cada
                uno", 20, TipoSorpresa::PORJUGADOR)
        @mazo << Sorpresa.new("Sales de la discoteca e invitas a tus amigos a ir
                de after. Pagas 15 euros a cada uno", -15, TipoSorpresa::PORJUGADOR)
        #SALIRCARCEL
        @mazo << Sorpresa.new("Tu amigo el camello ha ganado más de lo normal y 
                te paga la fianza",0,TipoSorpresa::SALIRCARCEL)   
      
        @mazo = @mazo.shuffle!
      
   end
   
   def inicializar_juego(nombres)
     inicializar_jugadores(nombres)
     inicializar_tablero
     inicializar_cartas_sorpresa
     salida_jugadores
   end
   
    def actuar_si_en_casilla_edificable
      debo_pagar = @jugador_actual.debo_pagar_alquiler
      
      if debo_pagar
        @jugador_actual.pagar_alquiler
        
        if @jugador_actual.saldo <= 0
          @estado_juego = EstadoJuego::ALGUNJUGADORENBACARROTA
        end
      end
      
      casilla = obtener_casilla_jugador_actual
      
      tengo_propietario =  casilla.tengo_propietario
      
      if @estado_juego != EstadoJuego::ALGUNJUGADORENBANCARROTA
        if tengo_propietario
          @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
        else
          @estado_juego = EstadoJuego::JA_PUEDECOMPRAROGESTIONAR
        end
      end
    end  
    
    def actuar_si_en_casilla_no_edificable
      @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
      
      casilla_actual = @jugador_actual.casilla_actual
      
      if casilla_actual.tipo == TipoCasilla::IMPUESTO
        @jugador_actual.pagar_impuesto
      else
        if casilla_actual.tipo == TipoCasilla::JUEZ
          encarcelar_jugador
        else
          if casilla_actual.tipo == TipoCasilla::SORPRESA
           @carta_actual = @mazo.at(0) 
           @mazo.delete_at(0) 
           @estado_juego = EstadoJuego::JA_CONSORPRESA
          end
      end
    end
    end
    
    def aplicar_sorpresa
            @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR

      if(@carta_actual.tipo == TipoSorpresa::SALIRCARCEL)
        @jugador_actual.carta_libertad = @carta_actual

      else
        @mazo << @carta_actual

        if(@carta_actual.tipo == TipoSorpresa::PAGARCOBRAR)
          @jugador_actual.modificar_saldo(@carta_actual.valor)

          if(@jugador_actual.saldo <= 0)
            @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
          end

        else
          if(@carta_actual.tipo == TipoSorpresa::IRACASILLA)
            valor = @carta_actual.valor
           
            casilla_carcel = @tablero.es_casilla_carcel(valor)
            
            if(casilla_carcel)
              encarcelar_jugador()
            else
              @jugador_actual.casilla_actual = @tablero.obtener_casilla_numero(valor)
            end

          else
            if(@carta_actual.tipo == TipoSorpresa::PORCASAHOTEL)
              cantidad = @carta_actual.valor
              numeroTotal = @jugador_actual.cuantas_casas_hoteles_tengo()

              @jugador_actual.modificar_saldo(cantidad*numeroTotal);

              if(@jugador_actual.saldo <= 0)
                @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
              end

            else
              if(@carta_actual.tipo == TipoSorpresa::PORJUGADOR)
                for jug in @jugadores do

                  if(jug != @jugador_actual)
                    jug.modificar_saldo(-@carta_actual.valor)

                    if(jug.saldo <= 0)
                      @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
                    end
                  

                  @jugador_actual.modificar_saldo(@carta_actual.valor)
                  
                  if(@jugador_actual.saldo <= 0)
                    @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
                  end
                  end
                end
              else
                if (@carta_actual.tipo == TipoSorpresa::CONVERTIRME)
                  jug_especulador = @jugador_actual.convertirme(@carta_actual.valor);
                   
                  posiciones = 0
                   
                  while (@jugador_actual != @jugadores.at(posiciones))
                    posiciones = posiciones + 1
                  end
                  
                  @jugadores[posiciones] = jug_especulador
                  @jugador_actual = jug_especulador
                end
              end

            end

          end

        end

      end
    end
    
    def cancelar_hipoteca(numero_casilla)
      cancelada = false
      
      casilla = @tablero.obtener_casilla_numero(numero_casilla)
      titulo = casilla.titulo
      
      cancelada = @jugador_actual.cancelar_hipoteca(titulo)
        
      @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
        
      cancelada
    end
    
    def comprar_titulo_propiedad
      comprado = @jugador_actual.comprar_titulo_propiedad
        
      if comprado
        @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
      end
            
      comprado  
    end
    
    def edificar_casa(numero_casilla)
      edificada = false
     
      casilla = @tablero.obtener_casilla_numero(numero_casilla)
      titulo = casilla.titulo
      edificada = @jugador_actual.edificar_casa(titulo)
               
      if edificada 
        @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
      end
       
      edificada
    end
    
    def edificar_hotel(numero_casilla)
      edificado = false

      casilla = @tablero.obtener_casilla_numero(numero_casilla)
        
      titulo = casilla.titulo
        
      edificado = @jugador_actual.edificar_hotel(titulo)
        
      if edificado
        @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
      end  
       
        edificado
    end
    
    def encarcelar_jugador
      if @jugador_actual.debo_ir_a_carcel       
          casilla_carcel = @tablero.carcel
          @jugador_actual.ir_a_carcel(casilla_carcel)
            
          @estado_juego =EstadoJuego::JA_ENCARCELADO
      else 
        carta = @jugador_actual.devolver_carta_libertad
        @mazo << carta
        @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
      end
      
    end
    
    def hipotecar_propiedad(numero_casilla)
      casilla = @tablero.obtener_casilla_numero(numero_casilla)
      titulo = casilla.titulo
        
      @jugador_actual.hipotecar_propiedad(titulo)
    end
    
    def intentar_salir_carcel(metodo)
      if metodo == MetodoSalirCarcel::TIRANDODADO
            resultado = tirar_dado
            
            if resultado >= 5
                @jugador_actual.encarcelado = false
            end
      else 
        if  metodo == MetodoSalirCarcel::PAGANDOLIBERTAD
            @jugador_actual.pagar_libertad(@@PRECIO_LIBERTAD)
        end
      end  
        
        encarcelado = @jugador_actual.encarcelado
        
        if encarcelado
            @estado_juego = EstadoJuego::JA_ENCARCELADO
        else
            @estado_juego = EstadoJuego::JA_PREPARADO
        end
        
        encarcelado
    end
    
    def jugar 
      jugada = tirar_dado
    c = @tablero.obtener_casilla_final(@jugador_actual.casilla_actual, jugada)

    mover(c.num_casilla)
    
    end
    
    def mover(num_casilla_destino)
      casilla_inicial = @jugador_actual.casilla_actual
      casilla_final = @tablero.casillas.at(num_casilla_destino)
      
      @jugador_actual.casilla_actual = casilla_final
      
      if casilla_final.num_casilla < casilla_inicial.num_casilla
        @jugador_actual.modificar_saldo(@@SALDO_SALIDA)
      end
      
      if casilla_final.soy_edificable
        actuar_si_en_casilla_edificable
      else
        actuar_si_en_casilla_no_edificable
      end    
    end
    
    def obtener_casilla_jugador_actual
       @jugador_actual.casilla_actual
    end
    
    def obtener_casillas_tablero
      @tablero.casillas
    end
    
    def obtener_propiedades_jugador
      aux = Array.new
      las_propiedades = @jugador_actual.propiedades
       
        #Para cada casilla, se comprueba cual es del propietario
        for c in @tablero.casillas do
            
            for p in las_propiedades do
                if c.titulo == p
                    aux << c.num_casilla
                end
            end
        end
       
        aux
    end
    
    def obtener_propiedades_jugador_segun_estado_hipoteca(estado_hipoteca)
      aux = Array.new
        las_propiedades = @jugador_actual.obtener_propiedades(estado_hipoteca)
       
        #Para cada casilla, se comprueba cual es del propietario
        for c in @tablero.casillas do
            
            for p in las_propiedades do
                if c.titulo == p
                    aux << c.num_casilla
                end
            
            end
        end
        aux
    end
    
    def obtener_ranking
      @jugadores = @jugadores.sort
    end
    
    def obtener_saldo_jugador_actual
      @jugador_actual.saldo
    end
    
    def salida_jugadores
      
      salida = @tablero.obtener_casilla_numero(0)
      
      for i in @jugadores do
        i.casilla_actual=salida
      end
      
      inicial = rand(@jugadores.length)
      
      @jugador_actual = @jugadores.at(inicial)  
  
    end
    
    def siguiente_jugador
      #Posicion de tu jugador en el array de jugadores
      @jugador_actual=@jugadores[(@jugadores.index(@jugador_actual)+1)%@jugadores.size]
      
      if @jugador_actual.encarcelado
        @estado_juego = EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
      else
        @estado_juego = EstadoJuego::JA_PREPARADO
      end
    end
    
    def tirar_dado
     @dado.tirar  
    end
    
    def vender_propiedad(numero_casilla)

      casilla = @tablero.obtener_casilla_numero(numero_casilla)
        
      @jugador_actual.vender_propiedad(casilla)
        
      @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR 
    end
    
    def to_s
     puts "Mazo: \n"
    
      @mazo.each do |m| 
       puts m.to_s
      end
      
     puts "Tablero: \n" 
     
     puts @tablero.to_s
     
      
     puts "Jugadores: \n"
     
     @jugadores.each do |j|
       puts j.to_s
     end
     
     puts "Dado: #{@dado.to_s}"
 
    end
   
    private :encarcelar_jugador, :inicializar_jugadores,
      :inicializar_tablero, :salida_jugadores, :inicializar_cartas_sorpresa
      #:carta_actual=
    
    end   
end