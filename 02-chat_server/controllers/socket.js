const Usuario = require("../models/usuario");

const usrConnected = async (uid = "") => {
    const update = { online: true };
    await Usuario.findByIdAndUpdate(uid, update);

    const usuario = await Usuario.findById(uid); // Para ver los cambios realizados
    //console.log("Autenticado:", usuario);
    return usuario;
}

const usrDissconnected = async (uid = "") => {
    const update = { online: false };
    await Usuario.findByIdAndUpdate(uid, update);

    const usuario = await Usuario.findById(uid); // Para ver los cambios realizados
    //console.log("Autenticado:", usuario);
    return usuario;
}

module.exports = {
    usrConnected,
    usrDissconnected
}