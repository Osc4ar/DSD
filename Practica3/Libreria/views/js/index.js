const host = location.host
const socket = io.connect(host)
socket.on('time', (data) => {
  clock = document.getElementById('clock')
  clock.innerHTML = data['time']
});

function sendRequest(server) {
  const host = location.host;
  const xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      const response = this.responseText;
      if (!isNaN(response)) {
        window.alert('Sesión '+ response + ' iniciada');
      } else {
        const book = JSON.parse(this.responseText);
        if (book.ended === true) {
          sessionEnded();
        } else {
          parseBook(book);
        }
      }
    }
  };
  xhttp.open('POST', 'http://' + host + '/' + server);
  xhttp.send();
}

function parseBook(book) {
  document.getElementById('ISBN').innerHTML = book.ISBN;
  document.getElementById('Nombre').innerHTML = book.Nombre;
  document.getElementById('Autor').innerHTML = book.Autor;
  document.getElementById('Editorial').innerHTML = book.Editorial;
  document.getElementById('Precio').innerHTML = book.Precio;
}

function clearBook() {
  document.getElementById('ISBN').innerHTML = '';
  document.getElementById('Nombre').innerHTML = '';
  document.getElementById('Autor').innerHTML = '';
  document.getElementById('Editorial').innerHTML = '';
  document.getElementById('Precio').innerHTML = '';
}

function sessionEnded() {
  clearBook();
  if(window.confirm("Ya no hay más libros.\n¿Iniciar nueva sesión?")) {
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