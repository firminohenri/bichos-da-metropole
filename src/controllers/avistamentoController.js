var avistamentoModel = require("../models/avistamentoModel");

function converterDataParaSql(dataBr) {
    if (dataBr == undefined) {
        return null;
    }

    if (dataBr.indexOf("-") > -1) {
        return dataBr;
    }

    var partes = dataBr.split("/");

    if (partes.length != 3) {
        return null;
    }

    var ano = partes[2].length === 2 ? '20' + partes[2] : partes[2];
    var mes = partes[1].padStart(2, '0');
    var dia = partes[0].padStart(2, '0');

    return `${ano}-${mes}-${dia}`;
}

function cadastrar(req, res) {
    var dataAvistamentoServer = req.body.dataAvistamentoServer;
    var localAvistamentoServer = req.body.localAvistamentoServer;
    var fkEspecieServer = req.body.fkEspecieServer;
    var idUsuario = req.params.idUsuario;

    var dataSql = converterDataParaSql(dataAvistamentoServer);
    var localSql = localAvistamentoServer == undefined ? null : localAvistamentoServer.replace(/'/g, "''");

    if (dataAvistamentoServer == undefined) {
        res.status(400).send("A data do avistamento está indefinida!");
    } else if (localAvistamentoServer == undefined) {
        res.status(400).send("O local do avistamento está indefinido!");
    } else if (fkEspecieServer == undefined) {
        res.status(400).send("A espécie do avistamento está indefinida!");
    } else if (idUsuario == undefined) {
        res.status(400).send("O id do usuário está indefinido!");
    } else if (dataSql == null) {
        res.status(400).send("A data do avistamento está em formato inválido!");
    } else {
        avistamentoModel.cadastrar(dataSql, localSql, idUsuario, fkEspecieServer).then(function (resultado) {
            res.status(201).json(resultado);
        }).catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao cadastrar o avistamento: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
    }
}

function listarPorUsuario(req, res) {
    var idUsuario = req.params.idUsuario;

    if (idUsuario == undefined) {
        res.status(400).send("O id do usuário está indefinido!");
    } else {
        avistamentoModel.listarPorUsuario(idUsuario).then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado!");
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar os avistamentos: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
    }
}

module.exports = {
    cadastrar,
    listarPorUsuario
};
