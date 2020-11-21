#encoding :UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ControladorQytetet
   OpcionMenu = [:INICIARJUEGO, :JUGAR, :APLICARSORPRESA, :INTENTARSALIRCARCELPAGANDOLIBERTAD,
    :INTENTARSALIRCARCELTIRANDODADO, :COMPRARTITULOPROPIEDAD, :HIPOTECARPROPIEDAD, 
    :CANCELARHIPOTECA, :EDIFICARCASA, :EDIFICARHOTEL, :VENDERPROPIEDAD, :PASARTURNO, 
    :OBTENERRANKING, :TERMINARJUEGO, :MOSTRARJUGADORACTUAL, :MOSTRARJUGADORES, :MOSTRARTABLERO] 
end

=begin
Para extraer la posicion del elemento del Array: OpcionMenu.index(:JUGAR), devuelve
el numero de la posicion donde está eso.
Para convertir entero a string se hace to_s
Para devolver un valor se hace OpcionMenu.at(numero)
=end