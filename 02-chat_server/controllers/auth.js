const { response } = require("express");
const { validationResult } = require("express-validator");

const crearUsuario = (req, resp = response) => {

    const errors = validationResult(req);

    if (!errors.isEmpty()) {
        return resp.status(400).json({
            ok: false,
            errors: errors.mapped()
        });
    }

    resp.json({
        ok: true,
        msg: "Crear usuario!!!"
    });
}

module.exports = {
    crearUsuario
}