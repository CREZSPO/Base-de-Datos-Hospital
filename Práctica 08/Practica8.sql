--Operadores de comparacion y JOIN

---- Nombre completo del personal que tienen un sueldo mayor a $20000 y menor a $28000
SELECT nombre, paterno, materno, sueldo
FROM persona JOIN personal ON persona.id_persona = personal.id_persona
WHERE sueldo > 20000 AND  sueldo < 28000
ORDER BY sueldo DESC;

--ID del almacen, ID del medicamento y la cantidad del medicamento que hay en cada almacén para los ID de
-- los medicamentos que no son nulos y mayores a 10
SELECT id_almacen, medicamento.id_medicamento, cantidad
FROM medicamento_almacen RIGHT JOIN medicamento ON medicamento_almacen.id_medicamento = medicamento.id_medicamento
WHERE medicamento.id_medicamento > 10 AND cantidad IS NOT NULL
ORDER BY cantidad DESC;

-- ID de persona, ID de paciente y nombre completo de aquellos pacientes que non de tipo de sangre A-, B+, B-
-- y su nombre no empieza con T
SELECT id_persona, id_paciente, nombre, paterno,id_tiposangre
FROM persona NATURAL JOIN paciente
WHERE id_tiposangre NOT IN (2,3,4) AND nombre NOT LIKE 'T%'
ORDER BY id_persona;

-- id del medicamento, fecha de la venta y sel monto de aquellas ventas que se hicieron entre 2014-01-01 y
-- 2015-01-01 y el monto fue mayor de 600
SELECT id_medicamento, fecha, costo
FROM medicamento_venta RIGHT JOIN venta ON medicamento_venta.id_venta = venta.id_venta
WHERE fecha > '2014-01-01' AND fecha < '2015-01-01' AND costo > 600;


--Funciones de agregacion, agrupacion y JOIN

--Total, minimo, maximo y promedio del sueldo del personal y cantidad de personal, por tipo de personal
SELECT tpersonal, SUM(sueldo) total, MIN(sueldo) minimo, MAX(sueldo) maximo, AVG(sueldo) promedio, COUNT(*) cantidad
FROM personal JOIN ctipopersonal ON personal.id_tipopersonal = ctipopersonal.id_tipopersonal
GROUP BY tpersonal;

--Cantidad de pacientes que ha estado en cada consultorio, y cuanto dinero se ha recibido en el
SELECT consultorio, COUNT(id_paciente) pacientes, SUM(precio) "cantidad de dinero"
FROM consulta NATURAL JOIN consultorio_consulta NATURAL JOIN consultorio 
NATURAL JOIN consulta_paciente NATURAL JOIN paciente
GROUP BY consultorio;

--Numero de ventas y total recaudado por farmaceutico y si tenía receta o no
SELECT id_personal, receta, COUNT(T1.id_venta), SUM(costo)
FROM (SELECT venta.id_venta, costo, CASE WHEN recetamedica.id_receta IS NULL THEN 
	  'No cuenta con receta' ELSE 'Cuenta con receta' END receta
	  FROM venta LEFT JOIN venta_receta ON venta.id_venta = venta_receta.id_venta LEFT JOIN recetamedica
ON recetamedica.id_receta = venta_receta.id_receta) T1 JOIN personal_venta ON T1.id_venta = personal_venta.id_venta
GROUP BY id_personal,receta
ORDER BY 1;

--Cantidad de pacientes por estado y tipo de sangre que han sido ingresados
SELECT estado, tiposangre, COUNT(DISTINCT paciente.id_paciente)
FROM ingreso LEFT JOIN paciente_ingreso ON ingreso.id_ingreso = paciente_ingreso.id_ingreso LEFT JOIN paciente ON
paciente.id_paciente = paciente_ingreso.id_paciente NATURAL JOIN ctiposangre NATURAL JOIN persona NATURAL JOIN 
direccion NATURAL JOIN cmunicipio NATURAL JOIN cestado
GROUP BY estado, tiposangre;


--Funciones de comparacion, agregacion, agrupacion y JOIN

-- Fecha de ingreso, monto total por dias de estancia en el hospital que se hicieron por fecha de aquellos
-- que su diagnostico no fue por un dolor en el vientre y que haya ingresado entre 2010-01-01 y 2019-01-01
SELECT fechaingreso, SUM(preciopd) total
FROM ingreso INNER JOIN alta ON ingreso.id_alta = alta.id_alta
WHERE diagnostico NOT LIKE 'Dolor en el vientre' AND fechaingreso BETWEEN '2010-01-01' and '2019-01-01'
GROUP BY fechaingreso;

--  ID de los tipos de sangre y la cantidad de veces que aperecen para aquellos pacientes que tienen tipo de
--  sangre A+, A-, B+ y el ID del pacientre esta entre 1 y 20
SELECT id_tiposangre, COUNT(id_tiposangre)
FROM persona LEFT JOIN paciente on persona.id_persona = paciente.id_persona
WHERE id_tiposangre IN (1,2,3) AND id_paciente BETWEEN 1 and 20
GROUP BY id_tiposangre;