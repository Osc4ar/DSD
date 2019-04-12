const hosts = ["127.0.0.1:3000", "127.0.0.1:7777", "127.0.0.1:7776"];
let hostsDistance = [Number.POSITIVE_INFINITY, Number.POSITIVE_INFINITY, Number.POSITIVE_INFINITY];

window.onload = () => {
  checkHostsDistance();
};

window.setInterval(() => checkHostsDistance(), 300000);

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

function makeURL(service) {
  const host = getHost();
  console.log('Host: ' + host);
  const url = 'http://' + host + '/' + service;
  return url;
}