var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/resumo/:idUsuario", function (req, res) {
    dashboardController.buscarResumo(req, res);
});

module.exports = router;
