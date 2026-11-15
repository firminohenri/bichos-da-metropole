var express = require("express");
var router = express.Router();

var especieController = require("../controllers/especieController");

router.get("/listar", function (req, res) {
    especieController.listarCatalogo(req, res);
});

router.get("/bestiario/:idUsuario", function (req, res) {
    especieController.listarBestiarioPorUsuario(req, res);
});

module.exports = router;
