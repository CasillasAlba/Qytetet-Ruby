#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  class Calle < Casilla
    
    attr_accessor :tipo, :titulo
    
    def initialize (num, tit)
      super(num)
      @tipo = TipoCasilla::CALLE
      @titulo = tit
      @precio_compra = tit.precio_compra
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
      @titulo.propietario_encarcelado
    end
    
    
    def soy_edificable
      true
    end
    #protected :soy_edificable
    
    def tengo_propietario
      @titulo.tengo_propietario
    end
    
    def to_s
      "Numero casilla: #{@num_casilla}\n Coste: #{@precio_compra}\n Tipo: #{@tipo}\n #{@titulo.to_s}"
      #puts "Numero casilla: #{@num_casilla}\n Coste: #{@precio_compra}\n Tipo: #{@tipo}\n #{@titulo.to_s}"
    end
    
  end
end
