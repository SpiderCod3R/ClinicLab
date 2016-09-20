jQuery ->
  $('.telefone_maskara').mask('(99) 9999-9999');
  $('.celular_maskara').mask('(99) 99999-9999');
  $('.cpf_maskara').mask ('999.999.999-99');
  $('.rg_maskara').mask ('99.999.999-9');
  $('.cnpj_maskara').mask('99.999.999/9999-99');
  $('.money_money_money').maskMoney({showSymbol:false, decimal:",", thousands:"."});
