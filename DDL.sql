
-- Definición de la dimensión Desarrollador
CREATE TABLE IF NOT EXISTS dimension_desarrollador (
    desarrollador_id SERIAL PRIMARY KEY,
    nombre_desarrollador VARCHAR(255)
);

-- Definición de la dimensión Publicador
CREATE TABLE IF NOT EXISTS dimension_publicador (
    publicador_id SERIAL PRIMARY KEY,
    nombre_publicador VARCHAR(255)
);

-- Definición de la dimensión Genero
CREATE TABLE IF NOT EXISTS dimension_genero (
    genero_id SERIAL PRIMARY KEY,
    nombre_genero VARCHAR(255)
);
-- Definición de la dimensión Juego
CREATE TABLE IF NOT EXISTS dimension_juego (
    juego_id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
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
    nombre_compania VARCHAR(255)
);


-- Definición de la dimensión Crítico
CREATE TABLE IF NOT EXISTS dimension_critico (
    critico_id SERIAL PRIMARY KEY,
    nombre_critico VARCHAR(255),
    compania_critico VARCHAR(255)
    score_rating FLOAT
    FOREIGN KEY (compania_id) REFERENCES dimension_compania(compania_id)
);

-- Definición de la dimensión Tiempo
CREATE TABLE IF NOT EXISTS dimension_tiempo (
    tiempo_id SERIAL PRIMARY KEY,
    ano INT,
    mes INT,
    dia INT
);

-- Definición de la dimensión de hecho Rating
CREATE TABLE IF NOT EXISTS dimension_hecho_rating (
    juego_id SERIAL,
    critico_id INT,
    tiempo_id INT,
    rating_promedio_publicador FLOAT,
    rating_promedio_desarrollador FLOAT,
    rating_promedio_genero FLOAT,
    FOREIGN KEY (juego_id) REFERENCES dimension_juego(juego_id),
    FOREIGN KEY (critico_id) REFERENCES dimension_critico(critico_id),
    FOREIGN KEY (tiempo_id) REFERENCES dimension_tiempo(tiempo_id)
);
