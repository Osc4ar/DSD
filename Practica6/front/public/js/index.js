const DEFAULT = "10.0.0.19:3000";
let mainServer = DEFAULT;
let hostsDistance = [Number.POSITIVE_INFINITY, Number.POSITIVE_INFINITY, Number.POSITIVE_INFINITY];

window.onload = () => {
  requestNewServer();
  actualizarHora();
};

window.setInterval(() => actualizarHora(), 1000);

function requestNewServer() {
  sendRequest('newServer', handlerNewServer);
}

function handlerNewServer(response) {
  const receivedHost = JSON.parse(response);
  mainServer = receivedHost.server;
}

function requestNewBook() {
  sendRequest('newBook', handlerNewBook);
}

function handlerNewBook(response) {
  const book = JSON.parse(response);
  parseBook(book);
  if (book.ended === true) {
    sessionEnded();
  }
}

function parseBook(book) {
  document.getElementById('ISBN').innerHTML = book.ISBN;
  document.getElementById('Nombre').innerHTML = book.Nombre;
  document.getElementById('Autor').innerHTML = book.Autor;
  document.getElementById('Editorial').innerHTML = book.Editorial;
  document.getElementById('Precio').innerHTML = book.Precio;
}

function getIntValueById(id) {
  const value = document.getElementById(id).textContent;
  return parseInt(value);
}

function sessionEnded() {
  if(window.confirm("Este es el último libro.\n¿Iniciar nueva sesión?")) {
    requestNewSession();
  } else {
    document.getElementById('requestNewBook').disabled = true;
  }
}

function requestNewSession() {
  sendRequest('newSession', handlerNewSession);
}

function handlerNewSession(response) {
  const sesionInfo = JSON.parse(response);
  if (sesionInfo.idSesion != undefined) {
    window.alert('Sesión '+ sesionInfo.idSesion + ' iniciada');
  } else {
    window.alert('Error iniciando sesión');
  }
}

function checkHostsDistance() {
  for (let index = 0; index < hosts.length; index++) {
    hostsDistance[index] = Number.POSITIVE_INFINITY;
    ping(hosts[index], (delay) => {
      hostsDistance[index] = delay;
      console.log('Hosts encontrados:\n' + hosts[index] + ' = ' + hostsDistance[index]);
    });
  }
}

function ping(host, handler) {
  const started = new Date().getTime();
  const url = 'http://' + host;
  const xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      const ended = new Date().getTime();
      const delay = ended - started;
      handler(delay);
    }
  };
  xhttp.open('GET', url, true);
  xhttp.send();
}

function sendRequest(server, handler) {
  const url = makeURL(server);
  const xhttp = new XMLHttpRequest();
  xhttp.onerror = function(e) {
    console.log('Error en envio de peticion: ' + server);
    mainServer = DEFAULT;
    setTimeout(() => requestNewServer(), 1000);
    setTimeout(() => sendRequest(server, handler), 2000);
  };
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      handler(this.responseText);
    }
  };
  xhttp.open('GET', url, true);
  xhttp.send();
}

function getHost() {
  let minValue = hostsDistance[0];
  for (let index = 1; index < hostsDistance.length; index++) {
    const distance = hostsDistance[index];
    if (distance < minValue)
      minValue = distance;
  }
  const index = hostsDistance.findIndex(distance => distance == minValue);
  return hosts[index];
}

function makeURL(service) {
  console.log('Enviando a host: ' + mainServer);
  let url = 'http://' + mainServer + '/' + service;
  if (service == 'newBook') {
    const username = 'username=' + document.getElementById('username').value;
    url = url + '?' + username;
    const time = '&time=' + getTime();
    url = url + time;
  }
  return url;
}

function getTime() {
  const hours = getIntValueById('horas');
  const minutes = getIntValueById('minutos');
  const seconds = getIntValueById('segundos');
  return hours + ':' + minutes + ':' + seconds;
}

let global_date = crearHora(random_int(23), random_int(59), random_int(59));
  function random_int(max)//Solo retorna los valores aleatorios enteros y valor maximo a retornar
  {
    return Math.floor(Math.random() * max);
  }
  function crearHora(hora,minutos,segundos)//Crea la fecha aleatoria
  {
    var fecha = new Date(),
        dia = fecha.getDate(),
        mes = fecha.getMonth(),
        anio = fecha.getFullYear(),
        new_fecha = new Date(anio,mes,dia,hora,minutos,segundos);
    return new_fecha;
  }
  function ajustar()//realiza los aumentos y crea fechas para que se muestren en el reloj
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
  }
  function modificar()//realiza los aumentos y crea fechas para que se muestren en el reloj
  {
    var hora = document.getElementById("inputHour").value,
        minutos = document.getElementById("inputMin").value,
        segundos = document.getElementById("inputSec").value,
        dia = global_date.getDate(),
        mes = global_date.getMonth(),
        anio = global_date.getFullYear();
    hora = parseInt(hora);
    minutos = parseInt(minutos);
    segundos = parseInt(segundos);
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
    global_date.setHours(hora, minutos, segundos);
  }
  function actualizarHora(){
    var fecha = ajustar(),//manda a ajustar esta, aumentando el segundo transcurrido por llamada
        hora = fecha.getHours(),
        minutos = fecha.getMinutes(),
        segundos = fecha.getSeconds(),
        diaSemana = fecha.getDay(),
        dia = fecha.getDate(),
        mes = fecha.getMonth(),
        anio = fecha.getFullYear(),
        ampm;
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
  }