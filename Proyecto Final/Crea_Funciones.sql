-- Función que devuelve un valor
-- Función que dado el nombre de una persona devuelve todos los gastos que ha tenido en el hospital
CREATE OR REPLACE FUNCTION fnc_gastopaciente (
	pnombre VARCHAR(30),
	ppaterno VARCHAR(30),
	pmaterno VARCHAR(30)
)
RETURNS NUMERIC
AS
$$
DECLARE idpersona INTEGER;
DECLARE idpaciente INTEGER;
DECLARE totalventas NUMERIC;
DECLARE totalconsultas NUMERIC;
DECLARE totalingreso NUMERIC;
BEGIN
	idpersona = (SELECT id_persona
				FROM persona
				WHERE nombre = pnombre
					AND paterno = ppaterno
					AND materno = pmaterno);

	idpaciente = (SELECT id_paciente
				 FROM paciente
				 WHERE id_persona = idpersona);

	totalventas = (SELECT SUM(costo)
				  FROM venta JOIN persona_venta ON persona_venta.id_venta = venta.id_venta
				  WHERE id_persona = idpersona);

	totalconsultas = (SELECT SUM(precio)
					 FROM consulta JOIN consulta_paciente ON consulta_paciente.id_consulta = consulta.id_consulta
					 WHERE id_paciente = idpaciente);

	totalingreso = (SELECT SUM(gastoingreso)
					FROM (SELECT (preciopd * (diff+1)) gastoingreso
						 FROM (SELECT preciopd, (fechaegreso-fechaingreso) diff
						   FROM ingreso JOIN paciente_ingreso ON paciente_ingreso.id_ingreso = ingreso.id_ingreso
								JOIN alta ON alta.id_alta = ingreso.id_alta
							WHERE id_paciente = idpaciente)T1)T2);

	RETURN totalventas + totalconsultas + totalingreso;
END
$$
LANGUAGE 'plpgsql' VOLATILE;

SELECT * FROM fnc_gastopaciente('Alysia', 'Kinny', 'Fish');

-- Función que devuelve una tabla
-- Función que regresa el id, nombre completo, habitación, número de cama, piso y la fecha del último ingreso del paciente

CREATE OR REPLACE FUNCTION fnc_informacionpacientes(pnombre VARCHAR(30), ppaterno VARCHAR(30), pmaterno VARCHAR(30))
    RETURNS TABLE
            (
                oid_ingreso   INTEGER,
                onombre       VARCHAR(30),
                opaterno      VARCHAR(30),
                omaterno      VARCHAR(30),
                ohabitacion   INTEGER,
                onumcama      INTEGER,
                onpiso        INTEGER,
                ofechaingreso DATE
            )
AS
$$
DECLARE idpersona INTEGER;
DECLARE idpaciente INTEGER;

BEGIN

	idpersona = (SELECT id_persona
				FROM persona
				WHERE nombre LIKE pnombre
					AND paterno LIKE ppaterno
					AND materno LIKE pmaterno);

	idpaciente = (SELECT id_paciente
				 FROM paciente
				 WHERE id_persona = idpersona);

    RETURN QUERY SELECT ingreso.id_ingreso, persona.nombre, persona.paterno, persona.materno,
						chabitaciones.habitacion, ccama.numcama, piso.npiso, ingreso.fechaingreso
				 FROM persona
					 JOIN paciente ON paciente.id_persona = persona.id_persona
					 JOIN paciente_ingreso ON paciente_ingreso.id_paciente = paciente.id_paciente
					 JOIN ingreso ON ingreso.id_ingreso = paciente_ingreso.id_ingreso
					 JOIN ingreso_chabitaciones ON ingreso_chabitaciones.id_ingreso = ingreso.id_ingreso
					 JOIN ingreso_ccama ON ingreso_ccama.id_ingreso = ingreso.id_ingreso
					 JOIN ccama ON ccama.id_cama = ingreso_ccama.id_cama
					 JOIN chabitaciones ON chabitaciones.id_habitacion = ingreso_chabitaciones.id_habitacion
					 JOIN piso_habitacion ON piso_habitacion.id_habitacion = chabitaciones.id_habitacion
					 JOIN piso ON piso.id_piso = piso_habitacion.id_piso
				 WHERE persona.id_persona = idpersona
				 	AND ingreso.fechaingreso = (SELECT max(fechaingreso)
											 FROM ingreso JOIN paciente_ingreso
											  	ON paciente_ingreso.id_ingreso = ingreso.id_ingreso
											 WHERE id_paciente = idpaciente);
END;
$$
LANGUAGE 'plpgsql' VOLATILE;

--Ejemplo
SELECT *
FROM fnc_informacionpacientes(pnombre := 'Deloris', ppaterno := 'Peagrim', pmaterno := 'Counter');

--Función que realiza una acción en la Base de Datos
--Insertar un nuevo paciente, asumiendo que el curp es unico para cada paciente, y
-- el nombre de los municipios es unico para cada estado
-- (si el municipio existe, no se verifica el estado)

