---------------------------------------- Vistas ----------------------------------------

--Datos de los pacientes,ID de persona, Id de paciente, orden en que aparecen los tipos de sangre, y la cantidad de veces
-- que aparecen esos tipos de sangre de aquellos pacientes que su ID sea mayor que 5
CREATE OR REPLACE VIEW vw_datosPaciante AS
SELECT nombre,
       paterno,
       id_paciente,
       persona.id_persona                                                 idpersona,
       tiposangre,
       ROW_NUMBER() OVER (PARTITION BY tiposangre ORDER BY tiposangre) AS orden_tiposangre,
       COUNT(paciente.id_tiposangre) OVER (PARTITION BY tiposangre)       total
FROM persona
         JOIN paciente ON persona.id_persona = paciente.id_persona
         JOIN ctiposangre ON paciente.id_tiposangre = ctiposangre.id_tiposangre
WHERE id_paciente > 5
GROUP BY nombre, paterno, id_paciente, persona.id_persona, tiposangre;

SELECT *
FROM vw_datosPaciante;


-- Datos del trabajador, sueldo, ID de persona, ID de personal, sueldos acumulados de aquellos trabajadores
-- que hicieron ventas mayores a $300.
CREATE OR REPLACE VIEW vw_datosTrabajador AS
SELECT nombre,
       paterno,
       personal.id_persona,
       personal.id_personal,
       sueldo,
       SUM(sueldo) OVER (ORDER BY personal.id_personal DESC)
FROM persona
         JOIN personal ON persona.id_persona = personal.id_persona
         JOIN personal_venta ON personal.id_personal = personal_venta.id_personal
         JOIN venta ON personal_venta.id_venta = venta.id_venta
WHERE costo > 300
GROUP BY nombre, paterno, personal.id_persona, personal.id_personal, sueldo;

SELECT *
FROM vw_datosTrabajador;

--Datos de los es pecialistas, su ID, universidad y especialidad

CREATE OR REPLACE VIEW vw_datosExpecialista AS
SELECT id_personal, universidad, especialidad.especialidad
FROM especialista_especialidad
    JOIN especialista ON especialista_especialidad.id_especialista = especialista.id_especialista
    JOIN cuniversidad ON especialista.id_universidad = cuniversidad.id_universidad
    JOIN especialidad ON especialista_especialidad.id_especialidad = especialidad.id_especialidad
GROUP BY id_personal, universidad, especialidad.especialidad
ORDER BY id_personal ASC;

SELECT *
FROM vw_datosExpecialista;

---------------------------------------- Índices ----------------------------------------

CREATE INDEX idx_persona ON persona(nombre, paterno);

CREATE INDEX idx_genero ON cgenero(etiqueta);

CREATE INDEX idx_especialidad ON especialidad(especialidad);

CREATE INDEX idx_especialista ON especialista(id_especialista);

CREATE INDEX idx_personal ON personal(id_personal);

CREATE INDEX idx_paciente ON paciente(id_paciente);

CREATE INDEX idx_medicamento ON medicamento(id_medicamento);

CREATE INDEX idx_consultorio ON consultorio(consultorio);

CREATE INDEX idx_piso_consultorio ON piso_consultorio(id_consultorio);

CREATE INDEX idx_cama ON ccama(numcama);

CREATE INDEX idx_habitacion ON chabitaciones(habitacion);

CREATE INDEX idx_piso ON piso(npiso);

CREATE INDEX idx_piso_habitacion ON piso_habitacion(id_habitacion);

CREATE INDEX idx_tipo_personal ON ctipopersonal(tpersonal);

CREATE INDEX idx_motivo ON cmotivo(motivo);

CREATE INDEX idx_ingreso_motivo ON ingreso_motivo(id_ingreso);

CREATE INDEX idx_ingreso_habitacion ON ingreso_chabitaciones(id_habitacion);

CREATE INDEX idx_ingreso ON ingreso(id_ingreso);

CREATE INDEX idx_medicamento_almacen ON medicamento_almacen(id_medicamento);

CREATE INDEX idx_estado ON cestado(estado);

CREATE INDEX idx_municipio ON cmunicipio(id_estado);

CREATE INDEX idx_tiposangre ON ctiposangre(tiposangre);

CREATE INDEX idx_consulta ON consulta(id_consulta);

---------------------------------------- CTE's de tipo SELECT ----------------------------------------

--Nombre de los medicos que han atendido ingresos después del 2010

WITH cte_medicos AS
(SELECT p.*, nombre,paterno,materno
FROM personal p JOIN ctipopersonal ON p.id_tipopersonal = ctipopersonal.id_tipopersonal
 				JOIN persona ON persona.id_persona = p.id_persona
WHERE tpersonal ILIKE 'medico' )
SELECT nombre, paterno, materno
FROM cte_medicos JOIN personal_ingreso ON cte_medicos.id_personal = personal_ingreso.id_personal
				JOIN ingreso ON ingreso.id_ingreso = personal_ingreso.id_ingreso
WHERE EXTRACT(YEAR FROM fechaingreso) > 2010;


--Nombre completo y sueldo del enfermero con el sueldo más alto

WITH cte_enfermero AS
(SELECT p.*, tpersonal, nombre, paterno, materno, correo, nacimiento, telefono, id_genero, id_direccion
FROM personal p JOIN ctipopersonal ctp ON p.id_tipopersonal = ctp.id_tipopersonal
 				JOIN persona ps ON p.id_persona = ps.id_persona
WHERE tpersonal ILIKE 'enfermero')
SELECT nombre, paterno, materno, sueldo
FROM cte_enfermero
WHERE sueldo =
(SELECT MAX(sueldo)
FROM cte_enfermero);

----------------------------------------  CTE'S de tipo DELETE ----------------------------------------

-- Primero insertamos valores
insert into alta (id_alta,fechaegreso) values (23,'1999-02-11');
insert into alta (id_alta,fechaegreso) values (24,'1998-02-11');

CREATE TABLE alta_antiguo (
    id_alta                     SERIAL,
    fechaegreso                 DATE
);

WITH cte_alta_ant AS (
    DELETE FROM alta
    WHERE EXTRACT (YEAR FROM fechaegreso) <= 1999
    RETURNING  *
)

    INSERT INTO alta_antiguo
SELECT * FROM cte_alta_ant;

SELECT *
FROM alta_antiguo;

--Segunda consulta
insert into personal (id_personal, rfc, cedula, sueldo, id_persona, id_tipopersonal) values (36,'BSCGYFO3456HY','5792688356',20000,3,1);
insert into personal (id_personal, rfc, cedula, sueldo, id_persona, id_tipopersonal) values (37,'SDFGHJKL45678','2345789635',21000,4,2);
insert into personal (id_personal, rfc, cedula, sueldo, id_persona, id_tipopersonal) values (38,'8HUSZE7A4URO9','8901326572',22000,5,3);

CREATE TABLE personal_despedido(
	id_personal 		integer,
	rfc					varchar(13),
	cedula  			varchar(20),
	sueldo 				numeric,
	id_persona			integer,
	id_tipopersonal		integer
);

WITH cte_pers_desp AS (
    DELETE FROM personal
    WHERE id_personal IN (36,37,38)
    RETURNING  *
)
INSERT INTO personal_despedido
SELECT * FROM cte_pers_desp;

SELECT *
FROM personal_despedido;