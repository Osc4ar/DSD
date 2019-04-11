const hosts = ["127.0.0.1:3000", "127.0.0.1:7777", "127.0.0.1:7776"];
let hostsDistance = [Number.POSITIVE_INFINITY, Number.POSITIVE_INFINITY, Number.POSITIVE_INFINITY];

window.onload = checkHostsDistance;

window.setInterval(() => checkHostsDistance(), 300000);

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
      console.log(hosts[index] + ' = ' + hostsDistance[index]);
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
    checkHostsDistance();
    alert('Servidor no disponible, cambiando a otro servidor.\nVuelva a intentarlo.');
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

function getTime() {
  const hours = getIntValueById('horas');
  const minutes = getIntValueById('minutos');
  const seconds = getIntValueById('segundos');
  return hours + ':' + minutes + ':' + seconds;
}

function makeURL(service) {
  const host = getHost();
  console.log('Host: ' + host);
  let url = 'http://' + host + '/' + service;
  if (service == 'newBook') {
    const username = 'username=' + document.getElementById('username').value;
    url = url + '?' + username;
    const time = '&time=' + getTime();
    url = url + time;
  }
  return url;
}
