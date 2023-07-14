const { response } = require("express");
const Usuario = require("../models/usuario");

const crearUsuario = async (req, resp = response) => {

    const { email } = req.body;

    try {
        const existEmail = await Usuario.findOne({ email });
        if (existEmail) {
            return resp.status(400).json({
                ok: false,
                msg: "Mail already exists",
            });
        }

        const usuario = new Usuario(req.body);
        await usuario.save();

        resp.json({
            ok: true,
            body: usuario,
        });
    } catch (error) {
        console.log(error);
        resp.status(500).json({
            ok: false,
            msg: "hable con el admin",
        });
    }
}

module.exports = {
    crearUsuario
}