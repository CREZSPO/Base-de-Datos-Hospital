-- Consultas
--Tabla Ingreso
SELECT fechaingreso, diagnostico
FROM ingreso
WHERE id_ingreso = 10;

SELECT diagnostico
FROM ingreso
WHERE id_ingreso = 5;

-- Tabla ccama
SELECT tipocama
FROM ccama
WHERE id_cama = 4;

SELECT numcama
FROM ccama
WHERE id_cama = 15;

-- Tabla ingreso_cama
SELECT id_cama, id_ingreso
FROM ingreso_ccama
WHERE id_ingreso_cama = 5;

SELECT id_ingreso
FROM ingreso_ccama
WHERE id_ingreso_cama = 7;

--Tabla chabitaciones
SELECT id_habitacion, habitacion
FROM chabitaciones
WHERE id_habitacion = 3;

SELECT habitacion
FROM chabitaciones
WHERE id_habitacion = 9;

--Tabla ingreso_chabitaciones
SELECT id_habitacion
FROM ingreso_chabitaciones
WHERE id_ingreso_chabitaciones = 6;

SELECT id_ingreso, id_habitacion
FROM ingreso_chabitaciones
WHERE id_ingreso_chabitaciones = 8;

--Tabla piso
SELECT id_piso, npiso
FROM piso
WHERE id_piso = 2;

SELECT npiso
FROM piso
WHERE id_piso = 5;

--Tabla piso_habitacion
SELECT id_piso, id_habitacion
FROM piso_habitacion
WHERE id_pisohab = 2;

SELECT id_habitacion
FROM piso_habitacion
WHERE id_pisohab = 7;

--Tabla personal_venta
SELECT id_personal, id_venta
FROM personal_venta
WHERE id_personal_venta = 15;

SELECT id_personal
FROM personal_venta
WHERE id_personal_venta = 17;

--Consultas
--Tabla piso_consultorio

SELECT id_consultorio, id_piso
FROM piso_consultorio
WHERE id_pisoconsul = 13;

SELECT id_consultorio, id_piso
FROM piso_consultorio
WHERE id_pisoconsul = 5;

--Tabla consultorio

SELECT consultorio
FROM consultorio
WHERE id_consultorio = 10;

SELECT consultorio
FROM consultorio
WHERE id_consultorio = 2;

--Tabla consultorio_consulta

SELECT id_consulta, id_consultorio
FROM consultorio_consulta
WHERE id_consultorio_consulta = 5;

SELECT id_consulta, id_consultorio
FROM consultorio_consulta
WHERE id_consultorio_consulta = 12;

--Tabla consulta

SELECT diagnostico, precio
FROM consulta
WHERE id_consulta = 19;

SELECT id_consulta, hora
FROM consulta
WHERE fecha = '2003-05-12';

--Tabla consulta_paciente

SELECT id_consulta, id_paciente
FROM consulta_paciente
WHERE id_consulta_paciente = 16;

SELECT id_consulta, id_paciente
FROM consulta_paciente
WHERE id_consulta_paciente = 14;

--Tabla consulta_personal

SELECT id_consulta, id_personal
FROM consulta_personal
WHERE id_consulta_personal = 16;

SELECT id_consulta, id_personal
FROM consulta_personal
WHERE id_consulta_personal = 18;

--Tabla receta_consulta

SELECT id_receta, id_consulta
FROM receta_consulta
WHERE id_receta_consulta = 15 OR id_receta_consulta = 16;

SELECT id_receta_consulta
FROM receta_consulta
WHERE id_receta = 7;

--Tabla recetamedica

SELECT tratamiento
FROM recetamedica
WHERE id_receta = 9;

SELECT *
FROM recetamedica
WHERE id_receta = 1;

--Tabla venta_almacen

SELECT *
FROM venta_almacen
WHERE id_venta_almacen = 13;

SELECT *
FROM venta_almacen
WHERE id_venta_almacen = 8;

--Tabla medicamento_almacen

SELECT id_medicamento, id_almacen, cantidad
FROM medicamento_almacen
WHERE id_medicamento_almacen = 13;

SELECT id_medicamento, id_venta_almacen, cantidad
FROM medicamento_almacen
WHERE id_medicamento_almacen = 2;

/*
Consultas:
*/

-- especialista
SELECT id_especialista, id_universidad
FROM especialista
WHERE id_especialista = 10;

SELECT id_especialista, id_universidad
FROM especialista
WHERE id_universidad = 11;

-- especialidad

SELECT id_especialidad, especialidad.especialidad
FROM especialidad
WHERE especialidad.especialidad = 'cirugia general';

