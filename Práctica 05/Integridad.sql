ALTER TABLE cestado
ADD CONSTRAINT pk_cestado PRIMARY KEY (id_estado);

ALTER TABLE cestado
ALTER COLUMN estado SET NOT NULL;

ALTER TABLE cmunicipio
ADD CONSTRAINT pk_cmunicipio PRIMARY KEY (id_municipio),
ADD FOREIGN KEY (id_estado) REFERENCES cestado(id_estado);

ALTER TABLE cmunicipio
ALTER COLUMN municipio SET NOT NULL,
ALTER COLUMN id_estado SET NOT NULL;

ALTER TABLE direccion
ADD CONSTRAINT pk_direccion PRIMARY KEY (id_direccion),
ADD FOREIGN KEY (id_municipio) REFERENCES cmunicipio(id_municipio);

ALTER TABLE direccion
ALTER COLUMN cpostal SET NOT NULL,
ALTER COLUMN calle SET NOT NULL,
ALTER COLUMN id_municipio SET NOT NULL;

ALTER TABLE cgenero
ADD CONSTRAINT pk_cgenero PRIMARY KEY (id_genero);

ALTER TABLE cgenero
ALTER COLUMN etiqueta SET NOT NULL;

ALTER TABLE persona
ADD CONSTRAINT pk_persona PRIMARY KEY (id_persona),
ADD FOREIGN KEY (id_genero) REFERENCES cgenero(id_genero),
ADD FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion);

ALTER TABLE persona
ALTER COLUMN nombre SET NOT NULL,
ALTER COLUMN paterno SET NOT NULL,
ALTER COLUMN nacimiento SET NOT NULL;

ALTER TABLE especialidad
ADD CONSTRAINT pk_especialidad PRIMARY KEY (id_especialidad);

ALTER TABLE especialidad
ALTER COLUMN especialidad SET NOT NULL;

ALTER TABLE ctipopersonal
ADD CONSTRAINT pk_ctipopersonal PRIMARY KEY (id_tipopersonal);

ALTER TABLE ctipopersonal
ALTER COLUMN tpersonal SET NOT NULL;

ALTER TABLE personal
ADD CONSTRAINT pk_personal PRIMARY KEY (id_personal),
ADD FOREIGN KEY (id_tipopersonal) REFERENCES ctipopersonal(id_tipopersonal),
ADD FOREIGN KEY (id_persona) REFERENCES persona(id_persona),
ADD CONSTRAINT u_personal UNIQUE (rfc,cedula),
ADD CHECK (sueldo > 0);

ALTER TABLE personal
ALTER COLUMN rfc SET NOT NULL,
ALTER COLUMN cedula SET NOT NULL,
ALTER COLUMN sueldo SET NOT NULL,
ALTER COLUMN id_tipopersonal SET NOT NULL,
ALTER COLUMN id_persona SET NOT NULL;

ALTER TABLE cuniversidad
ADD CONSTRAINT pk_cuniversidad PRIMARY KEY (id_universidad);

ALTER TABLE cuniversidad
ALTER COLUMN universidad SET NOT NULL;

ALTER TABLE especialista
ADD CONSTRAINT pk_especialista PRIMARY KEY (id_especialista),
ADD FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad),
ADD FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
ADD FOREIGN KEY (id_universidad) REFERENCES cuniversidad(id_universidad);

ALTER TABLE especialista
ALTER COLUMN id_especialidad SET NOT NULL,
ALTER COLUMN id_personal SET NOT NULL,
ALTER COLUMN id_universidad SET NOT NULL;

ALTER TABLE ctiposangre
ADD CONSTRAINT pk_tiposangre PRIMARY KEY (id_tiposangre);

ALTER TABLE ctiposangre
ALTER COLUMN tiposangre SET NOT NULL;

ALTER TABLE paciente
ADD CONSTRAINT pk_paciente PRIMARY KEY (id_paciente),
ADD FOREIGN KEY (id_tiposangre) REFERENCES ctiposangre(id_tiposangre),
ADD FOREIGN KEY (id_persona) REFERENCES persona(id_persona);

