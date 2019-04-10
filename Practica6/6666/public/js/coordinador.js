function newSession() {
  const host = location.host;
  const xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      const sesionInfo = JSON.parse(response);
      if (sesionInfo.idSesion != undefined) {
        window.alert('Sesión '+ sesionInfo.idSesion + ' iniciada');
      } else {
        window.alert('Error iniciando sesión');
      }
    }
  };
  xhttp.open('GET', 'http://' + host + '/newSession');
  xhttp.send();
}