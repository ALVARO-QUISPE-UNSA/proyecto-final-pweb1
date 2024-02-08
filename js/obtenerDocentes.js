function getCursos() {
  let url = './cgi-bin/obtenerDocentes.pl';
  fetch(url)
    .then(response => response.json())
    .then(data => {
      console.log(data);
      render(data);
    })
    .catch(error => {
      console.error('Error al obtener los cursos:', error);
    });

}

function render(data) {
  let contenido = '';
  data.forEach((datos, index) =>{
    contenido += `
    <article id="calculo-1" class="teachers-card card card${index + 1}">
        <div class="card-content">
            <div class="title-card">
                <img src="img/image7.png">
                <h2>${datos.nombre} ${datos.apellido1} ${datos.apellido2}</h2>
            </div>
            <div class="info-card">
                <div>
                    <h3>Experiencia</h3>
                    <div class="info">
                        <h4>${datos.experiencia}</h4>
                    </div>
                </div>
                <div>
                    <h3>Cursos que enseña</h3>
                    <div class="info"> `
    datos.cursos_dictados.forEach(curso => {
      contenido += `
      <h4>${curso}</h4>
      `
    });
    contenido += `
                    </div>
                </div>
            </div>
        </div>

    </article>

    `
  });
  document.getElementById('tarjetas-docentes').innerHTML = contenido;
}

//Ejecución
getCursos();
