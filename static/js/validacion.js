const formulario = document.getElementById('formulario_producto');

const inputs = document.querySelectorAll('#formulario_producto input');


//Aqui me falta poner las expresiones



const expresiones = {
    producto : /^[a-zA-ZÀ-ÿ\s]{1,30}$/,
    marca : /^[a-zA-ZÀ-ÿ\s]{1,30}$/,//"expresiones marca",
    unidades : /^\d{1,14}$/,//"expresiones unidades",
    valor : /^\d{1,14}$/,//"expresiones valor",
    tamaño : /^[a-zA-ZÀ-ÿ\s]{1,30}$/,//"expresiones tamaño",
    proveedor : /^\d{1,14}$/,//"expresiones codigo proveedor"
}

//Aqui debe terminar las expresiones

const campos = {
    producto: false,
    marca: false,
    unidades: false,
    valor: false,
    tamaño: false,
    proveedor: false
}

const validarFormulario = (e) => {
    switch (e.target.name) {
        case "Nombre_producto":
            if (expresiones.producto.test(e.target.value)) {
                document.getElementById('grupo_producto').classList.remove('formulario_grupo-incorrecto');
                document.getElementById('grupo_producto').classList.add('formulario_grupo-correcto');
                document.querySelector('#grupo_producto .mensaje_input_error').classList.remove('mensaje_input_error-activo');
                campos['producto'] = true;
            } else {
                document.getElementById('grupo_producto').classList.add('formulario_grupo-incorrecto');
                document.querySelector('#grupo_producto .mensaje_input_error').classList.add('mensaje_input_error-activo');
                campos['producto'] = false;
            }
        break;
    
        case "Marca":
            if (expresiones.marca.test(e.target.value)) {
                document.getElementById('grupo_marca').classList.remove('formulario_grupo-incorrecto');
                document.getElementById('grupo_marca').classList.add('formulario_grupo-correcto');
                document.querySelector('#grupo_marca .mensaje_input_error').classList.remove('mensaje_input_error-activo');
                campos['marca'] = true;
            } else {
                document.getElementById('grupo_marca').classList.add('formulario_grupo-incorrecto');
                document.querySelector('#grupo_marca .mensaje_input_error').classList.add('mensaje_input_error-activo');
                campos['marca'] = false;
            }
        break;

        case "unidades":
            if (expresiones.unidades.test(e.target.value)) {
                document.getElementById('grupo_stock').classList.remove('formulario_grupo-incorrecto');
                document.getElementById('grupo_stock').classList.add('formulario_grupo-correcto');
                document.querySelector('#grupo_stock .mensaje_input_error').classList.remove('mensaje_input_error-activo');
                campos['unidades'] = true;
            } else {
                document.getElementById('grupo_stock').classList.add('formulario_grupo-incorrecto');
                document.querySelector('#grupo_stock .mensaje_input_error').classList.add('mensaje_input_error-activo');
                campos['unidades'] = false;
            }
        break;

        case "Valor":
            if (expresiones.valor.test(e.target.value)) {
                document.getElementById('grupo_precio').classList.remove('formulario_grupo-incorrecto');
                document.getElementById('grupo_precio').classList.add('formulario_grupo-correcto');
                document.querySelector('#grupo_precio .mensaje_input_error').classList.remove('mensaje_input_error-activo');
                campos['valor'] = true;
            } else {
                document.getElementById('grupo_precio').classList.add('formulario_grupo-incorrecto');
                document.querySelector('#grupo_precio .mensaje_input_error').classList.add('mensaje_input_error-activo');
                campos['valor'] = false;
            }
        break;

        case "Tamaño_producto":
            if (expresiones.tamaño.test(e.target.value)) {
                document.getElementById('grupo_contenido').classList.remove('formulario_grupo-incorrecto');
                document.getElementById('grupo_contenido').classList.add('formulario_grupo-correcto');
                document.querySelector('#grupo_contenido .mensaje_input_error').classList.remove('mensaje_input_error-activo');
                campos['tamaño'] = true;
            } else {
                document.getElementById('grupo_contenido').classList.add('formulario_grupo-incorrecto');
                document.querySelector('#grupo_contenido .mensaje_input_error').classList.add('mensaje_input_error-activo');
                campos['tamaño'] = false;
            }
        break;

        case "Codigo_proveedor":
            if (expresiones.proveedor.test(e.target.value)) {
                document.getElementById('grupo_proveedor').classList.remove('formulario_grupo-incorrecto');
                document.getElementById('grupo_proveedor').classList.add('formulario_grupo-correcto');
                document.querySelector('#grupo_proveedor .mensaje_input_error').classList.remove('mensaje_input_error-activo');
                campos['proveedor'] = true;
            } else {
                document.getElementById('grupo_proveedor').classList.add('formulario_grupo-incorrecto');
                document.querySelector('#grupo_proveedor .mensaje_input_error').classList.add('mensaje_input_error-activo');
                campos['proveedor'] = false;
            }
        break;

    } 
}

inputs.forEach((input) => {
    input.addEventListener('keyup', validarFormulario);
    input.addEventListener('blur', validarFormulario);
});

formulario.addEventListener('submit', (e) => {
    e.preventDefault();

    if (campos.producto && campos.marca && campos.unidades && campos.valor && campos.tamaño && campos.proveedor) {
        formulario.reset();

        document.getElementById('formulario_mensaje_exito').classList.add('formulario_mensaje_exito-activo');
        setTimeout(() => {
            document.getElementById('formulario_mensaje_exito').classList.remove('formulario_mensaje_exito-activo');
        }, 6000);

        document.querySelectorAll('formulario_grupo-correcto').forEach((icono) => {
            icono.classList.remove('formulario_grupo-correcto');
        });
    } else {
        document.getElementById('formulario_mensaje_error').classList.add('formulario_mensaje_error-activo');
    }
});