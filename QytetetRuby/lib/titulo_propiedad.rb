#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.



module ModeloQytetet
  class TituloPropiedad
    attr_accessor :nombre, :hipotecada, :precio_compra, :alquiler_base, 
      :factor_revalorizacion, :hipoteca_base, :precio_edificar, :num_hoteles, 
      :num_casas, :propietario
    
    def initialize(nom, pcompra, alqbase, facrev, hipbase, pedif)
      @nombre = nom
      @hipotecada = false
      @precio_compra = pcompra
      @alquiler_base = alqbase
      @factor_revalorizacion = facrev
      @hipoteca_base = hipbase
      @precio_edificar = pedif
      @num_hoteles = 0
      @num_casas = 0
      @propietario = nil
    end
    
    def calcular_coste_cancelar
      coste = calcular_coste_hipotecar*0.10
      
      coste
    end
    
    def calcular_coste_hipotecar
      coste_hipoteca = @hipoteca_base + @num_casas*0.5*@hipoteca_base 
          + @num_hoteles + @hipoteca_base
          
      coste_hipoteca
      
    end
    
    def calcular_importe_alquiler
      coste_alquiler = @alquiler_base + @num_casas*0.5 + @num_hoteles*2
      
      coste_alquiler
    end

    def calcular_precio_venta
      precio_venta = @precio_compra + (@num_casas + @num_hoteles)*@precio_edificar*@factor_revalorizacion  
        
      precio_venta
    end
    
    def cancelar_hipoteca
      @hipotecada = false
    end

    def edificar_casa
      @num_casas = @num_casas + 1
    end
    
    def edificar_hotel
      @num_hoteles = @num_hoteles + 1
    end
    
    def hipotecar
      coste_hipoteca = calcular_coste_hipotecar 
      @hipotecada = true 
       
      coste_hipoteca
    end
    
    def pagar_alquiler
      coste_alquiler = calcular_importe_alquiler
     
      @propietario.modificar_saldo(coste_alquiler)
      
      coste_alquiler
    end
    
    def propietario_encarcelado
      esta_encarcelado = false
        
      if (@propietario.encarcelado)
       esta_encarcelado = true
      end
        
      esta_encarcelado
      
    end
    
    def tengo_propietario
      
      es_propietario = false
        
      if @propietario != nil
          es_propietario = true  
      end
        
      es_propietario 
    end
    
    def to_s
      "Nombre: #{@nombre}. \n Hipotecada: #{@hipotecada}.
      \n Alquiler base: #{@alquiler_base}. \n Precio compra: #{@precio_compra}
      Factor de revalorización: #{@factor_revalorizacion}. 
      \n Hipoteca base: #{@hipoteca_base}. \n
      Precio de edificación: #{@precio_edificar} \n Numero de casas #{@num_casas}
      \n Numero de hoteles #{@num_hoteles} \n Propietario: " + (@propietario == nil ? "No tiene propietario" : @propietario.nombre) +"}"
    end 
  end
 end