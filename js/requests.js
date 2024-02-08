function getCursos() {
  request('cursos');
}
  
function getTeachers() {
  request('profesores');
}
  
function getInformation() {
  request('information');
}
  
function request(accion) {
  let url = 'cgi-bin/aulaVirtual-priv.pl?query=' + accion;
  fetch(url)
    .then(response => response.json())
    .then(info => {
      showResult(info, accion);
    }).catch(error => {
      console.error('Error al realizar la solicitud:', error);
    });
}
  
function showResult(info, accion) {
  switch(accion) {
    case 'cursos' :
      resultCourse(info); break;
    case 'profesores' :
      resultTeachers(info); break;
    default :
      resultInformation(info); break;
  }
}
  
function resultCourse(info) {
  let courses = '';
  info.forEach(course => {
    courses += `
    <div class="cursos">
      <article class="curso">
        <div class="imagen">
          <img src="img/slide1.jpg" alt="Descripción de la imagen" width="190px" height="250">
        </div>
        <div class="info-especial">
          <div class="info-partida">
            <p><strong>${course.curso}</strong></p>
          </div>
          <div class="info-partida">
            <p><strong>Aula:</strong> ${course.aula}</p>
            <p><strong>Profesor:</strong> ${course.profesor}</p>
          </div>
          <div class="info-partida">
            <p><strong>Hora de inicio:</strong> ${course.hora_inicio}</p>
            <p><strong>Hora de fin:</strong> ${course.hora_fin}</p>
          </div>
          <div class="info-partida">
            <p><strong>Fecha de inicio:</strong> ${course.fecha_inicio || 'No disponible'}</p>
            <p><strong>Fecha de fin:</strong> ${course.fecha_fin || 'No disponible'}</p>
            <p><strong>Duración:</strong> ${course.duracion} minutos</p>
          </div>
        </div>
      </article>
    </div>
    `;
  });
  document.getElementById('data').innerHTML = courses;
}

function resultTeachers(info) {
  let teachers = '';
  info.forEach(teacher => {
    teachers += `
      <div class="card">
        <div class="img"></div>
          <h2 class="name">${teacher.nombre}</h2>
          <h2 class="apellido1">${teacher.apellido1}</h2>
          <h2 class="apellido2">${teacher.apellido2}</h2>
        <div class="information">
        <div>
          <p><strong>Curso:</strong> ${teacher.curso}</p>
        </div>
        <div>
          <p><strong>Experiencia:</strong> ${teacher.experiencia}</p>
          <p><strong>Telefono:</strong> ${teacher.telefono}</p>
          <p><strong>Email:</strong> ${teacher.email}</p>
        </div>
      </div>
    `;
  });
  document.getElementById('data').innerHTML = teachers;
}
  
function resultInformation(info) {
  let information = '';
  info.forEach((info, i) => {
    if(i === 0) {
      information += `
        <div class="card">
          <div>
            <p><strong>Alumno:</strong>${info.nombre} ${info.apellido1} ${info.apellido2}</p>
          </div>
          <div>
            <p><strong>Dni:</strong> ${info.dni}</p>
          </div>
          <div>
            <p><strong>Telefono:</strong> ${info.telefono}</p>
          </div>
          <div>
            <p><strong>Email:</strong> ${info.email}</p>
          </div>
        </div>
      `;
    } else {
      information += `
        <div class="card">
          <table>
            <tr>
              <th><strong>Matricula:</strong></th>
              <th><strong>Curso:</strong></th>
              <th><strong>Emisión:</strong></th>
              <th><strong>Vencimiento:</strong></th>
              <th><strong>Costo:</strong></th>
            </tr>
            <tr>
              <td>${info.id_matricula}</td>
              <td>${info.nombre_curso}</td>
              <td>${info.fecha_emision}</td>
              <td>${info.fecha_vencimiento}</td>
              <td>${info.costo}</td>
            </tr>
          </table>
        </div>
      `;
    }
  });
  console.log(information);
  document.getElementById('data').innerHTML = information;
}
