const net = require('net');

const server = net.createServer((socket) => {
  console.log(`Conexão recebida de ${socket.remoteAddress}`);
  socket.destroy();
});

const PORT = 4444;
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Fallback TCP escutando na porta ${PORT}`);
});
