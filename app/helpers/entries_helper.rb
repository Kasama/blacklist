module EntriesHelper

  def format_as_cnpj(text)
    if text.length == 14
      cnpj_sliced = text.unpack('a2a3a3a4a2')
      cnpj_sliced[0] + '.' + cnpj_sliced[1] + '.' + cnpj_sliced[2] + '/' + cnpj_sliced[3] + '-' + cnpj_sliced[4]
    end
  end

  def format_as_cpf(text)
    if text.length == 11
      cpf_sliced = text.unpack('a3a3a3a2')
      cpf_sliced[0] + '.' + cpf_sliced[1] + '.' + cpf_sliced[2] + '-' + cpf_sliced[3]
    end
  end

end
