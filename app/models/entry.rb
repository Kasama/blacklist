class Entry < ActiveRecord::Base

  before_validation :numberalize_cnpj
  validates_presence_of :cnpj, on: :create
  validates_cpf_or_cnpj :cnpj, on: :create

  def self.search(query)
    entries = Array.new
    query.each do |s|
      entries.append where 'name LIKE ?', s
      entries.append where 'cnpj LIKE ?', s
      entries.append where 'description LIKE ?', s
    end
    puts entries
    if entries.any?
      entries
    else
      nil
    end
  end

  def numberalize_cnpj
    self.cnpj = cnpj.gsub /\D/, ''
  end

  private :numberalize_cnpj

end
