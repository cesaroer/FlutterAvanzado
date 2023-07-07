const { response } = require("express");

const crearUsuario = (req, resp = response) => {
    resp.json({
        ok: true,
        msg: "Crear usuario!!!"
    });
}

module.exports = {
    crearUsuario
}