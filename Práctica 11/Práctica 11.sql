---------------------------- SP con dos o más parámetros de entrada y dos o más variables. ----------------------------

/*
	Insertar un nuevo paciente, asumiendo que el curp es unico para cada paciente, y
	el nombre de los municipios es unico para cada estado
	(si el municipio existe, no se verifica el estado)
*/
CREATE OR REPLACE FUNCTION sp_nuevopaciente(
    nnombre VARCHAR(30),
    apellido_paterno VARCHAR(30),
    apellido_materno VARCHAR(30),
    ncorreo VARCHAR(40),
    fecha_nac DATE,
    ntelefono VARCHAR(30),
    ngenero VARCHAR(20),
    nuevacalle VARCHAR(30),
    ncpostal VARCHAR(5),
    nnumerocalle INTEGER,
    nmunicipio VARCHAR(30),
    nestado VARCHAR(20),
    ncurp VARCHAR(18),
    ntiposangre VARCHAR(3)
)
    RETURNS TEXT
AS
$$
DECLARE
    id_persona                INTEGER;
    DECLARE id_paciente       INTEGER;
    DECLARE id_tiposangre     INTEGER;
    DECLARE id_direccion      INTEGER;
    DECLARE id_municipio      INTEGER;
    DECLARE id_estado         INTEGER;
    DECLARE id_genero         INTEGER;
    DECLARE estatus_insercion TEXT;

BEGIN
    estatus_insercion = 'Insercion exitosa';
    --Si el paciente no existe
    IF ((SELECT COUNT(*)
         FROM paciente
         WHERE LOWER(paciente.curp) = LOWER(ncurp)) = 0)
    THEN
        --Se crea el id_paciente
        id_paciente = CASE
                          WHEN ((SELECT MAX(paciente.id_paciente)
                                 FROM paciente) IS NOT NULL)
                              THEN (SELECT MAX(paciente.id_paciente)
                                    FROM paciente) + 1
                          ELSE 1
            END;
        --Se busca el id_tiposangre y en caso de que exista continuamos
        IF ((SELECT ctiposangre.id_tiposangre
             FROM ctiposangre
             WHERE tiposangre = ntiposangre) IS NOT NULL)
        THEN
            id_tiposangre = (SELECT ctiposangre.id_tiposangre
                             FROM ctiposangre
                             WHERE tiposangre = ntiposangre);
            --Si la persona no existe
            IF ((SELECT COUNT(*)
                 FROM persona
                 WHERE nombre = nnombre
                   AND paterno = apellido_paterno
                   AND materno = apellido_materno
                   AND nacimiento = fecha_nac) = 0)
            THEN
                --Se crea el id_persona
                id_persona = CASE
                                 WHEN ((SELECT MAX(persona.id_persona)
                                        FROM persona) IS NOT NULL)
                                     THEN (SELECT MAX(persona.id_persona)
                                           FROM persona) + 1
                                 ELSE 1
                    END;
                --Verificamos si el genero existe en la base
                IF ((SELECT cgenero.id_genero
                     FROM cgenero
                     WHERE etiqueta = ngenero) IS NOT NULL)
                THEN
                    --Asignamos el id_genero
                    id_genero = (SELECT cgenero.id_genero
                                 FROM cgenero
                                 WHERE etiqueta = ngenero);
                    --Verificamos si el municipio existe
                    IF ((SELECT cmunicipio.id_municipio
                         FROM cmunicipio
                         WHERE municipio = nmunicipio) IS NOT NULL)
                    THEN
                        --Asignamos el id_municipio
                        id_municipio = (SELECT cmunicipio.id_municipio
                                        FROM cmunicipio
                                        WHERE municipio = nmunicipio);
                        --Verificamos si la direccion existe
                        IF ((SELECT direccion.id_direccion
                             FROM direccion
                             WHERE calle = nuevacalle
                               AND cpostal = ncpostal
                               AND numerocalle = nnumerocalle) IS NOT NULL)
                        THEN
                            --Asignamos el id_direccion
                            id_direccion = (SELECT direccion.id_direccion
                                            FROM direccion
                                            WHERE calle = nuevacalle
                                              AND cpostal = ncpostal
                                              AND numerocalle = nnumerocalle);
                            --Insertamos la nueva persona
                            INSERT INTO persona
                            VALUES (id_persona, nnombre, apellido_paterno, apellido_materno, ncorreo,
                                    fecha_nac, ntelefono, id_genero, id_direccion);
                            --Insertamos el nuevo paciente
                            INSERT INTO paciente VALUES (id_paciente, UPPER(ncurp), id_persona, id_tiposangre);
                            --La direccion no existe, la agregamos
                        ELSE
                            id_direccion = CASE
                                               WHEN ((SELECT MAX(direccion.id_direccion)
                                                      FROM direccion) IS NOT NULL)
                                                   THEN (SELECT MAX(direccion.id_direccion)
                                                         FROM direccion) + 1
                                               ELSE 1
                                END;
                            --Insertamos la nueva direccion
                            INSERT INTO direccion
                            VALUES (id_direccion, nuevacalle, ncpostal, nnumerocalle, id_municipio);
                            --Insertamos la nueva persona
                            INSERT INTO persona
                            VALUES (id_persona, nnombre, apellido_paterno, apellido_materno, ncorreo,
                                    fecha_nac, ntelefono, id_genero, id_direccion);
                            --Insertamos el nuevo paciente
                            INSERT INTO paciente VALUES (id_paciente, UPPER(ncurp), id_persona, id_tiposangre);
                        END IF;
                        --Municipio no existe, lo agregamos
                    ELSE
                        --Creamos el id_municipio
                        id_municipio = CASE
                                           WHEN ((SELECT MAX(cmunicipio.id_municipio)
                                                  FROM cmunicipio) IS NOT NULL)
                                               THEN (SELECT MAX(cmunicipio.id_municipio)
                                                     FROM cmunicipio) + 1
                                           ELSE 1
                            END;
                        --Verificamos el estado
                        IF ((SELECT cestado.id_estado
                             FROM cestado
                             WHERE estado = nestado) IS NOT NULL)
                        THEN
                            id_estado = (SELECT cestado.id_estado
                                         FROM cestado
                                         WHERE estado = nestado);
                            --Insertamos el nuevo municipio
                            INSERT INTO cmunicipio VALUES (id_municipio, nmunicipio, id_estado);
                            --Insertamos la nueva direccion
                            INSERT INTO direccion
                            VALUES (id_direccion, nuevacalle, ncpostal, nnumerocalle, id_municipio);
                            --Insertamos la nueva persona
                            INSERT INTO persona
                            VALUES (id_persona, nnombre, apellido_paterno, apellido_materno, ncorreo,
                                    fecha_nac, ntelefono, id_genero, id_direccion);
                            --Insertamos el nuevo paciente
                            INSERT INTO paciente VALUES (id_paciente, UPPER(ncurp), id_persona, id_tiposangre);
                        ELSE
                            estatus_insercion = 'Estado no valido';
                        END IF;
                    END IF;
                    --Genero no existe
                ELSE
                    estatus_insercion = 'Genero no valido';
                END IF;
                --Si la persona ya existe
            ELSE
                --Se busca el id_persona
                id_persona = (SELECT persona.id_persona
                              FROM persona
                              WHERE nombre = nnombre
                                AND paterno = apellido_paterno
                                AND materno = apellido_materno
                                AND nacimiento = fecha_nac);
                --Se inserta
                INSERT INTO paciente VALUES (id_paciente, UPPER(ncurp), id_persona, id_tiposangre);
            END IF;
            --Tipo de sangre no encontrado
        ELSE
            estatus_insercion = 'Tipo de sangre no valido';
        END IF;
        --Si el paciente ya existe
    ELSE
        estatus_insercion = 'El paciente ya existe';
    END IF;
    RETURN estatus_insercion;
