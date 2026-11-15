var database = require("../database/config");

function listarCatalogo() {
    var instrucaoSql = `SELECT 
                        e.id,
                        e.nome_popular AS nomePopular,
                        e.nome_cientifico AS nomeCientifico,
                        e.descricao,
                        e.imagem_path AS imagemPath,
                        g.nome AS grupo
                    FROM especie e
                    INNER JOIN grupo g ON g.id = e.fk_grupo
                    ORDER BY e.nome_popular`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarBestiarioPorUsuario(idUsuario) {
    var instrucaoSql = `SELECT 
                        e.id,
                        e.nome_popular AS nomePopular,
                        e.nome_cientifico AS nomeCientifico,
                        e.descricao,
                        e.imagem_path AS imagemPath,
                        g.nome AS grupo,
                        CASE
                            WHEN EXISTS (
                                SELECT 1
                                FROM avistamento a
                                WHERE a.fk_usuario = ${idUsuario}
                                    AND a.fk_especie = e.id
                            ) THEN 'descoberto'
                            ELSE 'pendente'
                        END AS status
                    FROM especie e
                    INNER JOIN grupo g ON g.id = e.fk_grupo
                    ORDER BY e.nome_popular`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    listarCatalogo,
    listarBestiarioPorUsuario
};
