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

    client.on("emitir-mensaje", (payload) => {
        //console.log(payload);
        //io.emit("nuevo-mensaje", payload); emite a todos incluyendo a quien lo emitio
        client.broadcast.emit("nuevo-mensaje", payload);
    });
});