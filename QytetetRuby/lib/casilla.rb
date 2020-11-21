#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.



module ModeloQytetet
  class Casilla
=begin    attr_reader:num_casilla, :precio_compra, :tipo
    attr_accessor:titulo
    casilla.num_casilla, devuelve el valor del numero_casilla
    casilla.num_casilla = 3, cambia el valor de num_casilla a 3
    private :titulo=
=end

   #Practica 4
   attr_reader:num_casilla
   attr_accessor:precio_compra
   
   def initialize(num)
    @num_casilla = num
    @precio_compra = 0
=begin  @tipo = tip
    @titulo = tit
    if(tip == TipoCasilla::CALLE)
      @precio_compra = tit.precio_compra
    else
      @precio_compra = 0
    end
=end
   end
   
   

=begin   
   def self.constructor_calle(num, tit)
      self.new(num,tit, TipoCasilla::CALLE)
    
   end
   
   def self.constructor_casilla(num, tip)
      self.new(num,nil, tip)
   end
       
   def asignar_propietario(jugador)
     @titulo.propietario = jugador
     @titulo
   end
   
   def pagar_alquiler
     coste_alquiler = @titulo.pagar_alquiler
     
     coste_alquiler
   end
   
   def propietario_encarcelado
     @titulo.propieatio_encarcelado
   end
   
   def soy_edificable
    es_edificable = false
    
    if @tipo == TipoCasilla::CALLE
      es_edificable = true
    end 

    es_edificable
    
   end
   
   def tengo_propietario
     @titulo.tengo_propietario
   end
   
   def to_s
     if @tipo == TipoCasilla::CALLE
       puts "Numero casilla: #{@num_casilla}\n Coste: #{@precio_compra}\n Tipo: #{@tipo}\n #{@titulo.to_s}"
      else
       puts "Numero casilla: #{@num_casilla}\n Tipo: #{@tipo}\n Coste: #{@precio_compra}"

      end
  end
=end   
 end
end