END;
$$
    LANGUAGE 'plpgsql' VOLATILE;

SELECT *
FROM sp_nuevopaciente('Enrique', 'Peña', 'Nieto', 'epn@gmail.com', '1966-07-20', '5544332211',
                      'Masculino', 'Presidencia', '23456', 3, 'Ecatepec', 'Edo. de Mexico', 'bryecsr7a04wa5b745', 'O+');



---------------------------- SP SP que realice una o más consultas del estilo UPDATE o DELETE. ----------------------------

-- Hacemos una incdersión para hacer el ejemplo
insert into venta (id_venta, fecha, costo, hora)
values (26, '2001-03-18', 114, '13:03');

-- Eliminar tupla de la tabla venta con el id_venta
CREATE OR REPLACE FUNCTION fnc_eliminarVenta(
    pidventa INTEGER
)
    RETURNS VARCHAR(20)
AS
$$
DECLARE
    estatus_delete VARCHAR(20);
BEGIN
    IF ((SELECT id_venta FROM venta WHERE id_venta = pidventa) IS NOT NULL)
    THEN
        DELETE FROM venta WHERE id_venta = pidventa;
        estatus_delete = 'Eliminacion exitosa';
    ELSE
        estatus_delete = 'El id de la venta no existe';
    END IF;
    RETURN estatus_delete;
END ;
$$
    LANGUAGE 'plpgsql';

-- Verificamos que la función trabaje correctamente
SELECT *
FROM fnc_eliminarVenta(26);

-- Comprobamos que el registró si se haya eliminado
SELECT *
FROM venta
WHERE id_venta = 26;