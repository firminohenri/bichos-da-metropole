-- Script somente do Bichos da Metrópole
-- Execute no MySQL Workbench para testar a nova dashboard

CREATE DATABASE IF NOT EXISTS aquatech;

USE aquatech;

CREATE TABLE IF NOT EXISTS usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS grupo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS especie (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_popular VARCHAR(100) NOT NULL UNIQUE,
    nome_cientifico VARCHAR(100) NOT NULL,
    descricao VARCHAR(150),
    imagem_path VARCHAR(255),
    fk_grupo INT NOT NULL,
    FOREIGN KEY (fk_grupo) REFERENCES grupo(id)
);

CREATE TABLE IF NOT EXISTS avistamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_avistamento DATE NOT NULL,
    local_avistamento VARCHAR(150) NOT NULL,
    fk_usuario INT NOT NULL,
    fk_especie INT NOT NULL,
    FOREIGN KEY (fk_usuario) REFERENCES usuario(id),
    FOREIGN KEY (fk_especie) REFERENCES especie(id)
);

INSERT IGNORE INTO usuario (nome, email, senha)
VALUES ('Usuario Teste', 'teste@bichos.com', '123456');

INSERT IGNORE INTO grupo (nome) VALUES
('Ave'),
('Mamífero'),
('Réptil'),
('Anfíbio'),
('Inseto');

INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Bem-te-vi', 'Pitangus sulphuratus', 'Ave urbana comum observada em praças e ruas arborizadas.', '/assets/assets-home/bentevi.png', 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Capivara', 'Hydrochoerus hydrochaeris', 'Mamífero frequente em parques e áreas alagadas.', '/assets/assets-bestiario/capybara_PNG8 1.png', 2);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Sabiá-laranjeira', 'Turdus rufiventris', 'Ave muito comum em áreas urbanas arborizadas.', '/assets/assets-bestiario/sabia-laranjeira.png', 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Tucano-bico-verde', 'Ramphastos dicolorus', 'Ave de porte médio associada a fragmentos de mata e parques.', '/assets/assets-bestiario/tucano.png', 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Pardal', 'Passer domesticus', 'Ave doméstica muito comum no centro urbano.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Pomba-doméstica', 'Columba livia', 'Ave urbana presente em praças, fachadas e calçadas.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Rolinha-roxa', 'Columbina talpacoti', 'Pequena ave comum em quintais e jardins.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Corruíra', 'Troglodytes musculus', 'Pequena ave muito adaptada ao ambiente urbano.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Quero-quero', 'Vanellus chilensis', 'Ave de campos abertos, parques e áreas gramadas.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Chupim', 'Molothrus bonariensis', 'Ave oportunista comum em áreas urbanas e periurbanas.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Tico-tico', 'Zonotrichia capensis', 'Ave frequente em jardins, praças e capinzais.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('João-de-barro', 'Furnarius rufus', 'Ave conhecida pelo ninho de barro em postes e árvores.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Sanhaço-cinzento', 'Thraupis sayaca', 'Ave que aparece em áreas verdes e arborizadas.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Bico-de-lacre', 'Estrilda astrild', 'Pequena ave exótica comum em espaços verdes urbanos.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Maritaca', 'Myiopsitta monachus', 'Psitacídeo frequente em parques e árvores urbanas.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Periquito-rico', 'Brotogeris tirica', 'Pequeno psitacídeo muito comum na capital paulista.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Gavião-carijó', 'Rupornis magnirostris', 'Ave de rapina comum em áreas urbanas e bordas de mata.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Urubu-de-cabeça-preta', 'Coragyps atratus', 'Ave necrófaga abundante em grandes cidades.', NULL, 1);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Gambá-de-orelha-branca', 'Didelphis albiventris', 'Mamífero noturno que pode surgir em áreas urbanas e parques.', '/assets/assets-bestiario/gamba.png', 2);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Sagui-de-tufo-preto', 'Callithrix penicillata', 'Pequeno primata frequente em áreas verdes e fragmentos de mata.', '/assets/assets-bestiario/sagui (1).png', 2);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Caxinguelê', 'Sciurus aestuans', 'Esquilo nativo associado a áreas arborizadas.', NULL, 2);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Ouriço-cacheiro', 'Coendou prehensilis', 'Mamífero arborícola noturno observado em parques.', NULL, 2);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Quati', 'Nasua nasua', 'Mamífero de hábitos diurnos em áreas de mata e parques.', NULL, 2);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Ratão-do-banhado', 'Myocastor coypus', 'Roedor associado a margens de rios e corpos d''água.', NULL, 2);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Morcego-frugívoro-grande', 'Artibeus lituratus', 'Morcego comum em áreas arborizadas e fragmentos urbanos.', NULL, 2);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Lagartixa-de-parede', 'Hemidactylus mabouia', 'Réptil muito adaptado a casas e construções urbanas.', NULL, 3);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Teiú', 'Salvator merianae', 'Grande lagarto que pode surgir em áreas verdes e periféricas.', NULL, 3);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Cágado-de-barbicha', 'Phrynops geoffroanus', 'Tartaruga de água doce comum em rios urbanos.', NULL, 3);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Calango-de-grama', 'Tropidurus torquatus', 'Lagarto observado em áreas secas, muros e vegetação baixa.', NULL, 3);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Falsa-coral', 'Erythrolamprus aesculapii', 'Serpente de ocorrência local em áreas de mata e parques.', NULL, 3);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Jararaca', 'Bothrops jararaca', 'Serpente peçonhenta de áreas de mata e bordas urbanas.', NULL, 3);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Sapo-cururu', 'Rhinella icterica', 'Anfíbio comum em áreas úmidas, jardins e terrenos.', NULL, 4);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Perereca-verde', 'Boana albopunctata', 'Anfíbio encontrado próximo a vegetação e água.', NULL, 4);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Perereca-de-banheiro', 'Scinax fuscovarius', 'Anfíbio muito adaptado a ambientes modificados.', NULL, 4);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Rã-manteiga', 'Leptodactylus latrans', 'Rã comum em áreas alagadas e vegetação marginal.', NULL, 4);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Borboleta-do-manacá', 'Methona themisto', 'Borboleta associada a plantas ornamentais e parques.', NULL, 5);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Borboleta-monarca', 'Danaus erippus', 'Borboleta frequente em jardins e áreas floridas.', NULL, 5);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Borboleta-júlia', 'Dryas iulia', 'Borboleta de voo rápido encontrada em áreas abertas.', NULL, 5);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Libélula-tigre', 'Pantala flavescens', 'Inseto alado associado a corpos d''água e áreas abertas.', NULL, 5);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Saúva-limão', 'Atta sexdens', 'Formiga cortadeira comum em áreas verdes urbanas.', NULL, 5);
INSERT IGNORE INTO especie (nome_popular, nome_cientifico, descricao, imagem_path, fk_grupo) VALUES ('Jataí', 'Tetragonisca angustula', 'Abelha nativa sem ferrão comum em jardins e parques.', NULL, 5);
