-- Eliminaciones
--Tabla Ingreso
DELETE FROM ingreso
WHERE id_ingreso = 21;

DELETE FROM ingreso
WHERE id_ingreso = 22;

-- Tabla ccama

-- Tabla ingreso_cama
DELETE FROM ingreso_ccama
WHERE id_ingreso = 20;

DELETE FROM ingreso_ccama
WHERE id_ingreso_cama = 19;

--Tabla chabitaciones

--Tabla ingreso_chabitaciones
DELETE FROM ingreso_chabitaciones
WHERE id_ingreso = 20;

DELETE FROM ingreso_chabitaciones
WHERE id_ingreso = 19;

--Tabla piso

--Tabla piso_habitacion

--Tabla personal_venta
DELETE FROM personal_venta
WHERE id_personal = 19;

DELETE FROM personal_venta
WHERE id_personal = 20;

--Eliminaciones

--Tabla consultorio_consulta

DELETE FROM consultorio_consulta
WHERE id_consultorio_consulta = 21;

DELETE FROM consultorio_consulta
WHERE id_consultorio_consulta = 22;

--Tabla consulta_paciente

DELETE FROM consulta_paciente
WHERE id_consulta_paciente = 21;

DELETE FROM consulta_paciente
WHERE id_consulta_paciente = 22;

--Tabla consulta_personal

DELETE FROM consulta_personal
WHERE id_consulta_personal = 21;

DELETE FROM consulta_personal
WHERE id_consulta_personal = 22;

--Tabla consulta

DELETE FROM consulta
WHERE id_consulta = 21;

DELETE FROM consulta
WHERE id_consulta = 22;

--Tabla receta_consulta

DELETE FROM receta_consulta
WHERE id_receta_consulta = 11;

DELETE FROM receta_consulta
WHERE id_receta_consulta = 16;

-- medicamento_receta

DELETE FROM medicamento_receta
WHERE id_medicamento_receta = 11;

DELETE FROM medicamento_receta
WHERE id_medicamento_receta = 16;

--venta_receta
DELETE FROM venta_receta
WHERE id_venta_receta =11;

DELETE FROM venta_receta
WHERE id_venta_receta =13;

--Tabla recetamedica

DELETE FROM recetamedica
WHERE id_receta = 11;

DELETE FROM recetamedica
WHERE id_receta = 16;

--Tabla medicamento_almacen

DELETE FROM medicamento_almacen
WHERE id_almacen = 6;

DELETE FROM medicamento_almacen
WHERE id_almacen = 3;

--Tabla venta_almacen

DELETE FROM venta_almacen
WHERE id_venta_almacen = 14;

DELETE FROM venta_almacen
WHERE id_venta_almacen = 15;



/*
Eliminaciones :
*/

-- especialista

DELETE FROM especialista
WHERE id_especialista = 19;

DELETE FROM especialista
WHERE id_especialista = 20;

-- especialidad

DELETE FROM especialidad
WHERE id_especialidad = 16;

DELETE FROM especialidad
WHERE id_especialidad = 17;

-- cuniversidad

DELETE FROM cuniversidad
WHERE id_universidad = 19;

DELETE FROM cuniversidad
WHERE id_universidad = 20;

-- calergia

DELETE FROM calergia
WHERE alergia = 'Insulina';

DELETE FROM calergia
WHERE id_alergia = 16;

-- calergia_paciente

DELETE FROM calergia_paciente
WHERE id_alergia = 18;

DELETE FROM calergia_paciente
WHERE id_alergia = 17;

-- medicamento

DELETE FROM medicamento
WHERE id_medicamento = 29;

DELETE FROM medicamento
WHERE medicamento = 'Mepivacaina';

-- venta

DELETE FROM venta
WHERE id_venta = 21;

DELETE FROM venta
WHERE id_venta = 22;

-- medicamento_Venta

DELETE FROM medicamento_venta
WHERE id_venta = 19;

DELETE FROM medicamento_venta
WHERE id_venta = 20;

--persona
DELETE FROM persona
WHERE id_persona = 9;

DELETE FROM persona
WHERE nombre ='Inger';

--direccion
DELETE FROM direccion
WHERE id_direccion = 14;

DELETE FROM direccion
WHERE numerocalle = 14;

--personal
DELETE  FROM personal
WHERE cedula = '63538037';

DELETE  FROM personal
WHERE id_personal = 20;

--paciente
DELETE FROM paciente
WHERE curp ='SDFG553100TYUIOPZX';

DELETE FROM paciente
WHERE id_paciente = 22;

--eliminaciones
--tabla ctipopersonal (tabla art)
--inscerciones art
DELETE FROM ctipopersonal
WHERE id_tipopersonal = 5;

DELETE FROM ctipopersonal
WHERE id_tipopersonal = 6;

--tabla cmotivo (tabla art)


DELETE FROM cmotivo
WHERE id_motivo = 22;

DELETE FROM cmotivo
WHERE id_motivo = 23;

--tabla alta (tabla art)


DELETE FROM alta
WHERE id_alta= 21;


DELETE FROM alta
WHERE id_alta= 22;

--tabla ingreso_motivo (tabla art)

DELETE FROM ingreso_motivo
WHERE id_ingreso_motivo = 21;

DELETE FROM ingreso_motivo
WHERE id_ingreso_motivo = 22;

--tabla personal_ingreso

DELETE FROM personal_ingreso
WHERE id_personal_ingreso = 31;


DELETE FROM personal_ingreso
WHERE id_personal_ingreso = 32;

--tabla paciente ingreso
DELETE FROM paciente_ingreso
WHERE id_paciente_ingreso = 22;


DELETE FROM paciente_ingreso
WHERE id_paciente_ingreso = 23;

--tabla persona_venta

DELETE FROM persona_venta
WHERE id_persona_venta = 21;


DELETE FROM persona_venta
WHERE id_persona_venta = 22;
