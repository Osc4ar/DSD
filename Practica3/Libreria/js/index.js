window.onload = () => {
  const socket = io.connect('http://127.0.0.1:3000')
  socket.on('datetime', (data) => {
    clock = document.getElementById('clock')
    clock.text(new Date(data))
  })
}