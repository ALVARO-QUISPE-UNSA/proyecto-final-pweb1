function getName() {
  let url = 'cgi-bin/aulaVirtual-priv.pl?query=information';
  fetch(url)
    .then(response => response.json())
    .then(info => {
      let data = info[0];
      let name = `Bienvenido ${data.nombre}`;
      document.getElementById('user').innerHTML = name;
    }).catch(error => {
      console.error('Error al realizar la solicitud:', error);
    });
}
getName();

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
  document.getElementById('item').innerHTML = "Cursos";
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
  document.getElementById('item').innerHTML = "Profesores";
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
            <div class="info-slider-container">
      `;
    } else {
      information += `
        <div class="info-slider-content">
          <h5>${info.nombre_curso}</h5>
          <p><strong>Matrícula:</strong> <span>${info.id_matricula}</span></p>
          <p><strong>Emisión:</strong> <span>${info.fecha_emision}</span></p>
          <p><strong>Vencimiento:</strong> <span>${info.fecha_vencimiento}</span></p>
          <p><strong>Costo:</strong> <span>${info.costo}</span></p>
        </div>
      `;
    }
  });
  information += `
            </div>
          </div>
        </article>
  `;
  console.log(information);
  document.querySelector('main').innerHTML = information;
  document.getElementById('item').innerHTML = "Mis Datos";
}
 
