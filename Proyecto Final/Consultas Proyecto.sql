-- Consulta Básica
-- RFC y sueldo del personal que gana menos del promedio y cuyo RFC termina con un número

SELECT rfc, sueldo
FROM personal
WHERE sueldo < (SELECT AVG(sueldo)
    FROM personal)
AND rfc ~ '[1234567890]$';

-- Subconsulta
-- nombre,apellido paterno, identificador(id_personal),sexo, sueldo del personal con el mayor sueldo, solo se tomarán
-- aquellos que hayan hecho mas de 30 ventas, pero que alguna de estas venta sobrepase un costo de 2000

SELECT nombre,paterno, id_personal, etiqueta, sueldo
FROM personal
         JOIN persona ON personal.id_persona = persona.id_persona
         JOIN cgenero ON persona.id_genero = cgenero.id_genero
WHERE sueldo = (SELECT MAX(sueldo)
                FROM personal
                         JOIN (SELECT *
                               FROM (SELECT id_personal, COUNT(id_personal) noventas
                                     FROM personal_venta
                                              JOIN (SELECT *
                                                    FROM venta
                                                    WHERE costo > 2000) T1 ON personal_venta.id_venta = T1.id_venta
                                     GROUP BY id_personal) T2
                               WHERE noventas > 30) T3 ON personal.id_personal = T3.id_personal);

-- Compuesta
-- Consultas entre 2000 y 2005, fecha en la que se dieron y medicamentos que recetaron

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

-- Paginación
--Top 3 tipos de sangre más comunes entre los pacientes

WITH cte_topsangre AS (
    SELECT T1.tiposangre, personas, RANK() OVER(ORDER BY personas DESC) top
    FROM (SELECT ctiposangre.tiposangre, COUNT(paciente.id_paciente) personas
          FROM paciente
                   JOIN persona ON persona.id_persona = paciente.id_persona
                   JOIN ctiposangre ON ctiposangre.id_tiposangre = paciente.id_tiposangre
          GROUP BY ctiposangre.tiposangre) T1
    ORDER BY personas DESC)
SELECT tiposangre, personas
FROM cte_topsangre
WHERE top <= (SELECT top
              FROM cte_topsangre OFFSET (3-1) ROWS FETCH NEXT 1 ROW ONLY);

-- CROSSTAB
-- Cantidad de pacientes según el genero y el tipo de sangre que tengan
--Extension para usar crosstab
CREATE EXTENSION tablefunc;

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

--Consulta de ventana
--Sueldo por tipo de personal, sueldo total al personal del hospital y porcentaje que representa

SELECT DISTINCT tpersonal,
                "Sueldo por tpersonal",
                "Sueldo Total",
                CAST("Sueldo por tpersonal" * 100 AS DECIMAL) / ("Sueldo Total") AS "Porcentaje"
FROM personal
         JOIN
     (SELECT personal.id_personal,
             tpersonal,
             SUM(sueldo) OVER (PARTITION BY tpersonal) "Sueldo por tpersonal",
             "Sueldo Total"
      FROM personal
               JOIN
           ctipopersonal ON ctipopersonal.id_tipopersonal = personal.id_tipopersonal
               JOIN (SELECT personal.id_personal, SUM(sueldo) OVER () "Sueldo Total"
                     FROM personal
                              JOIN ctipopersonal ON ctipopersonal.id_tipopersonal = personal.id_tipopersonal) T1
                    ON T1.id_personal = personal.id_personal) T2
     ON T2.id_personal = personal.id_personal
ORDER BY tpersonal;

--Agrupacion

SELECT *, CAST("Sueldo por tpersonal" * 100 AS DECIMAL) / ("Sueldo Total") AS "Porcentaje"
FROM (SELECT tpersonal, "Sueldo por tpersonal", "Sueldo Total"
      FROM (SELECT tpersonal, SUM(sueldo) "Sueldo por tpersonal"
            FROM personal
                     JOIN ctipopersonal ON ctipopersonal.id_tipopersonal = personal.id_tipopersonal
            GROUP BY tpersonal) T1
               CROSS JOIN (SELECT SUM(sueldo) "Sueldo Total" FROM personal) T2) T3
ORDER BY tpersonal;
