#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  class OtraCasilla < Casilla
    
    attr_accessor :tipo
    attr_reader :titulo
    
    def initialize(num, tipo)
      super(num)
      @tipo = tipo
      @titulo = nil
      if(@tipo == TipoCasilla::IMPUESTO)
        @precio_compra = 300
      end
    end
    
    def soy_edificable
      false
    end
    
    def to_s
      "Numero casilla: #{@num_casilla}\n Tipo: #{@tipo}\n"
      #puts "Numero casilla: #{@num_casilla}\n Tipo: #{@tipo}\n"
    end
    
    #protected :tipo, :soy_edificable
  end
end
