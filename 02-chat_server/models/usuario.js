const { Schema, model } = require("mongose");

const UsuarioScquema = Schema({
    nombre: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
    online: {
        type: Boolean,
        default: false,
    },
})

module.exports = model("Usuario", UsuarioScquema);