ALTER TABLE paciente
ALTER COLUMN id_persona SET NOT NULL;

ALTER TABLE calergia
ADD CONSTRAINT pk_alergia PRIMARY KEY (id_alergia);

ALTER TABLE calergia
ALTER COLUMN alergia SET NOT NULL;

ALTER TABLE calergia_paciente
ADD CONSTRAINT pk_calergia_paciente PRIMARY KEY (id_alergia_paciente),
ADD FOREIGN KEY (id_alergia) REFERENCES calergia(id_alergia),
ADD FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente);

ALTER TABLE calergia_paciente
ALTER COLUMN id_alergia SET NOT NULL,
ALTER COLUMN id_paciente SET NOT NULL;

ALTER TABLE medicamento
ADD CONSTRAINT pk_medicamento PRIMARY KEY (id_medicamento);

ALTER TABLE medicamento
ALTER COLUMN medicamento SET NOT NULL;

ALTER TABLE recetamedica
ADD CONSTRAINT pk_receta PRIMARY KEY (id_receta);

ALTER TABLE medicamento_receta
ADD CONSTRAINT pk_medicamento_receta PRIMARY KEY (id_medicamento_receta),
ADD FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento),
ADD FOREIGN KEY (id_receta) REFERENCES recetamedica(id_receta),
ADD CHECK (cantidad > 0);

ALTER TABLE medicamento_receta
ALTER COLUMN cantidad SET NOT NULL,
ALTER COLUMN id_medicamento SET NOT NULL,
ALTER COLUMN id_receta SET NOT NULL;

ALTER TABLE venta
ADD CONSTRAINT pk_venta PRIMARY KEY (id_venta);

ALTER TABLE venta
ALTER COLUMN costo SET NOT NULL,
ALTER COLUMN fecha SET NOT NULL,
ALTER COLUMN hora SET NOT NULL;

ALTER TABLE medicamento_venta
ADD CONSTRAINT pk_medicamento_venta PRIMARY KEY (id_medicamento_venta),
ADD FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento),
ADD FOREIGN KEY (id_venta) REFERENCES venta(id_venta);

ALTER TABLE medicamento_venta
ALTER COLUMN id_medicamento SET NOT NULL,
ALTER COLUMN id_venta SET NOT NULL;

ALTER TABLE almacen
ADD CONSTRAINT pk_almacen PRIMARY KEY (id_almacen);

ALTER TABLE almacen
ALTER COLUMN snombrealmacen SET NOT NULL;

ALTER TABLE venta_almacen
ADD CONSTRAINT pk_venta_almacen PRIMARY KEY (id_venta_almacen),
ADD FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
ADD FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen);

ALTER TABLE venta_almacen
ALTER COLUMN id_venta SET NOT NULL,
ALTER COLUMN id_almacen SET NOT NULL;

ALTER TABLE medicamento_almacen
ADD CONSTRAINT pk_medicamento_almacen PRIMARY KEY (id_medicamento_almacen),
ADD FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento),
ADD FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen),
ADD FOREIGN KEY (id_venta_almacen) REFERENCES venta_almacen(id_venta_almacen),
ADD CHECK (cantidad > 0);

ALTER TABLE medicamento_almacen
ALTER COLUMN cantidad SET NOT NULL,
ALTER COLUMN id_medicamento SET NOT NULL,
ALTER COLUMN id_almacen SET NOT NULL,
ALTER COLUMN id_venta_almacen SET NOT NULL;

ALTER TABLE venta_receta
ADD CONSTRAINT pk_venta_receta PRIMARY KEY (id_venta_receta),
ADD FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
ADD FOREIGN KEY (id_receta) REFERENCES recetamedica(id_receta);

ALTER TABLE venta_receta
ALTER COLUMN id_venta SET NOT NULL,
ALTER COLUMN id_receta SET NOT NULL;

