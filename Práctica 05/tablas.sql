CREATE TABLE cestado(
    id_estado                   SERIAL,
    estado                      VARCHAR(20)
);

CREATE TABLE cmunicipio(
    id_municipio                SERIAL,
    municipio                   VARCHAR(30),
    id_estado                   INTEGER
);

CREATE TABLE direccion(
    id_direccion                SERIAL,
    calle                       VARCHAR(30),
    cpostal                     VARCHAR(5),
    numerocalle                 INTEGER,
    id_municipio                INTEGER

);

CREATE TABLE cgenero(
    id_genero                   SERIAL,
    etiqueta                    VARCHAR(20)
);

CREATE TABLE persona(
    id_persona                  SERIAL,
    nombre                      VARCHAR(30),
    paterno                     VARCHAR(30),
    materno                     VARCHAR(30),
    correo                      VARCHAR(40),
    nacimiento                  DATE,
    telefono                    INTEGER,
    id_genero                   INTEGER,
    id_direccion                INTEGER
);

CREATE TABLE especialidad(
    id_especialidad             SERIAL,
    especialidad                VARCHAR(30)
);

CREATE TABLE ctipopersonal(
    id_tipopersonal             SERIAL,
    tpersonal                   VARCHAR(15)
);

CREATE TABLE personal(
    id_personal                 SERIAL,
    rfc                         VARCHAR(13),
    cedula                      VARCHAR(20),
    sueldo                      NUMERIC,
    id_persona                  INTEGER,
    id_tipopersonal             INTEGER

);

CREATE TABLE cuniversidad(
    id_universidad              SERIAL,
    universidad                 VARCHAR(40)

);

CREATE TABLE especialista(
    id_especialista             SERIAL,
    id_universidad              INTEGER,
    id_personal                 INTEGER,
	id_especialidad				INTEGER
);

CREATE TABLE ctiposangre(
    id_tiposangre               SERIAL,
    tiposangre                  VARCHAR(3)
);

CREATE TABLE paciente(
    id_paciente                 SERIAL,
    curp                        VARCHAR(18),
    id_persona                  INTEGER,
    id_tiposangre               INTEGER
);

CREATE TABLE calergia (
    id_alergia                  SERIAL,
    alergia                     VARCHAR(30)
);

CREATE TABLE calergia_paciente(
    id_alergia_paciente         SERIAL,
    id_alergia                  INTEGER,
    id_paciente                 INTEGER
);

CREATE TABLE medicamento(
    id_medicamento              SERIAL,
    medicamento                 VARCHAR(50)
);

CREATE TABLE recetamedica(
    id_receta                   SERIAL,
    tratamiento                 TEXT
);

CREATE TABLE medicamento_receta(
    id_medicamento_receta       SERIAL,
    id_medicamento              INTEGER,
    id_receta                   INTEGER,
    cantidad                    INTEGER
);

CREATE TABLE venta(
    id_venta                    SERIAL,
    fecha                       DATE,
    costo                       NUMERIC,
    hora                        TIME
);

CREATE TABLE medicamento_venta(
    id_medicamento_venta        SERIAL,
    id_medicamento              INTEGER,
    id_venta                    INTEGER
);

CREATE TABLE almacen(
    id_almacen                  SERIAL,
    snombrealmacen              VARCHAR(40)
);

CREATE TABLE venta_almacen(
    id_venta_almacen            SERIAL,
    id_venta                    INTEGER,
    id_almacen                  INTEGER
);

CREATE TABLE medicamento_almacen(
    id_medicamento_almacen      SERIAL,
    id_medicamento              INTEGER,
    id_almacen                  INTEGER,
    id_venta_almacen            INTEGER,
    cantidad                    INTEGER
);

CREATE TABLE venta_receta(
    id_venta_receta             SERIAL,
    id_venta                    INTEGER,
    id_receta                   INTEGER
);

CREATE TABLE personal_venta(
    id_personal_venta           SERIAL,
    id_personal                 INTEGER,
    id_venta                    INTEGER
);

CREATE TABLE persona_venta(
    id_persona_venta            SERIAL,
    id_persona                  INTEGER,
    id_venta                    INTEGER
);

CREATE TABLE alta(
    id_alta                     SERIAL,
    fechaegreso                 DATE
);

CREATE TABLE cmotivo(
    id_motivo                   SERIAL,
    motivo                      VARCHAR(50)
);

CREATE TABLE ingreso(
    id_ingreso                  SERIAL,
    fechaingreso                DATE,
    preciopd                    NUMERIC,
    diagnostico                 TEXT,
    id_alta                     INTEGER
);

CREATE TABLE personal_ingreso(
    id_personal_ingreso         SERIAL,
    id_personal                 INTEGER,
    id_ingreso                  INTEGER
);

CREATE TABLE paciente_ingreso(
    id_paciente_ingreso         SERIAL,
    id_paciente                 INTEGER,
    id_ingreso                  INTEGER
);

CREATE TABLE ingreso_motivo(
	id_ingreso_motivo SERIAL,
	id_ingreso INTEGER,
	id_motivo INTEGER
);

CREATE TABLE ccama(
    id_cama                     SERIAL,
    tipocama                    VARCHAR(10),
    numcama                     INTEGER
);

CREATE TABLE ingreso_ccama(
    id_ingreso_cama             SERIAL,
    id_ingreso                  INTEGER,
    id_cama                     INTEGER
);

CREATE TABLE chabitaciones(
    id_habitacion               SERIAL,
    habitacion                  INTEGER
);

CREATE TABLE ingreso_chabitaciones(
    id_ingreso_chabitaciones    SERIAL,
    id_ingreso                  INTEGER,
    id_habitacion               INTEGER
);

CREATE TABLE piso(
    id_piso                     SERIAL,
    npiso                       INTEGER
);

CREATE TABLE piso_habitacion(
    id_pisohab                  SERIAL,
    id_piso                     INTEGER,
    id_habitacion               INTEGER
);

CREATE TABLE consultorio(
    id_consultorio              SERIAL,
    consultorio                 INTEGER
);

CREATE TABLE piso_consultorio(
    id_pisoconsul               SERIAL,
    id_piso                     INTEGER,
    id_consultorio              INTEGER
);

CREATE TABLE consulta(
    id_consulta                 SERIAL,
    fecha                       DATE,
    diagnostico                 TEXT,
    precio                      NUMERIC,
    hora                        TIME,
    id_especialidad             INTEGER
);

CREATE TABLE consultorio_consulta(
    id_consultorio_consulta     SERIAL,
    id_consultorio              INTEGER,
    id_consulta                 INTEGER
);

CREATE TABLE consulta_paciente(
    id_consulta_paciente        SERIAL,
    id_consulta                 INTEGER,
    id_paciente                 INTEGER
);

CREATE TABLE consulta_personal(
    id_consulta_personal        SERIAL,
    id_consulta                 INTEGER,
    id_personal                 INTEGER
);

CREATE TABLE receta_consulta(
    id_receta_consulta          SERIAL,
    id_consulta                 INTEGER,
    id_receta                   INTEGER
);