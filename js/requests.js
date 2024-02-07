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
    request('matriculas');
  }
  
  function request(accion) {
    let url = './cgi-bin/aulaVirtual-priv.pl?query=' + accion;
    fetch(url)
      .then(response => response.json())
      .then(data => {
        showResult(data, accion);
      }).catch(error => {
        console.error('Error al realizar la solicitud:', error);
      });
  }
  
  function showResult(data, accion) {
    switch(accion) {
      case 'cursos' :
        console.log("Se pudos", data);
        resultCourse(data); break;
      case 'profesores' :
        resultTeachers(data); break;
      case 'usuario' :
        resultUser(data); break;
      case 'matriculas' :
        resultRegister(data); break;
      default:
        resultRegister(data); break;
    }
  }
  
  function resultCourse(data) {
    let courses = '';
    data.forEach(course => {
      courses += `
      <div class="cursos">
       <article class="curso">
        <div class="imagen">
         <img src="./img/slide1.jpg" alt="Descripción de la imagen" width="190px" height="250">
        </div>
        <div class="info-especial">
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
    // El id del div base sera courses, en este div base iran las tarjetas (cards)
    document.getElementById('courses').innerHTML = courses;
  }
  
  function resultTeachers(data) {
    let teachers = '';
    data.forEach(teacher => {
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
        </div>
      `;
    });
    // El id del div base sera courses, en este div base iran las tarjetas (cards)
    document.getElementById('courses').innerHTML = teachers;
  }
  
  function resultUser(data) {
    // Aun en implementacion
  }
  
  function resultRegister(data) {
    let registers = '';
    data.forEach(register => {
      registers += `
        <div class="card">
          <div class="img"></div>
          <p><strong>Id:</strong>${register.id_alumno}</p>
          <p><strong>Emision:</strong>${register.fecha_emision}</p>
          <p><strong>Vencimiento:</strong>${register.fecha_vencimiento}</p>
          <div class="information">
            <div>
              <p><strong>Curso:</strong> ${register.nombre_curso}</p>
            </div>
            <div>
              <p><strong>Costo:</strong> ${register.costo}</p>
            </div>
          </div>
        </div>
      `;
    });
    // El id del div base sera courses, en este div base iran las tarjetas (cards)
    document.getElementById('courses').innerHTML = registers;
  }
 
