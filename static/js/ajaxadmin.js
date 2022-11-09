$(function() {
    $('#cod_producto_consulta').keyup(function(e) {

            let buscar = $('#cod_producto_consulta').val();
            let action = 'consulta';
            $.ajax({
                url: 'ajaxadmin.php',
                type: 'POST',
                data: {accion2:action, buscar:buscar},
                success: function(response) {


                    if (response) {

                        let consul = JSON.parse(response);
                        let nombre = '';
                        let precio = '';
                        let cantidadp = '';

                        consul.forEach(lista => {
                            nombre += `${lista.Nombre_producto}`
                            precio += `${lista.Precio_producto}`
                            cantidadp += `${lista.Cantidad}`

                        });

                        $('#nombre_producto_resultado').html(nombre);
                        $('#precio_producto_resultado').html(precio);
                        $('#unidades_disponibles').html(cantidadp);
                        $('#cantidad_producto').removeAttr('disabled');
                        $('#btn_agregar').slideDown();

                    } else {
                        $('#btn_agregar').slideUp();
                    }

                }
            });

    });

    $('#cantidad_producto').keyup(function(e) {

        e.preventDefault();
        let precio_total = $(this).val() * $('#precio_producto_resultado').html();
        let disponible = parseInt($('#unidades_disponibles').html());
        $('#precio_total').html(precio_total);

        if (   ($(this).val() < 1 || isNaN($(this).val()))  ||  ($(this).val() > disponible)  ) {
            $('#btn_agregar').slideUp();
        } else {
            $('#btn_agregar').slideDown();
        }
        
    });

    $('#btn_agregar').click(function(e){
        e.preventDefault();

        var codproducto = $('#cod_producto_consulta').val();
        var nombre = $('#nombre_producto_resultado');
        var cantidad = $('#cantidad_producto').val();
        var preciop = $('#precio_producto_resultado');
        var subtotal = $('#precio_total').html();
        var action2 = 'AddProductoDetalle';

        $.ajax({
            url: 'ajaxadmin2.php',
            type: 'POST',
            async: true,
            data: {accion:action2, producto:codproducto, cantidad:cantidad, sub:subtotal, precio:preciop, nombre:nombre},

            success: function(response) {
                console.log(response);     
            }
        });


    });


});