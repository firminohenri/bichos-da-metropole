var database = require("../database/config");

function buscarResumo(idUsuario) {
    var sqlResumo = `SELECT
                        (SELECT COUNT(*) FROM especie) AS totalCatalogo,
                        (SELECT COUNT(DISTINCT fk_especie) FROM avistamento WHERE fk_usuario = ${idUsuario}) AS especiesDescobertas,
                        (SELECT COUNT(*) FROM avistamento WHERE fk_usuario = ${idUsuario}) AS totalAvistamentos`;

    var sqlRecentes = `SELECT 
                        a.id,
                        e.nome_popular AS nomePopular,
                        e.nome_cientifico AS nomeCientifico,
                        e.imagem_path AS imagemPath,
                        g.nome AS grupo,
                        DATE_FORMAT(a.data_avistamento, '%d/%m/%Y') AS dataAvistamento,
                        a.local_avistamento AS localAvistamento
                    FROM avistamento a
                    INNER JOIN especie e ON e.id = a.fk_especie
                    INNER JOIN grupo g ON g.id = e.fk_grupo
                    WHERE a.fk_usuario = ${idUsuario}
                    ORDER BY a.data_avistamento DESC, a.id DESC
                    LIMIT 4`;

    var sqlMeses = `SELECT 
                        MONTH(a.data_avistamento) AS numeroMes,
                        COUNT(*) AS total
                    FROM avistamento a
                    WHERE a.fk_usuario = ${idUsuario}
                    GROUP BY MONTH(a.data_avistamento)
                    ORDER BY numeroMes`;

    var sqlGrupos = `SELECT 
                        g.nome AS grupo,
                        COUNT(*) AS total
                    FROM avistamento a
                    INNER JOIN especie e ON e.id = a.fk_especie
                    INNER JOIN grupo g ON g.id = e.fk_grupo
                    WHERE a.fk_usuario = ${idUsuario}
                    GROUP BY g.nome
                    ORDER BY total DESC`;

    console.log("Executando a instrução SQL: \n" + sqlResumo);
    console.log("Executando a instrução SQL: \n" + sqlRecentes);
    console.log("Executando a instrução SQL: \n" + sqlMeses);
    console.log("Executando a instrução SQL: \n" + sqlGrupos);

    return Promise.all([
        database.executar(sqlResumo),
        database.executar(sqlRecentes),
        database.executar(sqlMeses),
        database.executar(sqlGrupos)
    ]).then(function (resultados) {
        var resumo = resultados[0][0] || {
            totalCatalogo: 0,
            especiesDescobertas: 0,
            totalAvistamentos: 0
        };

        return {
            totalCatalogo: Number(resumo.totalCatalogo || 0),
            especiesDescobertas: Number(resumo.especiesDescobertas || 0),
            totalAvistamentos: Number(resumo.totalAvistamentos || 0),
            ultimosRegistros: resultados[1],
            avistamentosPorMes: resultados[2],
            especiesPorGrupo: resultados[3]
        };
    });
}

module.exports = {
    buscarResumo
};
