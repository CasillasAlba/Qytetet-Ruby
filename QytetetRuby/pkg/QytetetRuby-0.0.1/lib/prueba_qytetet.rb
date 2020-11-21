#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#Alumna: Alba Casillas. 2ºA (A1)



require_relative "qytetet"


module ModeloQytetet
  class PruebaQytetet
    @@juego = Qytetet.instance
       
     def self.principal
       
       #Para coger objetos te recomiendo el 
       #for j in @@juego.jugadores do

       #end

       #Para hacer x iteraciones
       #for a in 0..6 do
     
      puts "Introduzca el numero de jugadores"
      numero = gets.chomp.to_i
      
      while numero <= 1 || numero > 4
        puts "Numero de jugadores incorrecto. Introduzca otro: "
        numero = gets.chomp.to_i
      end
      
      nombres = Array.new
      
      for i in(1..numero) do
        
        puts "Introduzca el nombre del jugador #{i}"
        cadena = gets.chomp
        nombres << cadena
        
      end
      
      
       @@juego.inicializar_juego(nombres)
     
  
       
    puts "Juego: \n"
     
    @@juego.to_s
       
    #Comprobamos que se cree correctamente el dado y que al tirarlo se 
    #genere un numero aleatorio del 1 al 6.
    
     
    @@juego.tirar_dado
    puts "Se ha tirado el dado"
    puts @@juego.dado
    
 
       
    #Comprobamos que los jugadores comiencen en la Casilla 0 (la inicial) 
    
    for jug in @@juego.jugadores do
      puts "#{jug.nombre} está en la casilla: #{jug.casilla_actual.num_casilla}"
    end  
       
    puts "Todos los jugadores han comenzado en la casilla inicial"

    puts "El primer jugador es: #{@@juego.jugador_actual.nombre}"  
        
        
    #Movimiento de los personajes
    #Probamos los metodos "mover" y "siguienteJugador"
    
     puts "Jugador: #{@@juego.jugador_actual.nombre}"
     
     puts "Jugador: #{@@juego.jugador_actual.nombre} esta en la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}" 
     
      @@juego.mover(1)
      
     puts "\t Y se mueve a la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}"
     
     puts "Jugador: #{@@juego.jugador_actual.nombre} tiene un saldo de #{@@juego.obtener_saldo_jugador_actual} euros "  

     puts "#{@@juego.jugador_actual.nombre} esta en la calle #{@@juego.obtener_casilla_jugador_actual.titulo.nombre}"
     
     puts "El precio de la calle es de #{@@juego.obtener_casilla_jugador_actual.titulo.precio_compra}" 
     
     if @@juego.comprar_titulo_propiedad
      puts "El jugador ha comprado la propiedad"
     else
      puts "No se ha podido comprar la propiedad"
     end
    
     puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros " 
       
     puts "Edificar una casa cuesta: #{@@juego.jugador_actual.casilla_actual.titulo.precio_edificar} euros"
     
      contador = 0
        
      while contador < 4 do
        if @@juego.edificar_casa(1)
            puts "El jugador ha edificado una casa"
        else
           puts "No se ha podido edificar"
        end
        
         contador = contador + 1
         
      end

      puts "El jugador ha edificado #{contador} casas"

      puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros " 
      
      puts "El jugador quiere edificar un hotel"
       
      if @@juego.edificar_hotel(1)
         puts "El jugador ha edificado un hotel"
      else
         puts "No se ha podido edificar"
      end
        
      puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros "
      
      
     @@juego.siguiente_jugador
       
     puts "Jugador: #{@@juego.jugador_actual.nombre}"
     
     puts "Jugador: #{@@juego.jugador_actual.nombre} esta en la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}" 
     
     @@juego.mover(2)
      
     puts "\t Y se mueve a la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}"
     
       
       
       
     #Probamos si sirven lo métodos de aplicarSorpresa, metiendo a un jugador en la carcel
     @@juego.siguiente_jugador
     
     puts "Jugador: #{@@juego.jugador_actual.nombre}"
     
     puts "Jugador: #{@@juego.jugador_actual.nombre} tiene un saldo de #{@@juego.obtener_saldo_jugador_actual} euros "
     
    @@juego.carta_actual = Sorpresa.new("Te han pillado consumiendo droga. Vas a la carcel", @@juego.tablero.carcel.num_casilla , TipoSorpresa::IRACASILLA)
     
     puts "Jugador: #{@@juego.jugador_actual.nombre} esta en la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}"  
     
     @@juego.aplicar_sorpresa 
     
     puts "\t Y se mueve a la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}"
     puts "Ahora el jugador esta en la carcel"
        
    #Comprobamos que puede salir de la cárcel
       
     @@juego.intentar_salir_carcel(MetodoSalirCarcel::PAGANDOLIBERTAD)
       
      if(@@juego.jugador_actual.encarcelado == true)
        puts "El jugador #{@@juego.jugador_actual.nombre} no ha salido de la cárcel"
      else
         puts "El jugador #{@@juego.jugador_actual.nombre} ha salido de la cárcel"
      end
       
      puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros " 
     
       
       
       #Probamos si los jugadores pueden moverse un numero de casillas aleatorias
       #indicadas al tirar el dado
       
    @@juego.siguiente_jugador
       
     puts "Jugador: #{@@juego.jugador_actual.nombre}"
     
     puts "Jugador: #{@@juego.jugador_actual.nombre} esta en la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}" 
     
     @@juego.mover(@@juego.tirar_dado)
      
     puts "\t Y se mueve a la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}"
     
       
     
       
    #Probamos el funcionamiento del metodo jugar
    
    @@juego.siguiente_jugador
       
     puts "Jugador: #{@@juego.jugador_actual.nombre}"
     
     puts "Jugador: #{@@juego.jugador_actual.nombre} esta en la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}" 
     
     @@juego.jugar
      
     puts "\t Y se mueve a la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}"   
     
       
       
       
       
       
      @@juego.siguiente_jugador
      
     puts "Jugador: #{@@juego.jugador_actual.nombre}"
     
     puts "Jugador: #{@@juego.jugador_actual.nombre} esta en la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}" 
     
      @@juego.mover(2)
      
     puts "\t Y se mueve a la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}"
     
     puts "Jugador: #{@@juego.jugador_actual.nombre} tiene un saldo de #{@@juego.obtener_saldo_jugador_actual} euros "  

     puts "Jugador: #{@@juego.jugador_actual.nombre} esta en la calle #{@@juego.obtener_casilla_jugador_actual.titulo.nombre}"
     
     puts "El precio de la calle es de #{@@juego.obtener_casilla_jugador_actual.titulo.precio_compra}" 
     
     if @@juego.comprar_titulo_propiedad
      puts "El jugador ha comprado la propiedad"
     else
      puts "No se ha podido comprar la propiedad"
     end
    
     puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros " 
     
     puts "Se va a hipotecar la propiedad"
       
     @@juego.hipotecar_propiedad(4)
       
     puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros "     
       
     puts "El jugador se lo ha pensado mejor y va a cancelar su hipoteca"
     
     @@juego.cancelar_hipoteca(4)
       
     puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros "  
    
     puts "Edificar una casa cuesta: " 
     puts @@juego.obtener_casilla_jugador_actual.titulo.precio_edificar
     
        
     if @@juego.edificar_casa(4)
       puts "El jugador ha edificado una casa"
     else
       puts "No se ha podido edificar"
     end
       
     puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros " 
       
       
     
       
      
       
     #Comprobación del funcionamiento del tablero circular
     
     @@juego.siguiente_jugador
     
     puts "Jugador: #{@@juego.jugador_actual.nombre}"
     
     puts "Jugador: #{@@juego.jugador_actual.nombre} tiene un saldo de #{@@juego.obtener_saldo_jugador_actual} euros "
     
     puts "Jugador: #{@@juego.jugador_actual.nombre} esta en la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}" 
     
     @@juego.mover(9)
     @@juego.mover(3)
      
     puts "\t Y se mueve a la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}"
     
     puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros "   
     
      
     #Funcionamiento de cartas sorpresas
     
      puts "Sorpresas PAGARCOBRAR"
      
      @@juego.siguiente_jugador
     
      puts "Jugador: #{@@juego.jugador_actual.nombre}"
     
      puts "Jugador: #{@@juego.jugador_actual.nombre} tiene un saldo de #{@@juego.obtener_saldo_jugador_actual} euros "
     
      puts "Gana 275 euros gracias a una carta sorpresa"
      
    @@juego.carta_actual = Sorpresa.new("Te has encontrado una cartera en la calle.Ganas 275 euros", 275, TipoSorpresa::PAGARCOBRAR)
      
     @@juego.aplicar_sorpresa 
      
     puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros "
      
       
     
      puts "Jugador: #{@@juego.jugador_actual.nombre} tiene un saldo de #{@@juego.obtener_saldo_jugador_actual} euros "
     
      puts "Pierde 100 euros debido a una carta sorpresa"
      
    @@juego.carta_actual = Sorpresa.new("Invitas a tu novia a una cita romantica y quieres estar a la altura. Te gastas en ella 100 euros",-100, TipoSorpresa::PAGARCOBRAR)
    
     @@juego.aplicar_sorpresa 
      
      puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros "
      
       
       
     puts "Sorpresas PORCASAHOTEL"
     
     
      puts "Jugador: #{@@juego.jugador_actual.nombre} tiene un saldo de #{@@juego.obtener_saldo_jugador_actual} euros "
     
      puts "Gana 60 euros por cada casa/hotel gracias a una carta sorpresa"
      
    @@juego.carta_actual = Sorpresa.new("Tu amigo de la infancia es arquitecto, y te ha hecho unas construcciones de lujo. Cobras 60 euros por casa/hotel",60,TipoSorpresa::PORCASAHOTEL)
      
     @@juego.aplicar_sorpresa 
      
      puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros "
      
      
     
      puts "Jugador: #{@@juego.jugador_actual.nombre} tiene un saldo de #{@@juego.obtener_saldo_jugador_actual} euros "
     
      puts "Pierde 95 euros por cada casa/hotel debido a una carta sorpresa"
      
    @@juego.carta_actual = Sorpresa.new("Han descubierto el escondite de unos narcotraficanes en una de tus construcciones. Ahora debes pagar 95 euros por cada casa/hotel", -95, TipoSorpresa::PORCASAHOTEL)
     
     @@juego.aplicar_sorpresa 
      
      puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros "
      
       
  
       
    puts "Sorpresas PORJUGADOR"
     
     
    puts "Jugador: #{@@juego.jugador_actual.nombre} tiene un saldo de #{@@juego.obtener_saldo_jugador_actual} euros "
     
    puts "Gana 20 euros de cada jugador gracias a una carta sorpresa"
      
    @@juego.carta_actual = Sorpresa.new("Es tu cumpleaños. Tus amigos te dan 20 euros cada uno", 20, TipoSorpresa::PORJUGADOR)
          
     @@juego.aplicar_sorpresa 
      
     puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros "
      
       
     
      puts "Jugador: #{@@juego.jugador_actual.nombre} tiene un saldo de #{@@juego.obtener_saldo_jugador_actual} euros "
     
      puts "Das 15 euros a cada jugador debido a una carta sorpresa"
      
    @@juego.carta_actual = Sorpresa.new("Sales de la discoteca e invitas a tus amigos a ir de after. Pagas 15 euros a cada uno", -15, TipoSorpresa::PORJUGADOR)
    
     @@juego.aplicar_sorpresa 
      
      puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros "
      
      
    
     puts "Sorpresas IRACASILLA"
     
     
     @@juego.carta_actual = Sorpresa.new("Quieres ir a la discoteca Copera, obviamente en la calle Copera. Avanzas a la casilla 14.", 14, TipoSorpresa::IRACASILLA)
     
     puts "Jugador: #{@@juego.jugador_actual.nombre} esta en la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}"  
     
     @@juego.aplicar_sorpresa 
     
     puts "\t Y se mueve a la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}"   
     
      
     
    @@juego.carta_actual = Sorpresa.new("Tu novia vive en la calle Salsipuedes y vas a su casa para darle una sorpresa. Avanzas a la casilla 18",18,TipoSorpresa::IRACASILLA)
     
     puts "Jugador: #{@@juego.jugador_actual.nombre} esta en la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}"  
     
     @@juego.aplicar_sorpresa 
     
     puts "\t Y se mueve a la casilla #{@@juego.obtener_casilla_jugador_actual.num_casilla}"   
     
     #PROBAR ESPECULADOR
     
     puts "Sorpresa ESPECULADOR"
     
     @@juego.carta_actual = Sorpresa.new("Como eres el más chulo del barrio, te vuelves un Especulador", 3000, TipoSorpresa::CONVERTIRME)
     
     @@juego.aplicar_sorpresa
     
    for jug in @@juego.jugadores do
      puts "#{jug.to_s}"
    end  
    
   puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros "
      
   puts "Jugador: #{@@juego.jugador_actual.nombre} esta en la calle #{@@juego.obtener_casilla_jugador_actual.titulo.nombre}"
     
   puts "El precio de la calle es de #{@@juego.obtener_casilla_jugador_actual.titulo.precio_compra}" 
   
   puts "El jugador va a pagar el impuesto"
   
   @@juego.jugador_actual.pagar_impuesto
   
   puts "Su saldo actual es de: #{@@juego.obtener_saldo_jugador_actual} euros "
       
    
       
       
    puts "Propiedades de los jugadores"
    
       
       for i in @@juego.jugadores
         puts "Las propiedades del jugador: #{@@juego.jugador_actual.nombre} son: "
         indice_propiedades = @@juego.obtener_propiedades_jugador
        
         for j in indice_propiedades
           puts " "
           puts "#{j}" #`porqe j ya coge los objetos
          
         end
       
         
         @@juego.siguiente_jugador
       end   
       
       puts "Propiedades de los jugadores segun el estado de la hipoteca(hipotecadas)"
    
       for i in @@juego.jugadores
         puts "Las propiedades del jugador: #{@@juego.jugador_actual.nombre} son: "
         indice_propiedades = @@juego.obtener_propiedades_jugador_segun_estado_hipoteca(true)
         
         for j in indice_propiedades
           puts " "
           puts "#{j}"
         end
         
         
         @@juego.siguiente_jugador
       end
       
       
       
       
       
       
       puts "Ranking de los jugadores: "
       
       @@juego.obtener_ranking
       
       for a in @@juego.jugadores
         puts "#{a.nombre} con capital: #{a.obtener_capital}"
       end  

       
     
     end
    
  end
  
   #PruebaQytetet.main
    
end
