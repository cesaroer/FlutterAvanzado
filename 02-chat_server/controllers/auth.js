const { response } = require("express");
const bcrypt = require('bcryptjs');
const Usuario = require("../models/usuario");
const { generarJWT } = require("../helpers/jwt");

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
        // Encriptar password
        const salt = await bcrypt.genSaltSync(10);
        const passw = await req.body.password;
        usuario.password = await bcrypt.hashSync(passw, salt);

        await usuario.save();


        //Generar JWT
        const token = await generarJWT(usuario.id);


        resp.json({
            ok: true,
            body: {
                usuario,
                token
            }
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