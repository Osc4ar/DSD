const express = require('express')
const cors = require('cors')
const app = express()
const http = require('http').Server(app)
const io = require('socket.io')(http);

const port = 3000

app.use(cors())

app.get('/', (req, res) => {
  res.sendFile(__dirname + '/html/index.html')
})

app.post('/bookManager', (req, res) => {
  res.send('Un librote')
})

app.post('/sessionManager', (req, res) => {
  res.send('Una sesion')
})

io.on('connection', (socket) => {
  setInterval(() => sendTime(socket), 1000)
})

function sendTime(socket) {
  currentDate = new Date()
  currentTime = formatTime(currentDate)
  socket.emit('time', { time: currentTime })
}

function formatTime(currentDate) {
  const hours = currentDate.getHours()
  const minutes = currentDate.getMinutes().toString().length == 1 ? '0' + currentDate.getMinutes() : currentDate.getMinutes()
  const seconds = currentDate.getSeconds().toString().length == 1 ? '0' + currentDate.getSeconds() : currentDate.getSeconds()
  return hours + ':' + minutes + ':' + seconds
}

http.listen(port, () => console.log('Libreria iniciada'))