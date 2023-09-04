const { io } = require("../index");
const Bands = require('../models/bands');
const Band = require('../models/band');
const { comprobateJWT } = require("../helpers/jwt");
const { usrConnected, usrDissconnected } = require("../controllers/socket");

const bands = new Bands();

bands.addBand(new Band("Queen"));
bands.addBand(new Band("Bon Jovi"));
bands.addBand(new Band("Enanitos Verdes"));
bands.addBand(new Band("Metallika"));


//mensajes io de socket.io
io.on("connection", client => {
    console.log('Cliente conectado :D');

    const [valid, uid] = comprobateJWT(client.handshake.headers["x-token"])

    if (!valid) {
        return client.disconnect();
    }

    usrConnected(uid);
    //ingresar al user a una sala especifica

    //Sala Global
    client.join(uid);

    console.log("Cliente Valido : ", valid, " Con uid ", uid);

    client.on("mensaje-personal", (payload) => {
        console.log("mensaje ", payload);
        io.to(payload.para).emit("mensaje-personal", payload);
    });

    client.on('disconnect', () => {
        console.log('Cliente desconectado :(');
        usrDissconnected(uid);
    });
});