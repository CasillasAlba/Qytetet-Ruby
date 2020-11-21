#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require_relative "casilla"


module ModeloQytetet
  class Jugador
    
  @@SALDO_BASE = 7500
  
  attr_reader:nombre, :saldo, :propiedades
  attr_accessor:encarcelado, :carta_libertad, :casilla_actual
    
 
    def initialize(n, e, s, cl, ca, p)
      @nombre = n
      @encarcelado = e
      @saldo = s
      @carta_libertad = cl
      @casilla_actual = ca
      @propiedades = p 
    end
    
    def self.nuevo(n)
      self.new(n,false,@@SALDO_BASE,nil,nil,[])
    end
    
    def self.copia(jugador)
      self.new(jugador.nombre,jugador.encarcelado,jugador.saldo, jugador.carta_libertad, jugador.casilla_actual, jugador.propiedades)
    end
=begin    
    def initialize(n)
      @nombre = n
      @encarcelado = false
      @saldo = 7500
      @carta_libertad = nil
      @casilla_actual = nil
      @propiedades = Array.new
    end
    
    
    
    def self.copia(jugador)
      self.new(jugador.nombre)
      @encarcelado = jugador.encarcelado ;
      @saldo = jugador.saldo;
      @carta_libertad = jugador.carta_libertad;
      @casilla_actual = jugador.casilla_actual;
      @propiedades = jugador.propiedades;  
    end
