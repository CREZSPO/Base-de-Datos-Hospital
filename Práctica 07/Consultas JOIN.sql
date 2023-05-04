/*
CONSULTAS CON JOIN Y FUNCIONES DE PAGINACION
*/

-- Obtener el nombre, apellido paterno apellido materno, sueldo del personal con los sueldos mas grandes

SELECT nombre, paterno, materno, sueldo
FROM persona JOIN personal ON persona.id_persona = personal.id_persona
ORDER BY sueldo DESC
OFFSET 0 LIMIT 5;

-- nombre, apellido paterno,apellido materno, curp de los pacientes, omitiendo los 2 primeros 3 registros y solo 3 registros
SELECT nombre,paterno, materno,curp
FROM persona NATURAL JOIN paciente
ORDER BY id_persona
OFFSET 2 LIMIT 3;

-- id_persona_venta, id persona, id venta, costo, omitiendo los primeros 5 registros y solo 7 registros, ordenado por id_persona_venta
SELECT id_persona_venta, id_persona, venta.id_venta, costo
FROM persona_venta LEFT JOIN venta ON persona_venta.id_venta = venta.id_venta
ORDER BY id_persona_venta
OFFSET 5 LIMIT 7;

-- id_venta_receta, id_venta, id_receta, tratamiento, solo 10 registros ordenados por id_venta_receta
SELECT id_venta_receta, id_venta, recetamedica.id_receta, tratamiento
FROM venta_receta RIGHT JOIN recetamedica ON venta_receta.id_receta = recetamedica.id_receta
ORDER BY id_venta_receta DESC
OFFSET 0 FETCH NEXT 10 ROWS ONLY;

-- producto cartesiano entre las tablas piso y piso_consultorio ordenados por id_pisoconsul omotiendo los primero 15 registros y  solo 10 registros
SELECT *
FROM piso CROSS JOIN piso_consultorio
ORDER BY id_pisoconsul
OFFSET 15 FETCH NEXT 10 ROWS ONLY;


/*
CONSULTAS CON JOIN Y TABLAS RENOMBRADAS
*/


--Consultas entre 2000 y 2005, fecha en la que se dieron y medicamentos que recetaron

SELECT id_consulta, fecha, COALESCE(medicamento,'No aplica') AS "Medicamento"
FROM medicamento RIGHT JOIN 
 (SELECT id_consulta,id_medicamento, fecha
  FROM medicamento_receta RIGHT JOIN
   (SELECT T1.id_consulta,receta_consulta.id_receta, fecha 
    FROM receta_consulta RIGHT JOIN
     (SELECT id_consulta, fecha
      FROM consulta
      WHERE EXTRACT(YEAR FROM fecha) BETWEEN 2000 AND 2005) T1 ON receta_consulta.id_consulta = T1.id_consulta) T2
  			ON medicamento_receta.id_receta = T2.id_receta) T3 ON medicamento.id_medicamento = T3.id_medicamento;
			
			
--Nombre, apellidos, domicilio y tipo de sangre de pacientes nacidos antes del 2000

SELECT "Nombre completo", tiposangre "Tipo de sangre", calle || ', ' || numerocalle || ', ' || cpostal || ', ' || municipio || ', ' || estado AS "Domicilio"
FROM cestado NATURAL JOIN
(SELECT nombre || ' ' || paterno || ' ' || materno AS "Nombre completo", tiposangre, calle, numerocalle, cpostal, municipio, id_estado
FROM cmunicipio JOIN 
(SELECT nombre,paterno,materno, tiposangre, calle,numerocalle,cpostal,id_municipio
FROM direccion NATURAL JOIN
(SELECT nombre,paterno,materno, tiposangre, id_direccion
FROM ctiposangre JOIN
(SELECT nombre, paterno, materno, id_tiposangre, id_direccion
FROM persona NATURAL JOIN paciente
WHERE EXTRACT(YEAR FROM nacimiento) < 2000) T1 ON ctiposangre.id_tiposangre = T1.id_tiposangre) T2) T3
ON cmunicipio.id_municipio = T3.id_municipio) T4;


/*
FUNCIONES CON JOIN Y FUNCIONES DE COMPOSICION
*/

--Nombre y cedula de medicos que han recetado y su tratamiento
SELECT nombre || ' ' || paterno || ' ' || materno AS "Nombre", cedula, tratamiento
FROM recetamedica rm JOIN receta_consulta rc ON rm.id_receta = rc.id_receta NATURAL JOIN consulta JOIN consulta_personal
ON consulta.id_consulta = consulta_personal.id_consulta LEFT JOIN personal ON consulta_personal.id_personal = personal.id_personal
JOIN ctipopersonal ON ctipopersonal.id_tipopersonal = personal.id_tipopersonal AND tpersonal ILIKE 'medico' NATURAL JOIN
persona;

--Nombre, especialidad y universidad de los especialistas
SELECT nombre || ' ' || paterno || ' ' || materno AS "Nombre", COALESCE(especialidad, 'Por verificar') AS "Especialidad", universidad
FROM especialista NATURAL JOIN personal JOIN persona ON personal.id_persona = persona.id_persona JOIN cuniversidad ON
cuniversidad.id_universidad = especialista.id_universidad FULL JOIN especialista_especialidad ON especialista_especialidad.id_especialista = especialista.id_especialista
LEFT JOIN especialidad ON especialidad.id_especialidad = especialista_especialidad.id_especialidad;

--Nombre, genero y motivo de los pacientes ingresados después del 2010
SELECT nombre || ' ' || paterno || ' ' || materno AS "Nombre", etiqueta genero, motivo
FROM ingreso NATURAL JOIN ingreso_motivo NATURAL JOIN cmotivo LEFT JOIN paciente_ingreso ON paciente_ingreso.id_ingreso = ingreso.id_ingreso
LEFT JOIN paciente ON paciente.id_paciente = paciente_ingreso.id_paciente JOIN persona ON persona.id_persona = paciente.id_persona
LEFT JOIN cgenero ON cgenero.id_genero = persona.id_genero
WHERE EXTRACT(YEAR FROM fechaingreso) > 2010;

--Nombre de las personas que compraron medicamentos entre 2005 y 2015 
SELECT nombre || ' ' || paterno || ' ' || materno AS "Nombre", fecha
FROM venta LEFT JOIN persona_venta ON persona_venta.id_venta = venta.id_venta
AND EXTRACT(YEAR FROM fecha) BETWEEN 2005 AND 2015  NATURAL JOIN persona;

--Habitaciones donde estuvieron ingresadas pacientes cuyo nombre empiece con M
SELECT nombre || ' ' || paterno || ' ' || materno AS "Nombre", habitacion
FROM ingreso JOIN ingreso_chabitaciones ON ingreso.id_ingreso = ingreso_chabitaciones.id_ingreso NATURAL JOIN chabitaciones
JOIN paciente_ingreso ON paciente_ingreso.id_ingreso = ingreso.id_ingreso JOIN paciente ON
paciente.id_paciente = paciente_ingreso.id_paciente JOIN persona ON persona.id_persona = paciente.id_persona 
WHERE nombre ILIKE 'M%'

