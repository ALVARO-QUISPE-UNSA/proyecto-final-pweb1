function getCursos() {
  let url = './cgi-bin/cursos.pl';
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
    <article id="calculo-1" class="card card${index + 1}">
        <div class="card-content">
            <div class="title-card">
                <h2>${datos.nombre}</h2>
                <h3></h3>
            </div>
            <div class="info-card">
                <div>
                    <h3>Turnos</h3>
                    <div class="info">`
    datos.turnos.forEach(turno => {
      contenido += `
      <h4>Inicio: ${turno.hora_inicio} - Fin: ${turno.hora_fin}</h4>
      `
    });
    contenido += `
                    </div>
                </div>
                <div>
                    <h3>Materiales</h3>
                    <div class="info">`
    datos.materiales.forEach(material => {
      contenido += `
      <h4>${material}</h4>
      `
    });
    contenido += `
                    </div>
                </div>
                <div>
                    <h3>Profesores</h3>
                    <div class="info"> `
    datos.turnos.forEach(turno => {
      contenido += `
      <h4>${turno.profesor.nombre} ${turno.profesor.apellido1} ${turno.profesor.apellido2}</h4>
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
  document.getElementById('contenedor-tarjetas').innerHTML = contenido;
}

//Ejecución
getCursos();
