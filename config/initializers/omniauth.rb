#Rails.application.config.middleware.use OmniAuth::Builder do
## provider :developer unless Rails.env.production?
#  provider :facebook, '434277789963565' , '57f32627336bb116989ce62e0df0e759'
##:scope => 'email,user_birthday,read_stream', :display => 'popup'
#end


file_name = File.join(File.dirname(__FILE__), "..", "authentication_services.yml")
OMNIAUTH_KEYS = YAML.load(ERB.new(File.new(file_name).read).result)[Rails.env].freeze

Rails.application.config.middleware.use OmniAuth::Builder do
  OMNIAUTH_KEYS.each do |prov, config|
    provider prov, *config
  end
end

