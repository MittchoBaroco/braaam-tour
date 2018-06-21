class AddContractFieldsToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :vat_number, :string
    add_column :companies, :ape, :string
    add_column :companies, :siret, :string
  end
end