CREATE OR REPLACE FUNCTION fnc_nuevopaciente(
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
DECLARE id_persona INTEGER;
DECLARE id_paciente INTEGER;
DECLARE id_tiposangre INTEGER;
DECLARE id_direccion INTEGER;
DECLARE id_municipio INTEGER;
DECLARE id_estado INTEGER;
DECLARE id_genero INTEGER;
DECLARE estatus_insercion TEXT;

BEGIN
	estatus_insercion = 'Insercion exitosa';
	--Si el paciente no existe
	IF((SELECT COUNT(*)
		FROM paciente
	    WHERE LOWER(paciente.curp) = LOWER(ncurp)) = 0)
	THEN
		--Se crea el id_paciente
		id_paciente = CASE WHEN ((SELECT MAX(paciente.id_paciente)
							    FROM paciente) IS NOT NULL)
						THEN (SELECT MAX(paciente.id_paciente)
							 FROM paciente)+1
						ELSE 1
						END;
		--Se busca el id_tiposangre y en caso de que exista continuamos
		IF((SELECT ctiposangre.id_tiposangre
						FROM ctiposangre
						WHERE tiposangre = ntiposangre) IS NOT NULL)
		THEN
			id_tiposangre = (SELECT ctiposangre.id_tiposangre
							FROM ctiposangre
							WHERE tiposangre = ntiposangre);
			--Si la persona no existe
			IF((SELECT COUNT(*)
				FROM persona
				WHERE nombre = nnombre
				AND paterno = apellido_paterno
				AND materno = apellido_materno
				AND nacimiento = fecha_nac) = 0)
			THEN
				--Se crea el id_persona
				id_persona = CASE WHEN ((SELECT MAX(persona.id_persona)
										FROM persona) IS NOT NULL)
								THEN (SELECT MAX(persona.id_persona)
									 FROM persona)+1
								ELSE 1
								END;
				--Verificamos si el genero existe en la base
				IF((SELECT cgenero.id_genero
				   FROM cgenero
				   WHERE etiqueta = ngenero) IS NOT NULL)
				THEN
					--Asignamos el id_genero
					id_genero = (SELECT cgenero.id_genero
								FROM cgenero
								WHERE etiqueta = ngenero);
					--Verificamos si el municipio existe
					IF((SELECT cmunicipio.id_municipio
						FROM cmunicipio
					    WHERE municipio = nmunicipio) IS NOT NULL)
					THEN
						--Asignamos el id_municipio
						id_municipio = (SELECT cmunicipio.id_municipio
										FROM cmunicipio
										WHERE municipio = nmunicipio);
						--Verificamos si la direccion existe
						IF((SELECT direccion.id_direccion
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
							INSERT INTO persona VALUES (id_persona,nnombre,apellido_paterno,apellido_materno,ncorreo,
														fecha_nac,ntelefono,id_genero,id_direccion);
							--Insertamos el nuevo paciente
							INSERT INTO paciente VALUES (id_paciente,UPPER(ncurp),id_persona,id_tiposangre);
						--La direccion no existe, la agregamos
						ELSE
							id_direccion = CASE WHEN ((SELECT MAX(direccion.id_direccion)
										FROM direccion) IS NOT NULL)
										THEN (SELECT MAX(direccion.id_direccion)
											 FROM direccion)+1
										ELSE 1
										END;
							--Insertamos la nueva direccion
							INSERT INTO direccion VALUES (id_direccion,nuevacalle,ncpostal,nnumerocalle,id_municipio);
							--Insertamos la nueva persona
							INSERT INTO persona VALUES (id_persona,nnombre,apellido_paterno,apellido_materno,ncorreo,
														fecha_nac,ntelefono,id_genero,id_direccion);
							--Insertamos el nuevo paciente
							INSERT INTO paciente VALUES (id_paciente,UPPER(ncurp),id_persona,id_tiposangre);
						END IF;
					--Municipio no existe, lo agregamos
					ELSE
						--Creamos el id_municipio
						id_municipio = CASE WHEN ((SELECT MAX(cmunicipio.id_municipio)
										FROM cmunicipio) IS NOT NULL)
										THEN (SELECT MAX(cmunicipio.id_municipio)
											 FROM cmunicipio)+1
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
							id_direccion = CASE WHEN ((SELECT MAX(direccion.id_direccion)
										FROM direccion) IS NOT NULL)
										THEN (SELECT MAX(direccion.id_direccion)
											 FROM direccion)+1
										ELSE 1
										END;
							INSERT INTO direccion VALUES (id_direccion,nuevacalle,ncpostal,nnumerocalle,id_municipio);
							--Insertamos la nueva persona
							INSERT INTO persona VALUES (id_persona,nnombre,apellido_paterno,apellido_materno,ncorreo,
														fecha_nac,ntelefono,id_genero,id_direccion);
							--Insertamos el nuevo paciente
							INSERT INTO paciente VALUES (id_paciente,UPPER(ncurp),id_persona,id_tiposangre);
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

--Ejemplo
SELECT *
FROM fnc_nuevopaciente('Enrique', 'Peña', 'Nieto', 'epn@gmail.com', '1966-07-20', '5544332211',
                       'Masculino', 'Presidencia', '23456', 3, 'Ecatepec', 'Edo. de Mexico', 'bryecsr7a04wa5b745',
                       'O+');

