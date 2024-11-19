async function obtenerDatos() {
    /*EL ID SEDE DETERMINA DESDE QUE EXISTENCIAS SE MUESTRA*/
    try {
        const respuesta = await fetch('http://localhost:3000/existencias/get/web/all?idSede=1');

        const datos = await respuesta.json();

        const contenedor = document.getElementsByTagName('main')[0];
        const plantilla = document.getElementsByTagName('template')[0].content;

        datos.forEach(item => {
            // Clona la plantilla
            const tarjeta = document.importNode(plantilla, true);

            // Asigna datos a los elementos de la tarjeta
            tarjeta.querySelector('.product-titulo').textContent = item.NOMBRE;
            tarjeta.querySelector('.product-descripcion').textContent = item.DESCRIPCION;
            tarjeta.querySelector('.product-cantidad').textContent = item.CANTIDAD + ' Units.';
            tarjeta.querySelector('.product-precio').textContent = 'S/. ' + item.PRECIO;

            // Añade la tarjeta clonada al contenedor
            contenedor.appendChild(tarjeta);
        });
    } catch (err) {
        console.log("No se pudo completar el Fetch:");
        console.log(err);
    }

}

obtenerDatos();
