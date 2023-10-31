
-- Definición de la dimensión Desarrollador
CREATE TABLE IF NOT EXISTS dimension_desarrollador (
    desarrollador_id SERIAL PRIMARY KEY,
    developer VARCHAR(255)
);

-- Definición de la dimensión Publicador
CREATE TABLE IF NOT EXISTS dimension_publicador (
    publicador_id SERIAL PRIMARY KEY,
    publisher VARCHAR(255)
);

-- Definición de la dimensión Genero
CREATE TABLE IF NOT EXISTS dimension_genero (
    genero_id SERIAL PRIMARY KEY,
    genres VARCHAR(255)
);
-- Definición de la dimensión Juego
CREATE TABLE IF NOT EXISTS dimension_juego (
    juego_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    game_slug VARCHAR(255),
    price FLOAT,
    release_date VARCHAR(255),
    desarrollador_id INT,
    publicador_id INT,
    genero_id INT,
    FOREIGN KEY (desarrollador_id) REFERENCES dimension_desarrollador(desarrollador_id),
    FOREIGN KEY (publicador_id) REFERENCES dimension_publicador(publicador_id),
    FOREIGN KEY (genero_id) REFERENCES dimension_genero(genero_id)
);

-- Definición de la dimensión Compania del critico
CREATE TABLE IF NOT EXISTS dimension_compania (
    compania_id SERIAL PRIMARY KEY,
    company VARCHAR(255)
);


-- Definición de la dimensión Crítico
CREATE TABLE IF NOT EXISTS dimension_critico (
    critico_id SERIAL PRIMARY KEY,
    author VARCHAR(255),
    compania_id INT,
    FOREIGN KEY (compania_id) REFERENCES dimension_compania(compania_id)
);

-- Definición de la dimensión Tiempo
CREATE TABLE IF NOT EXISTS dimension_tiempo (
    tiempo_id SERIAL PRIMARY KEY,
    ano INT,
    mes INT,
    dia INT,
    fecha_completa VARCHAR(255)
);

-- Definición de la dimensión de hecho Rating
CREATE TABLE IF NOT EXISTS dimension_hecho_rating (
    id SERIAL PRIMARY KEY,
    juego_id INT,
    critico_id INT,
    tiempo_id INT,
    score_rating FLOAT,
    FOREIGN KEY (juego_id) REFERENCES dimension_juego(juego_id),
    FOREIGN KEY (critico_id) REFERENCES dimension_critico(critico_id),
    FOREIGN KEY (tiempo_id) REFERENCES dimension_tiempo(tiempo_id)
);
CREATE TABLE IF NOT EXISTS dimension_hecho_rating_critico (
    id_rating_crit SERIAL PRIMARY KEY,
    critico_id INT,
    tiempo_id INT,
    rating_promedio_diario FLOAT,
    FOREIGN KEY (critico_id) REFERENCES dimension_critico(critico_id),
    FOREIGN KEY (tiempo_id) REFERENCES dimension_tiempo(tiempo_id)
);
