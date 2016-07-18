$( ".fornecedor_cpf" ).hide();
$( ".fornecedor_cnpj" ).hide();

$( "#fornecedor_documento" ).change(function() {
    var value;
    value = $( "#fornecedor_documento" ).val();
    console.log(value);
    if(value == 1){
      $( ".fornecedor_cpf" ).fadeIn();;
      $( ".fornecedor_cnpj" ).hide();
    }else if(value == 2){
      $( ".fornecedor_cpf" ).hide();
      $( ".fornecedor_cnpj" ).fadeIn();;
    }
  })
