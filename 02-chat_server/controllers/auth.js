const { response } = require("express");
const Usuario = require("../models/usuario");

const crearUsuario = async (req, resp = response) => {

    const usuario = new Usuario(req.body);
    await usuario.save();

    resp.json({
        ok: true,
        body: req.body,
    });
}

module.exports = {
    crearUsuario
}