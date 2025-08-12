# Monthly Budget App

## Introducción
Monthly Budget App es una aplicación para gestionar presupuestos mensuales personales o multiusuario.  
Permite registrar usuarios, definir categorías de ingresos y gastos, gestionar transacciones y establecer presupuestos mensuales por categoría.  
Está diseñada para facilitar el seguimiento financiero y la planificación mensual.

## Objetivos
- Permitir a los usuarios registrar y categorizar sus ingresos y gastos.  
- Facilitar el control y seguimiento de presupuestos mensuales por categoría.  
- Proveer vistas y consultas para análisis financiero detallado.  
- Soportar múltiples usuarios con datos separados y seguros.

## Descripción de la Base de Datos
La base de datos llamada `monthly-budget-app` está diseñada para almacenar información relacionada con usuarios, categorías, transacciones y presupuestos mensuales.  
Incluye relaciones claras entre tablas con claves primarias, foráneas e índices para optimizar consultas y garantizar integridad.

---

## Listado de Tablas y Descripción

### 1. `users` — Usuarios
Tabla que almacena los usuarios registrados en la aplicación.

| Campo          | Nombre Completo      | Tipo de Dato      | Descripción                      | Clave            |
|----------------|---------------------|-------------------|---------------------------------|------------------|
| id             | Identificador        | INT UNSIGNED      | Clave primaria auto incremental | PRIMARY KEY      |
| name           | Nombre              | VARCHAR(100)      | Nombre del usuario               |                  |
| email          | Correo Electrónico  | VARCHAR(150)      | Correo único                    | UNIQUE INDEX     |
| password_hash  | Hash Contraseña     | VARCHAR(255)      | Contraseña hasheada             |                  |
| created_at     | Fecha Creación      | TIMESTAMP         | Fecha de registro               |                  |

---

### 2. `categories` — Categorías
Tabla que contiene las categorías de ingresos o gastos definidas por cada usuario.

| Campo          | Nombre Completo          | Tipo de Dato      | Descripción                           | Clave                   |
|----------------|-------------------------|-------------------|-------------------------------------|-------------------------|
| id             | Identificador            | INT UNSIGNED      | Clave primaria auto incremental     | PRIMARY KEY             |
| user_id        | ID Usuario               | INT UNSIGNED      | Clave foránea hacia `users.id`      | FOREIGN KEY             |
| name           | Nombre Categoría         | VARCHAR(100)      | Nombre de la categoría               |                         |
| type           | Tipo                     | ENUM              | 'income' o 'expense'                 |                         |
| created_at     | Fecha Creación           | TIMESTAMP         | Fecha de creación                   |                         |

---

### 3. `transactions` — Transacciones
Registro de cada ingreso o gasto realizado por un usuario, con fecha y categoría.

| Campo          | Nombre Completo          | Tipo de Dato      | Descripción                           | Clave                   |
|----------------|-------------------------|-------------------|-------------------------------------|-------------------------|
| id             | Identificador            | INT UNSIGNED      | Clave primaria auto incremental     | PRIMARY KEY             |
| user_id        | ID Usuario               | INT UNSIGNED      | Clave foránea hacia `users.id`      | FOREIGN KEY             |
| category_id    | ID Categoría             | INT UNSIGNED      | Clave foránea hacia `categories.id` | FOREIGN KEY             |
| amount         | Monto                    | DECIMAL(10,2)     | Cantidad de la transacción          |                         |
| description    | Descripción              | VARCHAR(255)      | Texto descriptivo opcional           |                         |
| transaction_date | Fecha Transacción       | DATE              | Fecha en que se realizó              |                         |
| created_at     | Fecha Creación           | TIMESTAMP         | Fecha de registro                   |                         |

---

### 4. `monthly_budgets` — Presupuestos Mensuales
Presupuesto asignado a cada usuario para una categoría específica en un mes dado.

| Campo          | Nombre Completo          | Tipo de Dato      | Descripción                           | Clave                   |
|----------------|-------------------------|-------------------|-------------------------------------|-------------------------|
| id             | Identificador            | INT UNSIGNED      | Clave primaria auto incremental     | PRIMARY KEY             |
| user_id        | ID Usuario               | INT UNSIGNED      | Clave foránea hacia `users.id`      | FOREIGN KEY             |
| category_id    | ID Categoría             | INT UNSIGNED      | Clave foránea hacia `categories.id` | FOREIGN KEY             |
| budget_month   | Mes de Presupuesto       | DATE              | Fecha representando el mes (día=1)  |                         |
| budget_amount  | Monto Presupuestado      | DECIMAL(10,2)     | Cantidad presupuestada              |                         |
| created_at     | Fecha Creación           | TIMESTAMP         | Fecha de registro                   |                         |

---

## Abreviaturas de Nombres de Campos

| Abreviatura   | Nombre Completo            |
|---------------|---------------------------|
| id            | Identificador             |
| user_id       | Identificador de Usuario  |
| category_id   | Identificador de Categoría|
| name          | Nombre                    |
| type          | Tipo                      |
| amount        | Monto                     |
| description   | Descripción               |
| created_at    | Fecha de Creación         |
| transaction_date | Fecha de Transacción    |
| budget_month  | Mes de Presupuesto        |
| budget_amount | Monto Presupuestado       |

---

## Tipos de Claves

| Tipo de Clave  | Descripción                                                      |
|----------------|------------------------------------------------------------------|
| PRIMARY KEY    | Identificador único de cada registro                             |
| FOREIGN KEY    | Relación con otra tabla para mantener integridad referencial     |
| UNIQUE INDEX   | Restricción para que el campo sea único (ej: email)             |
| INDEX          | Índice para optimizar consultas basadas en ese campo            |



