const express = require('express');
const bcrypt = require('bcryptjs');  // Para encriptar contraseñas
const bodyParser = require('body-parser');
const oracledb = require('oracledb');  // Conexión con Oracle
const path = require('path'); // Para el manejo de directorios
const cors = require('cors');
const multer = require('multer');
const { accessSync } = require('fs');

const app = express();
app.use(cors());

//TODO: Al final cambiar todo por procedimientos almacenados.

// ########## SUBIDA DE IMÁGENES ##########

app.use(bodyParser.json());  // Para procesar JSON(s)

async function connect(){
    return oracledb.getConnection({
        user: "USUARIO_MARCO", // Cambiar según convenga.
        password: "XmvH24H@#3451w#",
        connectionString: "localhost:1521/xe" 
    });
}

//CONFIGURAR ESPACIO EN EL QUE MULTER GUARDA LA IMAGEN.
const storage = multer.diskStorage({
    destination: (_req, _file, cb) => {
        cb(null, 'images'); // Carpeta donde se guardarán las imágenes.
    },
    filename: (_req, file, cb) => {
        const uniqueSuffix = Date.now() + '_' + Math.round(Math.random() * 1E9);
        const extension = path.extname(file.originalname);
        cb(null, file.fieldname + '_' + uniqueSuffix + extension); // Nombre único.
    },
});

const upload = multer({ storage });

//SUBIR: Imagen
app.post('/upload', upload.single('image'), (req, res) => {
    res.json({
        message: 'Imagen subida exitosamente',
        filename: req.file.filename
    });
});

// TESTING - Visualizar imágenes.
app.get('/imagen', (req, res) => {

    const { name } = req.query;
    // DEVOLVER la imagen solicitada.
    try {
        const imagePath = path.join(__dirname, 'images/' + name);
        res.sendFile(imagePath);
    } catch (error) {
        res.status(404).send("No se encontró la imagen en el servidor.");
    }
});

// ########## USUARIOS ##########

//CREATE: Usuario
app.post('/usuarios/crud/add', async (req, res) => {
    const { idCargo, idSede, nombre, apellido, email, password } = req.body;

    const conexion = await connect();

    try {
        // Encriptar contraseña antes de guardarla
        const hashedPassword = await bcrypt.hash(password, 10);

        await conexion.execute(
            `INSERT INTO Usuarios (idCargo, idSede, nombre, apellido, email, pass) VALUES (:idCargo, :idSede, :nombre, :apellido, :email, :password)`,
            { idCargo: idCargo, idSede: idSede, nombre: nombre, apellido: apellido, email: email, password: hashedPassword }
        );

        await conexion.commit();
        
        res.status(201).send('Usuario registrado');
    } catch (err) {
        console.error(err);
        res.status(500).send('Error al registrar el usuario');
    } finally {
        conexion.close();
    }
});

