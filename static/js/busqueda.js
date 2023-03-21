
  function buscarEmp(){
    
    var filtro = $("#buscar").val().toUpperCase();
    
    $("#tabla td").each(function() {
      var textoEnTd = $(this).text().toUpperCase();
      if(textoEnTd.indexOf(filtro)>=0){
        $(this).addClass("existe");
      }else{
        $(this).removeClass("existe");
      }
    })
    
    $("#tabla tbody tr").each(function(){
      if($(this).children(".existe").length>0){
        $(this).show();
      }else{
        $(this).hide();
      }
    })
    
  }


  function buscarPed(){
    
    var filtro = $("#buscar2").val().toUpperCase();
    
    $("#tabla2 td").each(function() {
      var textoEnTd = $(this).text().toUpperCase();
      if(textoEnTd.indexOf(filtro)>=0){
        $(this).addClass("existe");
      }else{
        $(this).removeClass("existe");
      }
    })
    
    $("#tabla2 tbody tr").each(function(){
      if($(this).children(".existe").length>0){
        $(this).show();
      }else{
        $(this).hide();
      }
    })
    
  }