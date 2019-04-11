$(function(){
    var global_date;//para poder modificar la fecha aleatoria
    var random_int = function(max)//Solo retorna los valores aleatorios enteros y valor maximo a retornar
    {
        return Math.floor(Math.random() * max);
    }
    var crearHora = function(hora,minutos,segundos)//Crea la fecha aleatoria
    {
        var fecha = new Date(),
            dia = fecha.getDate(),
            mes = fecha.getMonth(),
            anio = fecha.getFullYear(),
            new_fecha = new Date(anio,mes,dia,hora,minutos,segundos);
            return new_fecha;
    };
    var ajustar = function()//realiza los aumentos y crea fechas para que se muestren en el reloj
    {
        var hora = global_date.getHours(),
            minutos = global_date.getMinutes(),
            segundos = global_date.getSeconds() + 1,
            dia = global_date.getDate(),
            mes = global_date.getMonth(),
            anio = global_date.getFullYear();
        if(segundos > 59){
            minutos = minutos + 1;
        }
        if(minutos > 59){
            hora = hora + 1;
        }
        if(hora > 23){
            segundos = 0;
            minutos = 0;
            hora = 0;
        }
        return global_date = new Date(anio,mes,dia,hora,minutos,segundos);//actualizamos la fecha
    };
    var actualizarHora = function(){
        var fecha = ajustar(),//manda a ajustar esta, aumentando el segundo transcurrido por llamada
            hora = fecha.getHours(),
            minutos = fecha.getMinutes(),
            segundos = fecha.getSeconds(),
            diaSemana = fecha.getDay(),
            dia = fecha.getDate(),
            mes = fecha.getMonth(),
            anio = fecha.getFullYear(),
            ampm;
        console.log(fecha);
        var $pHoras = $("#horas"),
            $pSegundos = $("#segundos"),
            $pMinutos = $("#minutos"),
            $pAMPM = $("#ampm"),
            $pDiaSemana = $("#diaSemana"),
            $pDia = $("#dia"),
            $pMes = $("#mes"),
            $pAnio = $("#anio");
        var semana = ['Domingo','Lunes','Martes','Miercoles','Jueves','Viernes','Sabado'];
        var meses = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];

        $pDiaSemana.text(semana[diaSemana]);
        $pDia.text(dia);
        $pMes.text(meses[mes]);
        $pAnio.text(anio);
        if(hora<10){$pHoras.text("0"+hora)}else{$pHoras.text(hora)};
        if(minutos<10){$pMinutos.text("0"+minutos)}else{$pMinutos.text(minutos)};
        if(segundos<10){$pSegundos.text("0"+segundos)}else{$pSegundos.text(segundos)};
        $pAMPM.text(ampm);
    };
    global_date = crearHora(random_int(23), random_int(59), random_int(59));
    actualizarHora();
    setInterval(actualizarHora,1000);
});