#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require "singleton"

module ModeloQytetet
 class Dado
  include Singleton
  
  attr_reader:valor
  
 def initialize
   @valor = 0
 end
 private :initialize
  
  def tirar
    @valor = rand(6) + 1
     
    @valor
  end
    
  def to_s
    "El valor del dado es: #{@valor}"
  end
 end
end