var express = require("express");
var router = express.Router();

var avistamentoController = require("../controllers/avistamentoController");

router.post("/cadastrar/:idUsuario", function (req, res) {
    avistamentoController.cadastrar(req, res);
});

router.get("/listar/:idUsuario", function (req, res) {
    avistamentoController.listarPorUsuario(req, res);
});

module.exports = router;
