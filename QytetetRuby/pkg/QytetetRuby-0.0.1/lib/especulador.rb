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
    if super.debo_ir_a_carcel && !pagar_fianza
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
    
  end
end
