const { Schema, model } = require("mongoose");

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
});

UsuarioScquema.method("toJSON", function () {
    const { __v, _id, password, ...object } = this.toObject();
    object.UUID = _id;
    return object;
});

module.exports = model("Usuario", UsuarioScquema);