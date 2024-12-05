// CARGAR tanto las Categoría(s) y Sede(s) para el filtrado.
async function cargarOpciones(){
    try{    
        const sedesRes = await fetch("http://localhost:3000/sedes/get/all");
        if(!sedesRes.ok){
            throw new Error(`Error en la respuesta de la API: ${sedesRes.status}`);
        }
        const sedes = await sedesRes.json();
        console.log(sedes); // Para verificar que los datos se han recibido correctamente

        const selectorSedes = document.getElementById('busquedaSede');
        const opcionInicialSede = document.createElement('option');
        opcionInicialSede.value = 0;
        opcionInicialSede.textContent = 'Todas';
        selectorSedes.appendChild(opcionInicialSede);

        sedes.forEach(sede => {
            const opcion = document.createElement('option');
            opcion.value = sede.IDSEDE;
            opcion.textContent = sede.NOMBRE;
            selectorSedes.appendChild(opcion);
        });

        const categoriaRes = await fetch('http://localhost:3000/categorias/get/all');
        if(!categoriaRes.ok){
            throw new Error(`Error en la respuesta de la API: ${categoriaRes.status}`)
        }
        const categorias = await categoriaRes.json();
        console.log(categorias); // Para verificar que los datos se han recibido correctamente
        const selectorCategorias = document.getElementById('busquedaCategoria');
        const opcionInicialCategoria = document.createElement('option');
        opcionInicialCategoria.value = 0;
        opcionInicialCategoria.textContent = 'Todas';
        selectorCategorias.appendChild(opcionInicialCategoria);
        
        categorias.forEach(categoria => {
            console.log("DEBUG: " + categoria);
            const opcion = document.createElement('option');
            opcion.value = categoria.IDCATEGORIA;
            opcion.textContent = categoria.NOMBRE;
            selectorCategorias.appendChild(opcion); 
        });

    } catch(err){
        console.error('No se pudo cargar las opciones:', err);
        alert('Ocurrió un error al cargar las opciones.');
    }
}

// FILTRAR por nombre.
document.getElementById('busquedaFormulario').addEventListener('submit', async function  (event) {
    event.preventDefault();
    const nombre = document.getElementById('buscar');
    await obtenerDatos(0,0,0,nombre.value);
});

// FILTRAR por Sede, Precio y Categoria.
document.getElementById('busquedaAvanzada').addEventListener('submit', async function (event) {
    event.preventDefault(); 

    const valorSede = document.getElementById('busquedaSede').value;
    const precio = document.getElementById('resultadoPrecio').value;
    const categoria = document.getElementById('busquedaCategoria').value;
    console.log(valorSede)
    console.log(precio)
    console.log(categoria)

    await obtenerDatos(valorSede,precio,categoria,'');
});

// FILTRAR - Búsqueda Avanzanda
async function obtenerDatos(sede, precio, categoria, nombre) {
    try {
        let respuesta = `http://localhost:3000/existencias/get/web/all?`;
        if(sede != 0){
            respuesta += `idSede=${sede}&`;
        }
        if(precio != 0){
            respuesta += `precio=${precio}&`;
        }
        if(categoria !=0 ){
            respuesta += `idCategoria=${categoria}&`;
        }
        if(nombre != ''){
            respuesta += `nombre=${nombre}&`;

        }

        respuesta = await fetch(respuesta);

        if (!respuesta.ok) {
            throw new Error(`Error en la respuesta de la API: ${respuesta.status}`);
        }

        const datos = await respuesta.json();

        const contenedor = document.querySelector('main');
        const plantilla = document.querySelector('template');

        // Validar que el contenedor y el template existen
        if (!contenedor) throw new Error('No se encontró el contenedor principal.');
        if (!plantilla || !plantilla.content) throw new Error('No se encontró el template.');

        // Elimina solo las tarjetas de producto, preservando el <template>
        const productosActuales = contenedor.querySelectorAll('.product-card');
        productosActuales.forEach(producto => producto.remove());

        // Generar tarjetas de productos
        datos.forEach(item => {
            console.log(item.PATH_IMAGEN);
            const tarjeta = document.importNode(plantilla.content, true);
            const img = tarjeta.querySelector('.product-image');
            img.src = `http://localhost:3000/imagen?path=${item.PATH_IMAGEN}`;
            img.onerror = () => {
                img.src = 'imagenes/placeholder-image.svg';
            };
            tarjeta.querySelector('.product-titulo').textContent = item.NOMBRE || 'Producto sin nombre';
            tarjeta.querySelector('.product-descripcion').textContent = item.DESCRIPCION || 'Sin descripción';
            tarjeta.querySelector('.product-cantidad').textContent = (item.CANTIDAD || 0) + ' Units.';
            tarjeta.querySelector('.product-precio').textContent = 'S/. ' + (item.PRECIO || '0.00');
            contenedor.appendChild(tarjeta);
        });
    } catch (err) {
        console.error('No se pudo completar el Fetch:', err);
        alert('Ocurrió un error al obtener los datos. Por favor, inténtalo más tarde.');
    }
}
cargarOpciones();
obtenerDatos(0,0,0);
