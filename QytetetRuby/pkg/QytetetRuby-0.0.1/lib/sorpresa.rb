#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.



module ModeloQytetet
  class Sorpresa
    attr_reader :texto, :valor, :tipo
    
    def initialize(te, va, ti)
      @texto = te
      @valor = va
      @tipo = ti
    end
    
    def to_s
      puts "Texto: #{@texto} \n Tipo: #{@tipo} \n Valor: #{@valor} "
    end
  end
    
end
