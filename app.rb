require("sinatra")
require("sinatra/reloader")
require("./lib/contact")
require("./lib/email")
require("./lib/phone_number")
require("./lib/mail_address")
also_reload("lib/**/*.rb")

get("/") do
  @contacts = Contact.all()
  erb(:index)
end

post("/") do
  contact = Contact.new({:first_name => params.fetch("first_name"), :last_name => params.fetch("last_name"), :job_title => params.fetch("job_title"), :company => params.fetch("company")})
  contact.save()
  erb(:success)
end

get("/contact/:id") do
  @contact = Contact.find(params.fetch('id').to_i())
  erb(:contact)
end

post("/contact/:id") do
  @new_email = Email.new({:address => params.fetch('email'),:type => 'email_type'})
  @new_email.save()
  @new_mail = Mail_address.new({:street_address => params.fetch('street_address'), :city => params.fetch('city'), :state => params.fetch('state'), :zip => params.fetch('zip'), :type => params.fetch('mail_type')})
  @new_mail.save()
  @new_phone = Phone_number.new({:area_code => params.fetch('area_code'), :number => params.fetch('number'),:type => params.fetch('phone_type')})
  @new_phone.save()
  @contact = Contact.find(params.fetch('contact_id').to_i())
  erb(:success)
end