ALTER TABLE personal_venta
ADD CONSTRAINT pk_personal_venta PRIMARY KEY (id_personal_venta),
ADD FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
ADD FOREIGN KEY (id_personal) REFERENCES personal(id_personal);

ALTER TABLE personal_venta
ALTER COLUMN id_venta SET NOT NULL,
ALTER COLUMN id_personal SET NOT NULL;

ALTER TABLE persona_venta
ADD CONSTRAINT pk_persona_venta PRIMARY KEY (id_persona_venta),
ADD FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
ADD FOREIGN KEY (id_persona) REFERENCES persona(id_persona);

ALTER TABLE persona_venta
ALTER COLUMN id_venta SET NOT NULL,
ALTER COLUMN id_persona SET NOT NULL;

ALTER TABLE alta
ADD CONSTRAINT pk_alta PRIMARY KEY (id_alta);

ALTER TABLE alta
ALTER COLUMN fechaegreso SET NOT NULL;

ALTER TABLE cmotivo
ADD CONSTRAINT pk_cmotivo PRIMARY KEY (id_motivo);

ALTER TABLE cmotivo
ALTER COLUMN motivo SET NOT NULL;

ALTER TABLE ingreso
ADD CONSTRAINT pk_ingreso PRIMARY KEY (id_ingreso),
ADD FOREIGN KEY (id_alta) REFERENCES alta(id_alta),
ADD CHECK (preciopd > 0);

ALTER TABLE ingreso
ALTER COLUMN fechaingreso SET NOT NULL,
ALTER COLUMN preciopd SET NOT NULL;

ALTER TABLE personal_ingreso
ADD CONSTRAINT pk_personal_ingreso PRIMARY KEY (id_personal_ingreso),
ADD FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
ADD FOREIGN KEY (id_ingreso) REFERENCES ingreso(id_ingreso);

ALTER TABLE personal_ingreso
ALTER COLUMN id_personal SET NOT NULL,
ALTER COLUMN id_ingreso SET NOT NULL;

ALTER TABLE paciente_ingreso
ADD CONSTRAINT pk_paciente_ingreso PRIMARY KEY (id_paciente_ingreso),
ADD FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
ADD FOREIGN KEY (id_ingreso) REFERENCES ingreso(id_ingreso);

ALTER TABLE paciente_ingreso
ALTER COLUMN id_paciente SET NOT NULL,
ALTER COLUMN id_ingreso SET NOT NULL;

ALTER TABLE ingreso_motivo
ADD CONSTRAINT pk_ingreso_motivo PRIMARY KEY (id_ingreso_motivo),
ADD FOREIGN KEY (id_motivo) REFERENCES cmotivo(id_motivo),
ADD FOREIGN KEY (id_ingreso) REFERENCES ingreso(id_ingreso);

ALTER TABLE ingreso_motivo
ALTER COLUMN id_motivo SET NOT NULL,
ALTER COLUMN id_ingreso SET NOT NULL;

ALTER TABLE ccama
ADD CONSTRAINT pk_ccama PRIMARY KEY (id_cama);

ALTER TABLE ccama
ALTER COLUMN numcama SET NOT NULL,
ALTER COLUMN tipocama SET NOT NULL;

ALTER TABLE ingreso_ccama
ADD CONSTRAINT pk_ingreso_ccama PRIMARY KEY (id_ingreso_cama),
ADD FOREIGN KEY (id_cama) REFERENCES ccama(id_cama),
ADD FOREIGN KEY (id_ingreso) REFERENCES ingreso(id_ingreso);

ALTER TABLE ingreso_ccama
ALTER COLUMN id_cama SET NOT NULL,
ALTER COLUMN id_ingreso SET NOT NULL;

ALTER TABLE chabitaciones
ADD CONSTRAINT pk_chabitaciones PRIMARY KEY (id_habitacion);

ALTER TABLE chabitaciones
ALTER COLUMN habitacion SET NOT NULL;

