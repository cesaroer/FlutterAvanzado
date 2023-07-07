// path: api/login/new

const { Router } = require("express");
const { check } = require("express-validator");
const { crearUsuario } = require("../controllers/auth");
const { validarCampos } = require("../middlewares/validate-fields");
const router = Router();

router.post("/new", [
    check("nombre", "El nombre es obligatorio").not().isEmpty(),
    check("email", "El email no es valido").isEmail(),
    check("password", "El password no es valido").not().isEmpty(),

    validarCampos
], crearUsuario);

module.exports = router;

