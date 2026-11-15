var dashboardModel = require("../models/dashboardModel");

function buscarResumo(req, res) {
    var idUsuario = req.params.idUsuario;

    if (idUsuario == undefined) {
        res.status(400).send("O id do usuário está indefinido!");
    } else {
        dashboardModel.buscarResumo(idUsuario).then(function (resultado) {
            res.status(200).json(resultado);
        }).catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar o resumo da dashboard: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
    }
}

module.exports = {
    buscarResumo
};
