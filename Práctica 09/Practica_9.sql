--Extension para usar crosstab
CREATE EXTENSION tablefunc;

/*
 1. Consultas CROSSTAB un parámetro
*/


-- Cantidad de personal según su género y el tipo de personal que sean
SELECT *
FROM CROSSTAB(
    'SELECT ''medico'' tipo, id_genero, COUNT(id_tipopersonal) total
    FROM persona INNER JOIN personal ON personal.id_persona = persona.id_persona
    WHERE id_tipopersonal= 1
    GROUP BY id_genero
    UNION ALL
    SELECT ''enfermero'', id_genero, COUNT(id_tipopersonal) total2
    FROM persona INNER JOIN personal ON personal.id_persona = persona.id_persona
    WHERE id_tipopersonal= 2
    GROUP BY id_genero
    UNION ALL
    SELECT ''farmaceutico'', id_genero, COUNT(id_tipopersonal) total3
    FROM persona INNER JOIN personal ON personal.id_persona = persona.id_persona
    WHERE id_tipopersonal= 3
    GROUP BY id_genero
    UNION ALL
    SELECT ''recepcionista'', id_genero, COUNT(id_tipopersonal) total4
    FROM persona INNER JOIN personal ON personal.id_persona = persona.id_persona
    WHERE id_tipopersonal= 4
    GROUP BY id_genero
    ORDER BY tipo, id_genero;'

) AS resultado(TIPO TEXT, MASCULINO BIGINT , FEMENINO BIGINT, NO_BINARIO BIGINT);


-- Cantidad de pacientes según el genero y el tipo de sangre que tengan
SELECT *
FROM CROSSTAB(
    'SELECT ''A+'' tipo, id_genero, COUNT(id_tiposangre) total
    FROM persona INNER JOIN paciente ON paciente.id_persona = persona.id_persona
    WHERE id_tiposangre= 1
    GROUP BY id_genero
    UNION ALL
    SELECT ''A-'' tipo, id_genero, COUNT(id_tiposangre) total1
    FROM persona INNER JOIN paciente ON paciente.id_persona = persona.id_persona
    WHERE id_tiposangre= 2
    GROUP BY id_genero
    UNION ALL
    SELECT ''B+'' tipo, id_genero, COUNT(id_tiposangre) total2
    FROM persona INNER JOIN paciente ON paciente.id_persona = persona.id_persona
    WHERE id_tiposangre= 3
    GROUP BY id_genero
    UNION ALL
    SELECT ''B-'' tipo, id_genero, COUNT(id_tiposangre) total3
    FROM persona INNER JOIN paciente ON paciente.id_persona = persona.id_persona
    WHERE id_tiposangre= 4
    GROUP BY id_genero
    UNION ALL
    SELECT ''AB+'' tipo, id_genero, COUNT(id_tiposangre) total4
    FROM persona INNER JOIN paciente ON paciente.id_persona = persona.id_persona
    WHERE id_tiposangre= 5
    GROUP BY id_genero
    UNION ALL
    SELECT ''AB-'' tipo, id_genero, COUNT(id_tiposangre) total5
    FROM persona INNER JOIN paciente ON paciente.id_persona = persona.id_persona
    WHERE id_tiposangre= 6
    GROUP BY id_genero
    UNION ALL
    SELECT ''O+'' tipo, id_genero, COUNT(id_tiposangre) total6
    FROM persona INNER JOIN paciente ON paciente.id_persona = persona.id_persona
    WHERE id_tiposangre= 7
    GROUP BY id_genero
    UNION ALL
    SELECT ''O-'' tipo, id_genero, COUNT(id_tiposangre) total7
    FROM persona INNER JOIN paciente ON paciente.id_persona = persona.id_persona
    WHERE id_tiposangre= 8
    GROUP BY id_genero
    ORDER BY tipo, id_genero;'

) AS resultado(TIPO_SANGRE TEXT, MASCULINO BIGINT , FEMENINO BIGINT, NO_BINARIO BIGINT);

/*
  2. Consultas CROSSTAB dos parámetros
*/

--Pacientes ingresados por tipo de sangre y año

SELECT *
FROM CROSSTAB('
			  SELECT tiposangre, EXTRACT(YEAR FROM fechaingreso) ano, COUNT (*) total
FROM paciente_ingreso INNER JOIN ingreso ON paciente_ingreso.id_ingreso=ingreso.id_ingreso
    INNER JOIN paciente ON paciente_ingreso.id_paciente=paciente.id_paciente INNER JOIN ctiposangre 
	ON ctiposangre.id_tiposangre = paciente.id_tiposangre
GROUP BY tiposangre, EXTRACT(YEAR FROM fechaingreso)
ORDER BY 1,2', 
			  'SELECT DISTINCT EXTRACT(YEAR FROM fechaingreso) ano
FROM ingreso
ORDER BY ano ;') AS resultado (otipo varchar(3) , o2001 BIGINT , o2003 BIGINT , o2006 BIGINT , o2007 BIGINT , o2008 BIGINT, o2010 BIGINT , o2011 BIGINT
    ,o2012 BIGINT, o2013 BIGINT , o2015 BIGINT ,     o2017 BIGINT, o2018 BIGINT , o2019 BIGINT);

