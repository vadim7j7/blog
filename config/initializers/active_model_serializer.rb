ActiveModel::Serializer.configure do |config|
  config.adapter = ActiveModelSerializers::Adapter::Json
  config.key_transform = :camel_lower
end
