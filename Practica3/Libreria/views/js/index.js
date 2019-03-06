const host = location.host
const socket = io.connect(host)
socket.on('time', (data) => {
  clock = document.getElementById('clock')
  clock.innerHTML = data['time']
});

function sendRequest(server) {
  const host = location.host;
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      document.getElementById('cover').innerHTML = this.responseText;
    }
  };
  xhttp.open('POST', 'http://' + host + '/' + server);
  xhttp.send();
}

function requestNewBook() {
  sendRequest('bookManager')
}

function requestNewSession() {
  sendRequest('sessionManager')
}