ALTER TABLE ingreso_chabitaciones
ADD CONSTRAINT pk_ingreso_chabitaciones PRIMARY KEY (id_ingreso_chabitaciones),
ADD FOREIGN KEY (id_habitacion) REFERENCES chabitaciones(id_habitacion),
ADD FOREIGN KEY (id_ingreso) REFERENCES ingreso(id_ingreso);

ALTER TABLE ingreso_chabitaciones
ALTER COLUMN id_habitacion SET NOT NULL,
ALTER COLUMN id_ingreso SET NOT NULL;

ALTER TABLE piso
ADD CONSTRAINT pk_piso PRIMARY KEY (id_piso);

ALTER TABLE piso
ALTER COLUMN npiso SET NOT NULL;

ALTER TABLE piso_habitacion
ADD CONSTRAINT pk_piso_habitacion PRIMARY KEY (id_pisohab),
ADD FOREIGN KEY (id_piso) REFERENCES piso(id_piso),
ADD FOREIGN KEY (id_habitacion) REFERENCES chabitaciones(id_habitacion);

ALTER TABLE piso_habitacion
ALTER COLUMN id_piso SET NOT NULL,
ALTER COLUMN id_habitacion SET NOT NULL;

ALTER TABLE consultorio
ADD CONSTRAINT pk_consultorio PRIMARY KEY (id_consultorio);

ALTER TABLE consultorio
ALTER COLUMN consultorio SET NOT NULL;

ALTER TABLE piso_consultorio
ADD CONSTRAINT pk_piso_consultorio PRIMARY KEY (id_pisoconsul),
ADD FOREIGN KEY (id_piso) REFERENCES piso(id_piso),
ADD FOREIGN KEY (id_consultorio) REFERENCES consultorio(id_consultorio);

ALTER TABLE piso_consultorio
ALTER COLUMN id_piso SET NOT NULL,
ALTER COLUMN id_consultorio SET NOT NULL;

ALTER TABLE consulta
ADD CONSTRAINT pk_consulta PRIMARY KEY (id_consulta),
ADD FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad),
ADD CHECK (precio > 0);

ALTER TABLE consulta
ALTER COLUMN fecha SET NOT NULL,
ALTER COLUMN precio SET NOT NULL,
ALTER COLUMN hora SET NOT NULL,
ALTER COLUMN id_especialidad SET NOT NULL;

ALTER TABLE consultorio_consulta
ADD CONSTRAINT pk_consultorio_consulta PRIMARY KEY (id_consultorio_consulta),
ADD FOREIGN KEY (id_consultorio) REFERENCES consultorio(id_consultorio),
ADD FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta);

ALTER TABLE consultorio_consulta
ALTER COLUMN id_consultorio SET NOT NULL,
ALTER COLUMN id_consulta SET NOT NULL;

ALTER TABLE consulta_paciente
ADD CONSTRAINT pk_consulta_paciente PRIMARY KEY (id_consulta_paciente),
ADD FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta),
ADD FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente);

ALTER TABLE consulta_paciente
ALTER COLUMN id_paciente SET NOT NULL,
ALTER COLUMN id_consulta SET NOT NULL;

ALTER TABLE consulta_personal
ADD CONSTRAINT pk_consulta_personal PRIMARY KEY (id_consulta_personal),
ADD FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta),
ADD FOREIGN KEY (id_personal) REFERENCES personal(id_personal);

ALTER TABLE consulta_personal
ALTER COLUMN id_consulta SET NOT NULL,
ALTER COLUMN id_personal SET NOT NULL;

ALTER TABLE receta_consulta
ADD CONSTRAINT pk_receta_consulta PRIMARY KEY (id_receta_consulta),
ADD FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta),
ADD FOREIGN KEY (id_receta) REFERENCES recetamedica(id_receta);

ALTER TABLE receta_consulta
ALTER COLUMN id_consulta SET NOT NULL,
ALTER COLUMN id_receta SET NOT NULL;
