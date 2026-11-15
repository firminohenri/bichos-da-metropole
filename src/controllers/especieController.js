var especieModel = require("../models/especieModel");

function listarCatalogo(req, res) {
    especieModel.listarCatalogo().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar o catálogo de espécies: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function listarBestiarioPorUsuario(req, res) {
    var idUsuario = req.params.idUsuario;

    if (idUsuario == undefined) {
        res.status(400).send("O id do usuário está indefinido!");
    } else {
        especieModel.listarBestiarioPorUsuario(idUsuario).then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado!");
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar o bestiário: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
    }
}

module.exports = {
    listarCatalogo,
    listarBestiarioPorUsuario
};
