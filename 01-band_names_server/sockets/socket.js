const { io } = require("../index");

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