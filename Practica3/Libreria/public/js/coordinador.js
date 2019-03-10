function newSession() {
    const host = location.host;
    const xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        const response = this.responseText;
        if (!isNaN(response)) {
            window.alert('Sesión '+ response + ' iniciada');
        } else {
            window.alert('Error en creación de sesión');
        }
      }
    };
    xhttp.open('GET', 'http://' + host + '/sessionManager?username=Coordinador');
    xhttp.send();
}