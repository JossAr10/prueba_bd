<h1>📘 <strong>Control de Versiones SQL – Estándar del Proyecto</strong></h1>

<p>Este documento define las reglas y buenas prácticas para manejar scripts SQL dentro del proyecto.<br>
El objetivo es garantizar orden, trazabilidad y consistencia entre todos los desarrolladores.</p>

<hr>

<h2>🚀 <strong>1. Prefijos estandarizados para commits</strong></h2>

<table border="1" cellpadding="8" cellspacing="0">
<thead>
<tr>
  <th><strong>Prefijo</strong></th>
  <th><strong>Uso recomendado</strong></th>
</tr>
</thead>
<tbody>
<tr>
  <td><strong>feat:</strong></td>
  <td>➕ Nuevas funciones SQL, nuevos scripts, nuevas consultas</td>
</tr>
<tr>
  <td><strong>fix:</strong></td>
  <td>🛠️ Corrección de lógica en funciones, validaciones, vistas o índices</td>
</tr>
<tr>
  <td><strong>chore:</strong></td>
  <td>🧹 Reestructurar carpetas, renombrar archivos, tareas no funcionales</td>
</tr>
<tr>
  <td><strong>refactor:</strong></td>
  <td>🔧 Cambios internos sin modificar comportamiento</td>
</tr>
<tr>
  <td><strong>docs:</strong></td>
  <td>📄 Documentación</td>
</tr>
<tr>
  <td><strong>sql:</strong></td>
  <td>🗄️ Cambios SQL generales</td>
</tr>
</tbody>
</table>

<p><strong>Ejemplo:</strong><br>
<code>feat: agregar validación de viaje mayor a 20 minutos</code></p>

<hr>

<h2>📂 <strong>2. Convención de nombres de archivos SQL</strong></h2>

<h3>🔁 <strong>Migraciones</strong></h3>
<p><code>YYYYMMDD_HHMM_orden_descriptivo.sql</code></p>

<p><strong>Ejemplos:</strong></p>
<ul>
  <li>20251120_1010_001_add_trip_validation.sql</li>
  <li>20251120_1030_002_add_index_rutascontrol.sql</li>
</ul>

<h3>🧠 <strong>Funciones</strong></h3>
<p><code>fn_nombre_v1.sql</code></p>
<p><strong>Ejemplo:</strong> fn_reconstruir_puntos_v4.sql</p>

<h3>👁️ <strong>Vistas</strong></h3>
<p><code>vw_nombre_v3.sql</code></p>

<hr>

<h2>📝 <strong>3. Plantilla para mensajes de commit</strong></h2>
<p><code>&lt;tipo&gt;: &lt;título corto&gt;</code></p>

<p>Descripción opcional del cambio.<br>
Incluye qué cambió y por qué.<br>
Si corresponde, referencia archivo SQL.</p>

<p><strong>Ejemplo aplicado a tu commit real:</strong></p>
<pre>
feat: agregar consultas de seguimiento de programaciones de viajes

Se agregan consultas para validar tiempos de inicio y fin, así como
restricciones adicionales para viajes mayores de 20 minutos.
Archivo: migrations/20251120_001_follow_trip.sql
</pre>

<hr>

<h2>🗂️ <strong>4. Estructura de carpetas recomendada</strong></h2>

<pre>
migrations/   # Cambios incrementales por fecha
functions/    # Funciones CREATE OR REPLACE con versiones
views/        # Vistas versionadas
ddl/          # Tablas, índices, constraints
dml/          # Datos base (si aplica)
queries/      # Consultas reutilizables por módulos (ej: rutas, eventos, vehículos)
</pre>

<hr>

<h2>🏁 <strong>5. Objetivo de este estándar</strong></h2>

<ul>
  <li>✔ Mantener orden en scripts SQL</li>
  <li>✔ Facilitar auditorías y revisiones</li>
  <li>✔ Permitir revertir o reproducir cambios fácilmente</li>
  <li>✔ Crear un historial limpio y profesional</li>
</ul>
