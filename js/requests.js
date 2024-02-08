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
        <article class="course-card card">
          <div class="img-card">
            <!-- Aquí deben colocar la imagen buscada con el nombre del id o del curso-->
            <img src="img/${course.id_curso}.jpg">
          </div>
          <div class="info-container">
            <div class="info-content">
              <p><strong>Aula:</strong> <span>${course.aula}</span></p>
              <p><strong>Profesor:</strong> <span>${course.profesor}</span></p>
            </div>
            <div class="info-content">
              <p><strong>Hora de inicio:</strong> <span>${course.hora_inicio}</span></p>
              <p><strong>Hora de fin:</strong> <span>${course.hora_fin}</span></p>
            </div>
            <div class="info-content">
              <p><strong>Fecha de inicio:</strong> <span>${course.fecha_inicio || 'No disponible'}</span></p>
              <p><strong>Fecha de fin:</strong> <span>${course.fecha_fin || 'No disponible'}</span></p>
              <p><strong>Duración:</strong> <span>${course.duracion} minutos </span></p>
            </div>
          </div>
        </article>
      `;
    });
    document.querySelector('main').innerHTML = courses;
  }

  function resultTeachers(info) {
    let teachers = '';
    info.forEach(teacher => {
      teachers += `
        <article class="teacher-card card">
          <div class="img-card">
            <!-- Aquí deben colocar la imagen buscada con el nombre del id o del profesor-->
            <img src="img/image7.png" alt="Descripción de la imagen">
          </div>
          <div class="info-container">
            <div class="info-content">
              <h2>${teacher.nombre} ${teacher.apellido1} ${teacher.apellido2}</h2>
            </div>
            <div class="info-content">
              <p><strong>Curso:</strong> <span>${teacher.curso}</span></p>
            </div>
            <div class="info-content">
              <p><strong>Experiencia:</strong> <span>${teacher.experiencia}</span></p>
              <p><strong>Teléfono:</strong> <span>${teacher.telefono}</span></p>
              <p><strong>Email:</strong> <span>${teacher.email}</span></p>
            </div>
          </div>
        </article>
      `;
    });
    // El id del div base sera courses, en este div base iran las tarjetas (cards)
    document.querySelector('main').innerHTML = teachers;
  }
  
  function resultRegister(data) {
    let registers = '';
    data.forEach(register => {
      registers += `
      `;
    });
    // El id del div base sera courses, en este div base iran las tarjetas (cards)
    document.querySelector('main').innerHTML = registers;
  }
function resultInformation(info) {
  let information = '';
  info.forEach((info, i) => {
    if(i === 0) {
      information += `
        <article class="personal-card card">
          <div class="img-card">
            <img src="img/image7.png" alt="Descripción de la imagen">
          </div>
          <div class="info-container">
            <div class="info-content">
              <h2>${info.nombre} ${info.apellido1} ${info.apellido2}</h2>
            </div>
            <div class="info-content">
              <p><strong>DNI:</strong> <span>${info.dni}</span></p>
              <p><strong>Teléfono:</strong> <span>${info.telefono}</span></p>
              <p><strong>Email:</strong> <span>${info.email}</span></p>
            </div>
      `;
    } 

    /*else {
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

            <div class="info-content">
              <p><strong>Matrícula:</strong> <span>${info.id_matricula}</span></p>
              <p><strong>Emisión:</strong> <span>${info.nombre_curso}</span></p>
            </div>
            <div class="info-content">
              <p><strong>Vencimiento:</strong> <span>${register.fecha_vencimiento}</span></p>
            </div>
          </div>
        </article>
      `;
    }*/
  });
  console.log(information);
  document.querySelector('main').innerHTML = information;
}
 
