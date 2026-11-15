var database = require("../database/config");

function cadastrar(dataAvistamento, localAvistamento, idUsuario, idEspecie) {
    var instrucaoSql = `INSERT INTO avistamento (data_avistamento, local_avistamento, fk_usuario, fk_especie)
                    VALUES ('${dataAvistamento}', '${localAvistamento}', ${idUsuario}, ${idEspecie})`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarPorUsuario(idUsuario) {
    var instrucaoSql = `SELECT 
                        a.id,
                        a.data_avistamento,
                        DATE_FORMAT(a.data_avistamento, '%d/%m/%Y') AS dataAvistamento,
                        a.local_avistamento AS localAvistamento,
                        e.nome_popular AS nomePopular,
                        e.nome_cientifico AS nomeCientifico,
                        e.imagem_path AS imagemPath,
                        g.nome AS grupo
                    FROM avistamento a
                    INNER JOIN especie e ON e.id = a.fk_especie
                    INNER JOIN grupo g ON g.id = e.fk_grupo
                    WHERE a.fk_usuario = ${idUsuario}
                    ORDER BY a.data_avistamento DESC, a.id DESC`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarUltimosPorUsuario(idUsuario, limite) {
    var instrucaoSql = `SELECT 
                        a.id,
                        DATE_FORMAT(a.data_avistamento, '%d/%m/%Y') AS dataAvistamento,
                        a.local_avistamento AS localAvistamento,
                        e.nome_popular AS nomePopular,
                        e.nome_cientifico AS nomeCientifico,
                        e.imagem_path AS imagemPath,
                        g.nome AS grupo
                    FROM avistamento a
                    INNER JOIN especie e ON e.id = a.fk_especie
                    INNER JOIN grupo g ON g.id = e.fk_grupo
                    WHERE a.fk_usuario = ${idUsuario}
                    ORDER BY a.data_avistamento DESC, a.id DESC
                    LIMIT ${limite}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function contarTotalPorUsuario(idUsuario) {
    var instrucaoSql = `SELECT COUNT(*) AS totalAvistamentos
                    FROM avistamento
                    WHERE fk_usuario = ${idUsuario}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    cadastrar,
    listarPorUsuario,
    listarUltimosPorUsuario,
    contarTotalPorUsuario
};
