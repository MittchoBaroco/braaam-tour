class AddNewAttributesToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :company_address_line1, :string
    add_column :companies, :company_address_line2, :string
    add_column :companies, :company_country, :string
    add_column :companies, :company_npa, :string
    add_column :companies, :company_city, :string
    add_column :companies, :reference_person_full_name, :string
  end
end
