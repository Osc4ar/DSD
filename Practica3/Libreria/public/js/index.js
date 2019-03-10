const host = location.host
const socket = io.connect(host)
socket.on('time', (data) => {
  clock = document.getElementById('clock')
  clock.innerHTML = data['time']
});

function sendRequest(server) {
  const username = 'username=' + document.getElementById('username').value;
  const host = location.host;
  const xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      const response = this.responseText;
      if (!isNaN(response)) {
        window.alert('Sesión '+ response + ' iniciada');
      } else {
        const book = JSON.parse(response);
        parseBook(book);
        if (book.ended === true) {
          sessionEnded();
        }
      }
    }
  };
  xhttp.open('GET', 'http://' + host + '/' + server + '?' + username, true);
  xhttp.send();
}

function parseBook(book) {
  document.getElementById('ISBN').innerHTML = book.ISBN;
  document.getElementById('Nombre').innerHTML = book.Nombre;
  document.getElementById('Autor').innerHTML = book.Autor;
  document.getElementById('Editorial').innerHTML = book.Editorial;
  document.getElementById('Precio').innerHTML = book.Precio;
}

function sessionEnded() {
  if(window.confirm("Este es el último libro.\n¿Iniciar nueva sesión?")) {
    requestNewSession();
  } else {
    document.getElementById('requestNewBook').disabled = true;
  }
}

function requestNewBook() {
  sendRequest('bookManager');
}

function requestNewSession() {
  sendRequest('sessionManager');
}