const host = location.host
const socket = io.connect(host)
socket.on('time', (data) => {
  clock = document.getElementById('clock')
  clock.innerHTML = data['time']
});

function requestNewBook() {
  sendRequest('newBook');
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
  if (!isNaN(response)) {
    window.alert('Sesión '+ response + ' iniciada');
  } else {
    window.alert('Erro iniciando nueva sesión');
  }
}

function sendRequest(server, handler) {
  const url = makeURL(server);
  const xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      handler(this.responseText);
    }
  };
  xhttp.open('GET', url, true);
  xhttp.send();
}

function makeURL(server) {
  let url = 'http://' + location.host + '/' + server;
  if (server == 'newBook') {
    const username = 'username=' + document.getElementById('username').value;
    url = url + '?' + username;
  }
  return url;
}