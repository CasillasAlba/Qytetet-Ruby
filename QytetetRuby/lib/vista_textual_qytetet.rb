#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require_relative "controlador_qytetet"
require_relative "qytetet"
require_relative "opcion_menu"


module VistaTextualQytetet
 
  class VistaTextualQytetet
    
    @@modelo = nil
    @@controlador = nil
    @@ui = nil
    
    def initialize
      @@modelo = ModeloQytetet::Qytetet.instance
      @@controlador = ControladorQytetet::ControladorQytetet.instance
    end
    
    def obtener_nombre_jugadores      
      nombres = Array.new

      puts "Introduzca el numero de jugadores"
      numero = gets.chomp.to_i
      
      while numero <= 1 || numero > 4
        puts "Numero de jugadores incorrecto. Introduzca otro: "
        numero = gets.chomp.to_i
      end
      
      nombres = Array.new
      
      for i in(1..numero) do
        
        puts "Introduzca el nombre del jugador #{i}"
        cadena = gets.chomp
        nombres << cadena
        
      end
      
      nombres
    end
    
    def elegir_casilla(opcion_menu)
      casillas_validas = Array.new
      conversion = Array.new
      
      casillas_validas = @@controlador.obtener_casillas_validas(opcion_menu)
       
      for i in casillas_validas
          conversion << i.to_s
      end
       
       
      if casillas_validas.size == 0
        resultado = -1
      else
        puts "Casillas validas: "
        for c in casillas_validas
          puts c
        end
        res = leer_valor_correcto(conversion)
        resultado = res.to_i
      end
      
       return resultado;
       
    end
    
    
 def leer_valor_correcto(valores_correctos)
    correcto = false
    valor = " "
    
    while (!correcto)
        valor = gets.chomp
        for  s in valores_correctos
            if valor == s
                correcto = true
            end
      end
    
    if (!correcto)
    puts "Error, opcion incorrecta, vuelve a introducirla"
    end 
    
    end
    
    valor
    
  end
  
  def elegir_operacion
    opciones_validas = Array.new
    conversion = Array.new

    opciones_validas = @@controlador.obtener_operaciones_juego_validas
        
    for i in opciones_validas
      conversion << i.to_s
    end
        
    puts "OPCIONES A ELEGIR: "
    for i in opciones_validas
      puts "#{i} --> #{ControladorQytetet::OpcionMenu.at(i).to_s}"
    end
    
    res = leer_valor_correcto(conversion)
        
    resultado = res.to_i
        
        
    resultado 
  end
  
  def self.main
    puts "Vista textual"
    
    @@ui = VistaTextualQytetet.new

    @@controlador.nombre_jugadores = @@ui.obtener_nombre_jugadores
    casilla_elegida = 0
    operacion_elegida = -1 
    
     until operacion_elegida == ControladorQytetet::OpcionMenu.index(:TERMINARJUEGO) 
         
        operacion_elegida = @@ui.elegir_operacion
        necesita_casilla = @@controlador.necesita_elegir_casilla(operacion_elegida)
        if necesita_casilla   
            casilla_elegida = @@ui.elegir_casilla(operacion_elegida)
        end
        if (!necesita_casilla || casilla_elegida >= 0)
            puts @@controlador.realizar_operacion(operacion_elegida, casilla_elegida)
        end
     end
  end 
  end
  
VistaTextualQytetet.main
end
