//importa el .env
require('dotenv').config();

//const { errorMonitor } = require("events");
//Se instancia el express
const express = require('express');
const app = express();

//se importa la lib del path
const path = require('path');

//se crea el servidor node
const httpServer = require("http").createServer(app);


//se importa el socket.io
const io = require("socket.io")(httpServer);


//mensajes io de socket.io
io.on("connection", client => {
    console.log('Cliente conectado :D');
    client.on('disconnect', () => {
        console.log('Cliente desconectado :(');
    });

    client.on("mensage", (payload) => {
        console.log("mensaje ", payload);

        io.emit("mensage", { admin: 'nuevo mensaje' });
    });
});

//path publico
const publicPath = path.resolve(__dirname, 'public');
app.use(express.static(publicPath));


//listen server in port
httpServer.listen(process.env.PORT, (err) => {
    if (err) throw new Error(err);
    console.log('Servidor corriendo en puerto!!', process.env.PORT);
});
