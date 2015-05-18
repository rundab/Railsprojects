json.array!(@tenants) do |tenant|
  json.extract! tenant, :id, :name, :address, :city, :state, :zip, :note, :phone, :surcharge, :manager_id, :refnum, :suite, :email
  json.url tenant_url(tenant, format: :json)
end
