function getCursos() {
  request('cursos');
}

function getTeachers() {
  request('profesores');
}

function getUser() {
  request('usuario');
}

function getRegister() {
  request('matricula');
}

function request(accion) {
  let url = '../cgi-bin/aulaVirtual-priv.pl?accion=' + accion; 
  fetch(url)
    .then(response => {
      response.json()
    }).then(data => {
      showResult(data, accion);
    }).catch(error => {
      console.error('Error al realizar la solicitud:', error);
    });
}

function showResult(data, accion) {
  switch(accion) {
    case 'course' :
      resultCourse(data); break;
    case 'profesores' :
      resultTeachers(data); break;
    case 'usuario' :
      resultUser(data); break;
    default
      resultRegister(data); break;
  }
}

function resultCourse(data) {
  let courses = '';
  data.forEach(course => {
    courses += `
      <div class="card">
        <div class="img"></div>
        <h2 class="name">${course.curso}</h2>
        <div class="information">
          <div>
            <p><strong>Profesor:</strong> ${course.profesor}</p>
          </div>
          <div>
            <p><strong>Aula:</strong> ${course.aula}</p>
            <p><strong>Hora de inicio:</strong> ${course.hora_inicio}</p>
            <p><strong>Hora de fin:</strong> ${course.hora_fin}</p>
          </div>
          <div>
            <p><strong>Fecha de inicio:</strong> ${course.fecha_inicio || 'No disponible'}</p>
            <p><strong>Fecha de fin:</strong> ${course.fecha_fin || 'No disponible'}</p>
          </div>
        </div>
      </div>
    `;
  });
}

function resultTeachers(data) {
  // Aun en implementacion
}

function resultUser(data) {
  // Aun en implementacion
}

function resultRegister(data) {
  // Aun en implementacion
}


