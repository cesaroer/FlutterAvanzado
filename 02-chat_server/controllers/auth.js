const { response } = require("express");
const { validationResult } = require("express-validator");

const crearUsuario = (req, resp = response) => {



    resp.json({
        ok: true,
        msg: "Crear usuario!!!"
    });
}

module.exports = {
    crearUsuario
}