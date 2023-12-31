const { io } = require("../index");
const Bands = require('../models/bands');
const Band = require('../models/band');

const bands = new Bands();

bands.addBand(new Band("Queen"));
bands.addBand(new Band("Bon Jovi"));
bands.addBand(new Band("Enanitos Verdes"));
bands.addBand(new Band("Metallika"));


//mensajes io de socket.io
io.on("connection", client => {
    console.log('Cliente conectado :D');

    client.emit("active-bands", bands.getBands());


    client.on('disconnect', () => {
        console.log('Cliente desconectado :(');
    });

    client.on("mensage", (payload) => {
        console.log("mensaje ", payload);

        io.emit("mensage", { admin: 'nuevo mensaje' });
    });

    // client.on("emitir-mensaje", (payload) => {
    //     //console.log(payload);
    //     //io.emit("nuevo-mensaje", payload); emite a todos incluyendo a quien lo emitio
    //     client.broadcast.emit("nuevo-mensaje", payload);
    // });

    client.on("vote-band", (payload => {
        bands.voteBand(payload.id);
        io.emit("active-bands", bands.getBands());
    }));

    client.on("add-band", (payload => {

        const newBand = new Band(payload.name);
        bands.addBand(newBand);
        io.emit("active-bands", bands.getBands());
    }));

    client.on("delete-band", (payload => {

        bands.deleteBand(payload.id);
        io.emit("active-bands", bands.getBands());
    }));
});