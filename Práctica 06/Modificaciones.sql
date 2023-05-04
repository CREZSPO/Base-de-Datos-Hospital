-- Modificación
--Tabla Ingreso
UPDATE ingreso
SET preciopd = 580
WHERE id_ingreso = 15;

UPDATE ingreso
SET fechaingreso = '2007-11-15'
WHERE id_ingreso = 8;

-- Tabla ccama

-- Tabla ingreso_cama
UPDATE ingreso_ccama
SET id_cama = 16
WHERE id_ingreso_cama = 13;

UPDATE ingreso_ccama
SET id_cama = 18
WHERE id_ingreso_cama = 5;

--Tabla chabitaciones

--Tabla ingreso_chabitaciones
UPDATE ingreso_chabitaciones
SET id_habitacion = 20
WHERE id_ingreso_chabitaciones = 1;

UPDATE ingreso_chabitaciones
SET id_habitacion = 10
WHERE id_ingreso_chabitaciones = 7;

--Tabla piso

--Tabla piso_habitacion

--Tabla personal_venta
UPDATE personal_venta
SET id_personal = 3
WHERE id_personal_venta = 12;

UPDATE personal_venta
SET id_personal = 5
WHERE id_personal_venta = 18;

--Modificaciones

--Tabla consulta

UPDATE consulta
SET precio = 1000
WHERE id_consulta = 1;

UPDATE consulta
SET fecha = '2018-07-26'
WHERE id_consulta = 20;

--Tabla consultorio_consulta

UPDATE consultorio_consulta
SET id_consultorio = 5
WHERE id_consultorio_consulta = 3;

UPDATE consultorio_consulta
SET id_consultorio = 10
WHERE id_consultorio_consulta = 9;

--Tabla consulta_paciente

UPDATE consulta_paciente
SET id_paciente = 13
WHERE id_consulta_paciente = 20;

UPDATE consulta_paciente
SET id_paciente = 4
WHERE id_consulta_paciente = 18;

--Tabla consulta_personal

UPDATE consulta_personal
SET id_personal = 26
WHERE id_consulta = 12;

UPDATE consulta_personal
SET id_personal = 28
WHERE id_consulta = 1;

--Tabla receta_consulta
--Supongamos que se equivocaron al momento de relacionar la consulta y la receta que se expide en esta.
UPDATE receta_consulta
SET id_consulta = 7
WHERE id_receta = 12;

UPDATE receta_consulta
SET id_consulta = 17
WHERE id_receta = 10;

--Tabla recetamedica

UPDATE recetamedica
SET tratamiento = 'Ciprofloxacina de 500 mg cada 12 horas por una semana'
WHERE id_receta = 12;

UPDATE recetamedica
SET tratamiento = 'Pravastatina cada 12 horas'
WHERE id_receta = 10;

--Tabla venta_almacen
UPDATE venta_almacen
SET id_venta = 7
WHERE id_venta_almacen = 3;

UPDATE venta_almacen
SET id_venta = 5
WHERE id_venta_almacen = 4;

--Tabla medicamento_almacen

UPDATE medicamento_almacen
SET cantidad = 2
WHERE id_medicamento_almacen = 13;

UPDATE medicamento_almacen
SET cantidad = 4
WHERE id_medicamento_almacen = 10;

/*
Modificaciones:
*/

-- especialista

-- Supongamos nos equivocamos en el las universidades de lo id_especialista = 1 y 10 y queremos
-- corregir sus universidades

UPDATE especialista
SET id_universidad = 8
WHERE id_especialista = 1;

UPDATE especialista
SET id_universidad = 4
WHERE id_especialista = 10;

-- especialidad

UPDATE especialidad
SET especialidad = 'no tiene especialidad'
WHERE id_especialidad = 1;

UPDATE especialidad
SET especialidad = 'urgencias'
WHERE id_especialidad = 4;

-- cuniversidad

UPDATE cuniversidad
SET universidad = 'National Autonomous University of Mexico'
WHERE id_universidad = 5;

UPDATE cuniversidad
SET universidad = 'Harvard Medical School'
WHERE id_universidad = 10;

-- calergia

UPDATE calergia
SET alergia = 'Electrosensibilidad'
WHERE id_alergia = 12;

UPDATE calergia
SET alergia = 'Dermografismo '
WHERE id_alergia = 16;

-- calergia_paciente

UPDATE calergia_paciente
SET id_alergia = 12
WHERE id_alergia_paciente = 9;

UPDATE calergia_paciente
SET id_alergia = 2
WHERE id_alergia_paciente = 15;

-- medicamento_receta

UPDATE calergia_paciente
SET id_alergia = 2
WHERE id_alergia_paciente = 15;

UPDATE calergia_paciente
SET id_alergia = 2
WHERE id_alergia_paciente = 15;

-- medicamento

UPDATE medicamento
SET medicamento = 'OxyCotin'
WHERE id_medicamento = 21;

UPDATE medicamento
SET medicamento = 'Metaqualona'
WHERE id_medicamento = 28;

-- venta

UPDATE venta
SET costo = 500
WHERE id_venta = 20;

UPDATE venta
SET fecha = '2022-03-30'
WHERE id_venta = 6;

-- medicamento_Venta

UPDATE medicamento_venta
SET id_medicamento = 21
WHERE id_medicamento_venta = 11;

UPDATE medicamento_venta
SET id_medicamento = 16
WHERE id_medicamento_venta = 13;

--persona
UPDATE persona
SET nombre = 'Mariel'
WHERE id_persona = 1;

UPDATE persona
SET nombre = 'Melvin'
WHERE id_persona = 2;

--direccion
UPDATE direccion
SET cpostal = '11111'
WHERE id_direccion = 1;

UPDATE direccion
SET cpostal = '22222'
WHERE id_direccion = 2;

--personal
UPDATE personal
SET id_tipopersonal = 1
WHERE id_personal = 2;

UPDATE personal
SET sueldo = 20000
WHERE id_personal =5;

--paciente
UPDATE paciente
SET curp = 'CIHJ000422HDFHRRA1'
WHERE id_paciente = 1;

UPDATE paciente
SET id_tiposangre = 2
WHERE id_paciente = 3;

--venta_receta
UPDATE venta_receta
SET id_venta = 1
WHERE id_venta_receta = 1;

UPDATE venta_receta
SET id_receta = 7
WHERE id_venta_receta = 2;

--modificaciones
--tabla ctipopersonal


--tabla cmotivo

--tabla alta
UPDATE alta
SET fechaegreso = '2014-02-12'
WHERE id_alta = 1;

UPDATE alta
SET fechaegreso = '2007-07-17'
WHERE id_alta = 2;

--tabla ingreso motivo

UPDATE ingreso_motivo
SET id_motivo = 11
WHERE id_ingreso_motivo= 4;


UPDATE ingreso_motivo
SET id_motivo = 12
WHERE id_ingreso_motivo= 6;

--tabla personal_ingreso
UPDATE personal_ingreso
SET id_personal = 21
WHERE id_personal_ingreso = 2;

UPDATE personal_ingreso
SET id_personal = 25
WHERE id_personal_ingreso = 18;

--tabla paciente_ingreso

UPDATE paciente_ingreso
SET id_paciente = 12
WHERE id_paciente_ingreso = 2;


UPDATE paciente_ingreso
SET id_paciente = 7
WHERE id_paciente_ingreso = 3;

--tabla persona_venta

UPDATE persona_venta
SET id_persona = 2
WHERE id_persona_venta = 10;


UPDATE persona_venta
SET id_persona = 25
WHERE id_persona_venta = 4;