SELECT especialidad.especialidad
FROM especialidad
WHERE id_especialidad = 4;

-- cuniversidad

SELECT universidad
FROM cuniversidad
WHERE id_universidad = 5;

SELECT id_universidad, universidad
FROM cuniversidad
WHERE universidad = 'Hamamatsu University';

-- calergia

SELECT id_alergia, alergia
FROM calergia
WHERE alergia = 'Gatos';

SELECT alergia
FROM calergia
WHERE id_alergia = 15;

-- calergia_paciente

SELECT id_alergia_paciente,id_alergia, id_paciente
FROM calergia_paciente
WHERE id_alergia = 11;

SELECT id_alergia, id_paciente
FROM calergia_paciente
WHERE id_paciente = 19;

-- medicamento_receta

SELECT id_medicamento_receta,id_medicamento, id_receta, cantidad
FROM medicamento_receta
WHERE cantidad >= 2;

SELECT id_receta, cantidad
FROM medicamento_receta
WHERE cantidad = 1;

-- medicamento

SELECT id_medicamento,medicamento
FROM medicamento
WHERE id_medicamento = 15;

SELECT id_medicamento,medicamento
FROM medicamento
WHERE id_medicamento < 5;

-- venta

SELECT id_venta,fecha, costo
FROM venta
WHERE costo >= 500;

SELECT id_venta, fecha, costo, hora
FROM venta
WHERE fecha >= '2020-01-01'
  AND fecha < '2022-01-01';

-- medicamento_Venta

SELECT id_medicamento_venta,id_medicamento, id_venta
FROM medicamento_venta
WHERE id_medicamento = 2;

SELECT id_medicamento_venta,id_medicamento, id_venta
FROM medicamento_venta
WHERE id_medicamento > 20;

--persona
SELECT *
FROM persona
WHERE id_persona = 1 OR id_persona = 2;

SELECT id_persona, nombre,paterno, materno
FROM persona
WHERE nombre = 'Leda';

--direccion
SELECT *
FROM direccion
WHERE id_direccion = 1 OR id_direccion = 2;

SELECT id_direccion, cpostal, numerocalle
FROM direccion
WHERE numerocalle > 10;

--personal
SELECT *
FROM personal
WHERE id_personal = 2 OR id_personal = 5;

SELECT id_personal, rfc, sueldo, id_tipopersonal
FROM personal
WHERE sueldo > 20000;

--paciente
SELECT *
FROM paciente
WHERE id_paciente = 1 OR id_paciente = 3;

SELECT *
FROM paciente
WHERE id_tiposangre = 2;

--venta_receta
SELECT *
FROM venta_receta
WHERE id_venta_receta = 1 OR id_venta_receta = 2;

SELECT *
FROM venta_receta
WHERE id_venta > 8;

-- consultas ctipo personal
SELECT id_tipopersonal, tpersonal
FROM ctipopersonal
WHERE id_tipopersonal = 1;

SELECT  tpersonal
FROM ctipopersonal
WHERE id_tipopersonal = 2;

--consultas cmotivo
SELECT id_motivo,motivo
FROM cmotivo
WHERE id_motivo = 1;

SELECT id_motivo,motivo
FROM cmotivo
WHERE id_motivo < 3;

--consultas alta

SELECT fechaegreso
FROM alta
WHERE id_alta > 7;

SELECT fechaegreso
FROM alta
WHERE id_alta < 7;

--consultas ingreso_motivo

SELECT id_ingreso_motivo,id_ingreso,id_motivo
FROM ingreso_motivo
WHERE id_motivo = 8;


SELECT id_ingreso_motivo,id_ingreso,id_motivo
FROM ingreso_motivo
WHERE id_motivo < 3;
--consultas personal_ingreso


SELECT id_personal_ingreso,id_personal, id_ingreso
FROM personal_ingreso
WHERE id_ingreso = 8;

SELECT id_personal_ingreso,id_personal, id_ingreso
FROM personal_ingreso
WHERE id_personal < 10;
--consultas paciente_ingreso

SELECT id_paciente_ingreso,id_paciente, id_ingreso
FROM paciente_ingreso
WHERE id_paciente_ingreso = 4;


SELECT id_paciente_ingreso,id_paciente, id_ingreso
FROM paciente_ingreso
WHERE id_paciente_ingreso = 7;

--consulta persona_venta
SELECT id_persona_venta,id_venta, id_persona
FROM persona_venta
WHERE id_persona = 3;

SELECT id_persona_venta,id_venta, id_persona
FROM persona_venta
WHERE id_venta = 6;