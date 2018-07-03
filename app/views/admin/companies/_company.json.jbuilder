json.extract! company, :id, :email, :name, :company_address_line1, :company_address_line2, :company_country, :company_npa, :company_city, :reference_person_full_name, :vat_number, :ape, :siret, :created_at, :updated_at
json.url company_url(company, format: :json)