--Medicamentos vendidos por tipo de medicamento y año

SELECT *
FROM CROSSTAB('
			  SELECT medicamento, EXTRACT (YEAR FROM fecha ) ano , COUNT (*) total
FROM medicamento_venta INNER JOIN medicamento ON medicamento_venta.id_medicamento = medicamento.id_medicamento
INNER JOIN venta ON medicamento_venta.id_venta = venta.id_venta
GROUP BY medicamento,EXTRACT (YEAR FROM fecha )
ORDER BY 1,2
			  ', '
			  SELECT DISTINCT EXTRACT (YEAR FROM fecha ) ano
			  FROM venta
			  ORDER BY ano;') AS resultado(otipo TEXT , o2000 BIGINT , o2001 BIGINT ,o2003 BIGINT , o2004 BIGINT , 
										   o2005 BIGINT , o2006 BIGINT ,o2013 BIGINT , o2014 BIGINT , o2017 BIGINT , 
										   o2018 BIGINT , o2020 BIGINT , o2021 BIGINT, o2022 BIGINT);
										   
										   
/*
 3. Consultas con OVER()
*/

-- Nombre completo del especialista, ID del personal, cedula, sueldo individual, sueldo total y el ID del especialista

SELECT DISTINCT  T.*, id_especialista
FROM especialista JOIN (
    SELECT nombre, paterno, materno, id_personal, cedula, sueldo, SUM(sueldo) OVER() AS sueldo_total
    FROM personal
    JOIN persona ON personal.id_persona = persona.id_persona
    ) T ON T.id_personal = especialista.id_personal
ORDER BY id_especialista ASC;


-- Del personal se quiere su nombre completo, su ID, RFC, su cedula, el tipo de personal que representan, su sueldo y el sueldo en promedio que gana el personal

SELECT DISTINCT nombre, paterno, materno, T1.*
FROM persona
     JOIN(
         SELECT id_personal, rfc, cedula, tpersonal, sueldo, AVG(sueldo) OVER() AS promedio_sueldo
         FROM personal
             LEFT JOIN ctipopersonal ON personal.id_tipopersonal = ctipopersonal.id_tipopersonal)
         T1 ON T1.id_personal = persona.id_persona
ORDER BY id_personal ASC;



		
		
/*
 4. Realiza 2 consultas donde utilices el operador OVER (PARTITION BY).
*/

-- Promedio de costo en las ventas de cierto tipo de medicamentos del hospital

-- OBSERVACION: Observemos que no hay medicamentos que se repiten y por lo tanto los promedios no se separan
--              como en el ejemplo 5 de la Práctica 09, si tuviesemos medicamentos repetidos entonces si pasaría
--              lo del ejemplo, pero en la siguiente consulta a esta si se repiten datos.

SELECT id_venta,
       costo,
       fecha,
       medicamento,
       ROW_NUMBER() OVER (PARTITION BY medicamento.medicamento ORDER BY costo) AS medicamentos_tipo,
       AVG(venta.costo) OVER (PARTITION BY medicamento)
FROM venta
         JOIN medicamento ON venta.id_venta = medicamento.id_medicamento
ORDER BY fecha;

/*
ID de paciente, ID de persona, tipo de sangre, orden en que aparecen los tipos de sangre, y la cantiddad de veces
que aperece ese tipo de sangre
*/

SELECT id_paciente,
       id_persona,
       tiposangre,
       ROW_NUMBER() OVER (PARTITION BY tiposangre ORDER BY tiposangre) AS orden_tiposangre,
       COUNT(paciente.id_tiposangre) OVER (PARTITION BY tiposangre)
FROM paciente
         JOIN ctiposangre ON paciente.id_tiposangre = ctiposangre.id_tiposangre;
										
/*
  5. Consultas con OVER(ORDER BY)
*/


-- Nombre, ID de persona, ID de personal, sueldo y sueldo acumulado por orden de aparición de id_personal
SELECT nombre,paterno, personal.id_persona, id_personal,sueldo, SUM(sueldo) OVER (ORDER BY id_personal DESC)
FROM personal JOIN persona ON personal.id_persona = persona.id_persona;

-- ID de la venta, monto de la venta y monto acumulado de las ventas por orden de aparición de id_venta de
-- aquellas venta con un momto mayor a 500
SELECT id_venta, costo, AVG(costo) OVER (ORDER BY id_venta)
FROM venta
WHERE costo > 500;
