#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.



module ModeloQytetet
  class Especulador < Jugador
    
    
  attr_accessor :fianza

=begin    
  def self.nuevo(n,f)
    super(n)
    @fianza = f
  end
=end
    
  def self.copia(j,f)
    e = super(j)
    e.fianza = f
    
    e
  end  
  
  def pagar_impuesto
      @saldo -= (@casilla_actual.precio_compra / 2)
  end
 
  
  def pagar_fianza
    tengo_saldo = false
        
    if tengo_saldo(@fianza)
      tengo_saldo = true
      modificar_saldo(-@fianza)
    end
        
    tengo_saldo 
  end
  
  
 def convertirme(fianza)
    self
 end
 
 def debo_ir_a_carcel
    ir_carcel = false
    if super && !pagar_fianza
      ir_carcel = true
    end
        
    ir_carcel
  end
  
 
  def puedo_edificar_casa(titulo)
      puedo_edificar = false

      num_casas = titulo.num_casas
        
      if num_casas < 8
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
      
     if num_casas >= 4
       num_hoteles = titulo.num_hoteles
      if num_hoteles < 8
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
   res = super.to_s
   res = res + "Especulador{ fianza= #{@fianza}}"
   
   res
 end
   
  private :pagar_fianza
  #protected :pagar_impuesto, :convertirme, :debo_ir_a_carcel, :puedo_edificar_casa, :puedo_edificar_hotel
    
 
=begin
Forma no definitiva de dejar los contructores de JUGADOR y ESPECULADOR...

CLASS JUGADOR

def initialize(nom)
  @nombre = nom
  @encarcelado=false
  @saldo = 7500
  @carta_libertad = nil
  @propiedades = Array.new
  @casilla_actual = nil
end

def self.nuevo(nom)
  self.new(nom)
end

def self.copia(otro_jugador)
  self.new(otro_jugador.nombre)
  @encarcelado = otro_jugador.encarcelado
  @saldo = otro_jugador.saldo
  @carta_libertad = otro_jugador.carta_libertad
  @propiedades = otro_jugador.propiedaddes
  @casilla_actual = otro_jugador.casilla_actual
end

CLASS ESPECULADOR

def(fian)
@fianza = fian
end

def self.copia(un_jugador, fian)
 espec = self.new(fian)

  espec.nombre = un_jugador.nombre
  espec.encarcelado = un_jugador.encarcelado
  espec.saldo = un_jugador.saldo
  espec.carta_libertad = un_jugador.carta_libertad
  espec.propiedades = un_jugdor.propiedades
  espec.casilla_actual = un_jugador.casilla_actual
end


=end
  end
end
