var actualizarHora = function(){

    var fecha = new Date(),
        horas = fecha.getHours(),
        minutos = fecha.getMinutes(),
        amPm,
        segundos = fecha.getSeconds(),
        diaDeSemana = fecha.getDay(),
        dia = fecha.getDate(),
        mes = fecha.getMonth(),
        anio = fecha.getFullYear();

        var NombreDeSemana = ['Domingo','Lunes','Martes','Miercoles','Jueves','Viernes','Sabado'];
        var NombreDeMes = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Setiembre','Octubre','Noviembre','Diciembre'];

            var pHoras = document.getElementById("hora"),
            pMinutos = document.getElementById("minutos"),
            pAmPm = document.getElementById("ampm"),
            pSegundos = document.getElementById("segundos"),
            pDiaDeSemana = document.getElementById("diaSemana"),
            pDia = document.getElementById("dia"),
            pMes = document.getElementById("mes"),
            pAnio = document.getElementById("year");

  //  if(horas > 12){
  //      amPm = "PM";
  //  }else{
  //      amPm = "AM";
  //  }

    if(minutos < 10){
        minutos = "0" + minutos;
    }
    if(segundos < 10){
            segundos = "0" + segundos;
    }


        pHoras.textContent = horas,
        pMinutos.textContent = minutos,
        pSegundos.textContent = segundos,
        pAmPm.textContent = amPm,
        pDiaDeSemana.textContent = NombreDeSemana[diaDeSemana],
        pDia.textContent = dia,
        pMes.textContent = NombreDeMes[mes],
        pAnio.textContent = anio;


}

actualizarHora();
setInterval(actualizarHora,1000);