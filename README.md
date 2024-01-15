# léeme
# Tablas
**infoCursos**: info genérica sirve de información al público
id, nombre, duración, matriculados
aab, Calculo, 2 meses, 30 alumnos
**InfoTemas**
tema n, id curso
tema n+1, curso m
**InfoMateriales**
material n, id curso m
material n+1, curso m
**InfoCursoProfesor**
id curso, id profesor
**InfoProfesores**
id, nombre, experiencia
**Users**
id | contraseña | email
**Alumnos**
id, nombre, apellido, edad, 
**Matriculados**
id relación, id alumno, id curso, id profesor
# Html
- index.html: Es la página de acceso.
- login.html: donde se registrarán
  - Se usará tabla **Users** para registrarse
  - ~~red~~: aulaVirtual.html
- courses.html: Se mostrarán **Tabla infoCursos**
- themes. html: Se monstrarán **Tabla: infoTemas** 
- teachers.html: Se mostrará: **Tabla: infoProfesores**
- aulaVirtual.html: Según datos del usuario
  - Según tabla **Alumnos**:
    se mostrará: nombre, apellido, edad
# cgi-bin
- cursos.pl: mostrar la información de cursos
- teachers.pl: mostrar infor de teacher


