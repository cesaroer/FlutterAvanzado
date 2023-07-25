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

const login = async (req, resp = response) => {

    const { email, password } = req.body;


    try {
        const usuarioDB = await Usuario.findOne({ email });
        if (!usuarioDB) {
            return resp.status(404).json({
                ok: false,
                msg: "Email not found"
            });
        }

        // Validar pass
        const validPassword = bcrypt.compareSync(password, usuarioDB.password);
        if (!validPassword) {
            return resp.status(400).json({
                ok: false,
                msg: "Pass is not valid"
            });
        }

        // generat jwt
        const token = await generarJWT(usuarioDB.id);
        resp.json({
            ok: true,
            msg: "Login succeded",
            body: {
                usuarioDB,
                token
            }
        });

    } catch (error) {
        console.log(error)
        return resp.status(500).json({
            ok: true,
            msg: "Login"
        });
    }

}

const renewToken = async (req, res = response) => {
    res.json({
        ok: true,
        body: {
            msg: "Renewed",
            uid: req.uid
        }
    });
}



module.exports = {
    crearUsuario,
    login,
    renewToken
}