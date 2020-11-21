#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require_relative "qytetet"


module ModeloQytetet
  class Tablero
    attr_reader:casillas
    attr_accessor:carcel
    
   def initialize()
    inicializar
   end
   
    def inicializar 
      @casillas = Array.new
      
      @casillas << OtraCasilla.new(0, TipoCasilla::SALIDA)
      @casillas << Calle.new(1,
        TituloPropiedad.new("Calle Arabasta",500,70,50,115,130))
      @casillas << Calle.new(2,
        TituloPropiedad.new("Calle Abrazamozas",732,240,73,160,220))
      @casillas << OtraCasilla.new(3, TipoCasilla::PARKING)
      @casillas << Calle.new(4,
        TituloPropiedad.new("Calle Porriño",900,305,90,540,577))
      @casillas << Calle.new(5,
        TituloPropiedad.new("Calle de la Duda",666,80,66,200,215))
      @casillas << OtraCasilla.new(6, TipoCasilla::SORPRESA)
      @casillas << Calle.new(7,
        TituloPropiedad.new("Calle Quilombo",1080,256,108,640,610))
      @casillas << Calle.new(8,
        TituloPropiedad.new("Calle de los Gorrones",835,136,83,490,415))
      @casillas << OtraCasilla.new(9, TipoCasilla::CARCEL)
      @casillas << Calle.new(10,
        TituloPropiedad.new("Calle Parderrubias",699,160,69,340,355))
      @casillas << Calle.new(11,
        TituloPropiedad.new("Calle Dressrosa",1000,213,100,675,690))
      @casillas << OtraCasilla.new(12, TipoCasilla::SORPRESA)
      @casillas << Calle.new(13,
        TituloPropiedad.new("Calle Copera",2005,310,200,760,830))
      @casillas << OtraCasilla.new(14, TipoCasilla::IMPUESTO)
      @casillas << Calle.new(15,
        TituloPropiedad.new("Calle Estrambótica",1365,195,136,727,800))
      @casillas << OtraCasilla.new(16, TipoCasilla::SORPRESA)
      @casillas << Calle.new(17,
        TituloPropiedad.new("Calle Salsipuedes",1340,160,134,710,750))
      @casillas << Calle.new(18,
        TituloPropiedad.new("Calle Raftel",2300,287,230,800,830))
      @casillas << OtraCasilla.new(19, TipoCasilla::JUEZ)
      
      @carcel = @casillas.at(9)
    end
    
    private :inicializar
    
    
    def es_casilla_carcel(numero_casilla)
      es_casilla = false;
        
      if numero_casilla == @carcel.num_casilla
            es_casilla = true
      end
        
      es_casilla
    end
    
    def obtener_casilla_final(casilla, desplazamiento)
      @casillas.at((casilla.num_casilla + desplazamiento)%@casillas.size)       
    end
    
    def obtener_casilla_numero(numero_casilla)
      @casillas.at(numero_casilla)
    end
    
    def to_s      
     puts "\nCasillas:  "

      for cas in @casillas
        puts "\t #{cas.to_s}"
      end

      puts  "\n\tCarcel:"
      puts @carcel.to_s
    end
 end
end