//READ: Usuarios (Testing)
app.get('/usuarios/get/all', async (req, res) =>{
    
    const conexion = await connect();
    
    try {    
        const response = await conexion.execute(
            'SELECT * FROM Usuarios',
            [],
            { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
    
        res.json(response.rows)
    } catch (err) {
        console.error(err);
        res.status(500).send('Error al consultar: TODOS LOS USUARIOS');
    } finally {
        conexion.close();
    }
});

//VALIDAR: Usuario. (Login)
app.get('/usuarios/valid/email', async (req, res) =>{
    // SOLICITAR en la URL los siguientes datos.
    const { email, password } = req.query;
    // CONECTAR a la base de datos.
    const conexion = await connect();

    try {   
        // VALIDAR existencia del email en la BD. -> Responde con la contraseña hasheada si existe.
        const emailResponse = await conexion.execute(
            'SELECT idUsuario,idCargo,idSede,pass FROM Usuarios WHERE email = :email',
            { email: email },
            { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );

        // DEVOLVER: Si no se halló fila con el Email.
        if (emailResponse.rows == 0){
            res.status(404).send("No se encontró registro de este email en la BD.");
            return
        }

        // VALIDAR si la CONTRASEÑA pertenece al usuario.
        const DBPassword = emailResponse.rows[0].PASS;

        bcrypt.compare(password, DBPassword, (err, isMatch) => {
            // DEVOLVER si hay un error.
            if (err) {
                res.status(500).send("Error al comparar contraseñas.");
                return
            }

            // ¿Coinciden?
            if (isMatch) {
                // DEVOLVER Id si todo es correcto
                res.status(200).json({
                    IDUSUARIO: emailResponse.rows[0].IDUSUARIO,
                    IDCARGO: emailResponse.rows[0].IDCARGO,
                    IDSEDE: emailResponse.rows[0].IDSEDE
                });
            }else{
                // DEVOLVER si la contraseña no coincide.
                res.status(401).send("Contraseña no coincide con el email.");
            }
        });
    } catch (error) {
        console.log(error);
        res.status(500).send("Algo falló al consultar usuario.")
    } finally {
        await conexion.close();
    }
});

// ########## CLIENTES ##########

//CREATE: Cliente
app.post('/clientes/crud/add', async (req, res) => {
    const conexion = await connect();
    const { dni, nombre, apellido, email } = req.body;

    try {
        await conexion.execute(
            'INSERT INTO Clientes(dni, nombre, apellido, email) VALUES (:dni, :nombre, :apellido, :email)',
            { dni: dni, nombre: nombre, apellido: apellido, email: email }
        );

        await conexion.commit();
        
        res.status(201).send("Clientes creado con éxito.");
    } catch (error) {
        
    } finally {
        await conexion.close();
    }

});

// ########## PRODUCTOS ##########

//CREATE: Producto
app.post('/productos/crud/add', async (req, res) => {
    const { idCategoria,nombre,descripcion,path_imagen } = req.body;
    const conexion = await connect();

    try {
        await conexion.execute(
            'INSERT INTO Productos(idCategoria,nombre,descripcion,path_imagen) VALUES (:idCategoria,:nombre,:descripcion,:path_imagen)',
            { idCategoria: idCategoria, nombre: nombre, descripcion: descripcion, path_imagen: path_imagen }
        );

        await conexion.commit();

        res.status(201).send('Producto registrado');
    } catch (error) {
        console.log(error);
    } finally {
        conexion.close();
    }
});

//READ: Productos (App)
app.get('/productos/get/all', async (req, res) => {

    const conexion = await connect();

    try{
        const response = await conexion.execute(
            'SELECT p.idProducto, p.idCategoria, p.nombre, p.descripcion FROM Productos p ORDER BY p.nombre',
            {},
            { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );

        // DEVOLVER si no se encuentran registros.
        if (response.rows.length == 0){
            res.status(404).send("¡No se encontraron productos!");
        } else {
            // DEVOLVER json.
            res.json(response.rows);
        }
    } catch (err) {
        console.error(err);
        res.status(500).send('Error al consultar: Productos');
    } finally {
        conexion.close();
    }
});

//READ: Productos - Only Name (App)
app.get('/productos/get/names', async (req, res) => {
    
    const { name } = req.query;
    const conexion = await connect();

    let sql;

    sql = (name)
    ? 'SELECT p.nombre FROM Productos p WHERE p.nombre LIKE :name ORDER BY p.nombre FETCH FIRST 10 ROWS ONLY'
    : 'SELECT p.nombre FROM Productos p ORDER BY p.nombre FETCH FIRST 10 ROWS ONLY';

    try {
        const response = await conexion.execute(
            sql,
            name ? { name: `${name}%`} : {},
            { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );

        // DEVOLVER si no se encuentran registros.
        if (response.rows == 0){
            res.status(404).send("¡No se encontraron nombres productos!");
        } else {
            // DEVOLVER json.
            res.json(response.rows);
        }
    } catch (err) {
        res.status(500).send("¡ERROR! Al consultar nombres de productos: " + err);
    } finally {
        conexion.close();
    }
});

//READ: Producto (Name)
app.get('/productos/get/id', async (req, res) => {
    
    const { nombre } = req.query;
    const conexion = await connect();

    try {
        const response = await conexion.execute(
            'SELECT idProducto FROM Productos WHERE nombre=:nombre',
            { nombre: nombre },
            { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );

        //DEVOLVER si no se encuentra nombre de producto con este ID.
        if (response.rows.length == 0) return res.status(404).send("No se encontró producto con este ID.");
        
        res.json(response.rows);
    } catch (err) {
        console.log("Error al consultar nombre de producto por nombre: " + err);
        res.status(500).send("Error interno del servidor.");
    } finally {
        conexion.close();
    }
});

// ########## EXISTENCIAS ##########

//READ: Existencias (App) => CONSULTA EXISTENCIAS SEGÚN LA SEDE.
app.get('/existencias/get/all', async (req, res) =>{
    const conexion = await connect();
    
    try {
        const { idSede } = req.query;
        
        const response = await conexion.execute(
            'SELECT p.idproducto,p.nombre,e.fecha_registro,e.precio,e.cantidad FROM Existencias e INNER JOIN Productos p ON e.idproducto = p.idproducto WHERE e.idsede = :idSede ORDER BY p.nombre',
            { idSede: idSede },
            { outFormat: oracledb.OUT_FORMAT_OBJECT}
        );

        if (response.rows == 0) {
            res.status(404).send("No se encontró la Sede.");
            return
        }

        res.json(response.rows)
    } catch (err) {
        console.error(err);
        res.status(500).send('Error al consultar: Existencias');
    } finally {
        conexion.close();
    }
});

//READ: Existencias (Web)
app.get('/existencias/get/web/all', async (req, res) => {
    const { idSede, precio,idCategoria, nombre} = req.query;
    const conexion = await connect();
    try {
        let query = ` SELECT p.path_imagen, p.nombre, p.descripcion, e.precio, e.cantidad FROM Productos p
         INNER JOIN Existencias e ON p.idProducto = e.idProducto
                    WHERE 1=1 `;
        const params = {};
        if(idSede){
            query += ' AND e.idSede =: idSede ';
            params.idSede = idSede;
        }
        if(precio){
            query += ' AND e.precio <=: precio ';
            params.precio = precio;
        }
        if(idCategoria){
            query += ' AND p.idcategoria =: idCategoria ';
            params.idCategoria = idCategoria;
        }
        if(nombre && nombre !=='undefined'){
            query += ' AND LOWER(p.nombre) LIKE :nombre ';
            params.nombre = `%${nombre.toLowerCase()}%`;
        }
        query +=  ' ORDER BY p.nombre ';
        const response = await conexion.execute(
            query,
            params,
            {outFormat: oracledb.OUT_FORMAT_OBJECT}
        );
        res.json(response.rows)
    } catch (error) {
        console.log(error);
        res.status(501).send("Algo falló al consultar productos.");
    }
});

//CREATE: Existencia
app.post('/existencias/crud/add', async (req, res) => {
    const conexion = await connect();
    const { idProducto, idSede, cantidad, precio, fecha_registro } = req.body;

    try {
        await conexion.execute(
            "INSERT INTO Existencias(idProducto, idSede,cantidad,precio,fecha_registro) VALUES (:idProducto, :idSede, :cantidad, :precio, TO_TIMESTAMP(:fecha_registro, 'YYYY-MM-DD HH24:MI:SS.FF'))",
            { idProducto: idProducto, idSede: idSede, cantidad: cantidad, precio: precio, fecha_registro: fecha_registro}
        );

        await conexion.commit();
        res.status(201).send("Existencia registrada.");
    } catch (err) {
        console.log(err);
        res.status(500).send("Algo falló al registrar Existencia");
    } finally {
        await conexion.close();
    }
});

//READ: Existencia - Details (Precio + Cantidad)
app.get('/existencias/get/details', async (req, res) => {
    const conexion = await connect();
    const { existenciaNombre, idSede } = req.query;
    
    try {
        const response = await conexion.execute(
            'SELECT e.cantidad, e.precio FROM Existencias e INNER JOIN Productos p ON e.idProducto=p.idProducto WHERE p.nombre=:nombre AND e.idSede=:idSede',
            { nombre: existenciaNombre, idSede: idSede },
            { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );

        if (response.rows.length == 0){
            return res.status(404).send("No se encontró existencia con estas características.");
        }

        res.json(response.rows);
    } catch (error) {
        console.log(error);
        res.status(500).send("Algo falló al consultar Existencia");
    } finally {
        await conexion.close();
    }
});

// ########## VENTAS ##########

//CREATE: Venta (1)
app.post('/ventas/crud/add', async (req, res) => {
    const conexion = await connect();
    const { idCliente, importeTotal, fecha } = req.body;

    try {
        await conexion.execute(
            'INSERT INTO Ventas(idCliente,importeTotal,fecha) VALUES (:idCliente, :importeTotal, :fecha)',
            { idCliente: idCliente, importeTotal: importeTotal, fecha: fecha }
        );

        await conexion.commit();

        res.status(201).send("Venta registrada.");
    } catch (error) {
        console.log(error);
        res.status(500).send("Algo falló al registrar Ventas");
    } finally {
        await conexion.close();
    }
});

//READ: Venta (Last-Venta-ID) (2)
app.get('/ventas/get/last-id', async (req, res) => {
    const conexion = await connect();
    const { idCliente } = req.query;

    try {
        const response = await conexion.execute(
            'SELECT Max(idVenta) as idVenta FROM Ventas WHERE idCliente=:idCliente',
            { idCliente: idCliente},
            { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );

        res.send(response.rows);
    } catch (error) {
        console.log(error);
        res.status(500).send("Algo falló al obtener el útimo id de la tabla Ventas.");
    }
});

// ########## DETALLE DE VENTAS ##########

//CREATE: Detalle Venta(s) (3)
app.post('/detalle-ventas/crud/add', async (req, res) => {
    const idVenta = req.query.idVenta; // ID de la venta en que se registrará.
    const productos = req.body; // Es un JSON con los productos.
    const conexion = await connect();

    try {
        await productos.forEach(producto => {
            conexion.execute(
                'INSERT INTO DetalleVentas(idExistencia, idVenta, cantidadVenta, precioVenta) VALUES (:idExistencia, :idVenta, :cantidadVenta, :precioVenta)',
                { idExistencia: producto["idExistencia"], idVenta: idVenta, cantidadVenta: producto["cantidadVenta"], precioVenta: producto["precioVenta"] }
            );
        });
        
        conexion.commit();

        res.status(201).send("Se agregaron Detalles de Ventas.");
    } catch (error) {
        console.log(error);
        res.status(500).send("Algo falló al registrar Detalle Ventas");
    } finally {
        await conexion.close();
    }
});

// ########## CATEGORIAS ##########

//READ: Categorias(s)
app.get('/categorias/get/all', async(req, res) => {
    const conexion = await connect();

    try {
        const response = await conexion.execute(
            'SELECT * FROM Categorias',
            {  },
            { outFormat: oracledb.OUT_FORMAT_OBJECT }
        );

        res.status(200).json(response.rows);
    } catch (error) {
        res.status(500).send("Algo falló al consultar: CATEGORIAS");
    }
});

// ########## SEDES ##########

//READ Sede(s)
app.get('/sedes/get/all', async(req,res) => {
    
    const conexion = await connect();
    
    try{
        const response = await conexion.execute(
            'SELECT * FROM Sedes',
            {},
            {outFormat: oracledb.OUT_FORMAT_OBJECT}
        );
        
        res.status(200).json(response.rows);
    }catch(error){
        res.status(500).send('Algo fallo al consultar: SEDES');
    } finally {
        conexion.close();
    }
});

//READ Cargo(s)

app.get('/cargos/get/all', async (req,res) => {

    const conexion = await connect();

    try{
        const response  = await conexion.execute(
            'SELECT * FROM Cargos',
            {},
            {outFormat: oracledb.OUT_FORMAT_OBJECT}
        );

        res.status(200).json(response.rows);
    }catch(error){ 
        res.status(500).send('falla en la consulta: CARGOS');
    } finally{
        conexion.close();
    }
});

//READ Sedes(s) Only Name
app.get('/sedes/get/names', async(req,res) => {
    
    const conexion = await connect();
    
    try{
        const response = await conexion.execute(
            'SELECT nombre FROM Sedes',
            {},
            {outFormat: oracledb.OUT_FORMAT_OBJECT}
        );
            
        res.status(200).json(response.rows);
    }catch(error){
        res.status(500).send('Algo fallo al consultar: SEDES - Nombres');
    }
});


// Iniciar el servidor en el puerto 3000
app.listen(3000, () => {
    console.log('Servidor ejecutándose en http://localhost:3000');
});
