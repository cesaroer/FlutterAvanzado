// path: api/login/new

const { Router } = require("express");
const { check } = require("express-validator");
const { crearUsuario, login, renewToken } = require("../controllers/auth");
const { validarCampos } = require("../middlewares/validate-fields");
const { validarJWT } = require("../middlewares/validate-jwt");
const router = Router();

router.post("/new", [
    check("nombre", "El nombre es obligatorio").not().isEmpty(),
    check("email", "El email no es valido").isEmail(),
    check("password", "El password no es valido").not().isEmpty(),

    validarCampos
], crearUsuario);



router.post("/", [
    check("email", "El email no es valido").isEmail(),
    check("password", "El password no es valido").not().isEmpty(),

    validarCampos
], login);

router.get("/renew", validarJWT, renewToken);

module.exports = router;