=end    
    def <=>(otroJugador)
      otroJugador.obtener_capital <=> obtener_capital
    end
    
    def cancelar_hipoteca(titulo)
      cancelada = false
      coste = titulo.calcular_coste_cancelar
        
      if tengo_saldo(coste)
        titulo.cancelar_hipoteca
        cancelada = true
        modificar_saldo(-coste)
      end
        
      cancelada
    end
    
    def comprar_titulo_propiedad
      comprado = false 
        
      coste_compra = @casilla_actual.precio_compra
        
        if coste_compra < @saldo
          titulo = @casilla_actual.asignar_propietario(self)
          @propiedades << titulo
          modificar_saldo(-coste_compra)
          comprado = true
        end
        
      comprado
    end
    
    def cuantas_casas_hoteles_tengo
      contador = 0
      
      for p in @propiedades
        contador += p.num_casas + p.num_hoteles
      end

      contador
      
    end
    
    def debo_pagar_alquiler
      pagar_alquiler = false
        
      titulo = @casilla_actual.titulo
        
      es_de_mi_propiedad = es_de_mi_propiedad(titulo)
        
      if !es_de_mi_propiedad
        tiene_propietario = titulo.tengo_propietario
 
          if tiene_propietario
            encarcelado = titulo.propietario_encarcelado
      
            if !encarcelado
                esta_hipotecada = titulo.hipotecada
                   
                 if !esta_hipotecada
                       pagar_alquiler = true
                 end
            end
          end
      end
        
       pagar_alquiler
    end
    
    def devolver_carta_libertad
      aux = nil
      
      if @carta_libertad != nil
        aux = @carta_libertad
        @carta_libertad = nil
      end
      
      aux
    end
    
    def edificar_casa(titulo)
      edificada = false
     
        if puedo_edificar_casa(titulo)
          titulo.edificar_casa
          modificar_saldo(-titulo.precio_edificar)
          edificada = true
        end
      
      edificada
    end
    
    def edificar_hotel(titulo)
     edificado = false

     if puedo_edificar_hotel(titulo)
        titulo.edificar_hotel
        modificar_saldo(-titulo.precio_edificar)
        edificado = true
      end
       
     edificado
    end
    
    def eliminar_de_mis_propiedades(titulo)
      @propiedades.delete(titulo)
      
      titulo = nil
    end
    
    def es_de_mi_propiedad(titulo)
      es_propiedad = false
        
      for i in @propiedades do
        if i.equal?(titulo) 
          es_propiedad = true
        end
      end
        
      es_propiedad
      
    end
    
    def estoy_en_calle_libre
      raise NotImplementedError
    end
    
    def hipotecar_propiedad(titulo)
      coste_hipoteca = titulo.hipotecar
        
      modificar_saldo(coste_hipoteca)
    end
     
    def ir_a_carcel(casilla)
      @casilla_actual = casilla
      @encarcelado = true
    end
    
    def modificar_saldo(cantidad)
        @saldo += cantidad
        
       @saldo
    end
    
    def obtener_capital
      dinero = @saldo
        
      for i in @propiedades
        dinero += i.precio_compra + (i.num_casas + i.num_hoteles) * i.precio_edificar
        
        if i.hipotecada
          dinero -= i.hipoteca_base
        end
      end

      dinero
      
    end
    
    def obtener_propiedades(hipotecada)
      aux = Array.new
      
      for i in @propiedades
        if i.hipotecada == hipotecada
          aux << i
        end
      end
      
      aux
    end
    
    def pagar_alquiler    
      coste_alquiler = @casilla_actual.pagar_alquiler
       
      modificar_saldo(-coste_alquiler)
    end
    
    def pagar_impuesto
      @saldo -= @casilla_actual.precio_compra
    end
    
    def pagar_libertad(cantidad)
       tengo_saldo = tengo_saldo(cantidad)
        
      if tengo_saldo
        @encarcelado = false
        modificar_saldo(-cantidad)
      end
    end
    
    def tengo_carta_libertad
      tengo_carta = false
      
      if @carta_libertad != nil
        tengo_carta = true
      end
      
      tengo_carta
      
    end
    
    def tengo_saldo(cantidad)
      mucho_dinero = false
        
      if saldo > cantidad
        mucho_dinero = true
      end
        
      mucho_dinero
      
    end
    
    def vender_propiedad(casilla)  
      titulo = casilla.titulo
        
      eliminar_de_mis_propiedades(titulo)
         
      precio_venta = titulo.calcular_precio_venta
        
      modificar_saldo(precio_venta)
    end
    
    #Metodos Practica 4
    def convertirme (fianza)
        jug_especulador = Especulador.copia(self, fianza)
       
        jug_especulador;
    end
    
    def debo_ir_a_carcel
      !tengo_carta_libertad
    end
    
    def puedo_edificar_casa(titulo)
      puedo_edificar = false

      num_casas = titulo.num_casas
        
      if num_casas < 4
        coste_edificar_casa = titulo.precio_edificar
        tengo_saldo = tengo_saldo(coste_edificar_casa)
           
        if tengo_saldo
          puedo_edificar = true
        end
       end

       puedo_edificar
    end
    
    
   def puedo_edificar_hotel(titulo)
      puedo_edificar = false

      num_casas = titulo.num_casas
      
     if num_casas == 4
       num_hoteles = titulo.num_hoteles
      if num_hoteles < 4
        coste_edificar_casa = titulo.precio_edificar
        tengo_saldo = tengo_saldo(coste_edificar_casa)
           
        if tengo_saldo
          puedo_edificar = true
        end
       end
     end

       puedo_edificar
    end
   
    
    def to_s
      "Jugador {Nombre: #{@nombre}\t Saldo: #{@saldo}\t Encarcelado: #{@encarcelado}\t Carta Libertad: "  + (@carta_libertad == nil ? "No tiene Carta Libertad" : " Tiene Carta Libertad") + "\t Casilla actual: " + (@casilla_actual == nil ? "No esta en ninguna casilla" : "#{@casilla_actual.num_casilla}") +"\t Propiedades: " + (@propiedades.length == 0 ? "No tiene propiedades" : "Tiene propiedades") + "}"      
    end
    
    private :eliminar_de_mis_propiedades, :es_de_mi_propiedad
    #protected :convertirme, :debo_ir_a_carcel, :edificar_casa, :edificar_hotel, :pagar_impuesto,
    #  :puedo_edificar_casa, :puedo_edificar_hotel, :tengo_saldo
    
    
  end
end