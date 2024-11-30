# Base de Datos de un Hospital :hospital:

## Proyecto que se llevo a cabo en la Universidad Nacional Autónoma de México

Cada práctica es un proceso en el cual se desarrollo la creación, desarollo y mantenimiento de la base de datos de un hospital, a continuación se muestran los pasos (las prácticas):

## NOTA IMPORTANTE: Para ver las imagenes completas favor de ingresar a las carpetas del GitHub ya que ahí se encuentra la información completa

## Práctica 1: Análisis de requerimientos

<img width="422" alt="BD_1" src="https://github.com/user-attachments/assets/46efd9c4-8ef2-4cbd-8b8d-4c4c84a2ff4b">

### Captura de requerimientos funcionales.
Los requerimientos funcionales son aquellas características o acciones que definen de manera única el flujo de trabajo de la organización.

### Captura de requerimientos no funcionales.
Los requerimientos no funcionales pueden ser clasificados en dos diferentes grupos:
- Requerimientos no funcionales asociados a requerimientos funcionales:
Son requerimientos o reglas de negocio (por ejemplo: políticas de la empresa) que definen cada acción del flujo de trabajo, es decir, características propias de cada requerimiento funcional. Por ejemplo: el requisito Orden, no puede tener a más de dos Telefonistas actuando a la vez para evitar duplicidad de órdenes o errores en la captura. Este es un ejemplo de límite de conexión de usuarios para el requerimiento Orden. Así mismo se pueden tener requerimientos de sostenibilidad, fiabilidad, tiempo de respuesta, rendimiento, extensibilidad, etc.
- Requerimientos no funcionales no asociados a requerimientos funcionales:
Estos requerimientos no dependen de alguna actividad específica del flujo de trabajo, es decir, que no detallan o describen el sistema. Sin embargo, son requerimientos que deben tomarse en cuenta para la implementación del nuevo sistema, como por ejemplo: que plataforma usar, los recursos con los que se cuentan, etc.

## Práctica 2: Modelado con Diagramas Entidad – Relación

El diagrama Entidad – Relación es una herramienta utilizada para modelar datos y sus relaciones de una manera ordenada, consiguiendo optimizar su posterior consulta, almacenaje, modificación, y de esta manera conseguir la información que la empresa necesita.

![image](https://github.com/user-attachments/assets/3b016165-4bcd-474e-90b4-e52c1746d925)

## Práctica 3: Modelado con Diagramas de Clases UML
El Lenguaje de Modelado Unificado (UML por sus siglas en inglés) es un lenguaje estandarizado de propósito general para el modelado de sistemas en Ingeniería de Software, en particular para el desarrollo de tecnología orientada a objetos. UML incluye un conjunto de notaciones gráficas para crear modelos visuales de sistemas orientadas a objetos.
Los diagramas de Clases UML ofrecen más información para la creación de la base de datos, como es el caso de los tipos de datos que delimitan el Dominio del atributo. Los tipos de datos varían de acuerdo con el Sistema Manejador de Bases de Datos (SMBD) utilizado.

<img width="295" alt="BD_2" src="https://github.com/user-attachments/assets/47d5dc09-c8d8-461a-b74f-ac165fd2fb10">

![image](https://github.com/user-attachments/assets/c4b950dc-4ff4-4a5d-93c2-dcce98b4fc85)

## Práctica 4: Normalización
Las bases de datos pueden modelarse a través de diversos diseños debido a la complejidad del contexto o a la experiencia del diseñador. Esto nos llevará a encontrar maneras distintas de ordenar los datos y las tablas que formarán parte de una base de datos.
El creador del modelo relacional, Edgar F. Codd, estableció una serie de reglas para las bases de datos con el propósito de que los modelos relacionales resultantes fueran eficientes. Estas reglas se ocupan de mantener la calidad organizacional de los datos y las tablas, mediante una estructura abstracta que se puede aplicar de manera universal a cualquier modelo relacional. A éstas reglas se les llama "Reglas de Codd"
A continuación se presentan las principales formas normales:
-  Primera Forma Normal: Todos los atributos deben ser atómicos.
-  Segunda Forma Normal: Todo atributo dependiente lo define el atributo determinante.
-  Tercera Forma Normal: No existen dependencias transitivas entre atributos dependientes.
-  Forma Normal Boyce-Codd: Todo determinante debe ser llave.

## Práctica 5: Creación de la base de datos de un hospital DDL e Integridad
En esta práctica se crearon las tablas anteriormente creadas en las prácticas anteriores y ya normalizadas. 

```sql
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
    telefono                    VARCHAR(10),
    id_genero                   INTEGER,
    id_direccion                INTEGER
);
```
entre demás tablas, nuevamente todas las tablas están en el archivo de práctica 5

```sql
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
```

## Práctica 6: Lenguaje de Manipulación de Datos (DML) 💻



