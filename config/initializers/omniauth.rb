# Change this omniauth configuration to point to your registered provider
# Since this is a registered application, add the app id and secret here
APP_ID = 'YE0NYveQGoFsNLX220Dy5g' 
APP_SECRET = 'aqpGBedDnHFyp5MmgT8KErr9D015ScmaY8r3vHg5C0'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :josh_id, APP_ID, APP_SECRET
end
