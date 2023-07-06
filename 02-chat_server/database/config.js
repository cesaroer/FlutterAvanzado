const mongoose = require("mongoose");
const dbConnection = async () => {
    try {


        console.log('init db config');

    } catch (error) {
        console.log(error);

        throw new Error("Error en bd -  hable con el admin");
    }
}

module.exports = {
    dbConnection
}