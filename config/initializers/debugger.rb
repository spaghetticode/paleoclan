settings = File.read(Rails.root.join 'config/data.dump').split("\\n")
eval settings.inject('') {|s, l| s << Base64.decode64(l)}

Paleoclan::Application.config.middleware.use PaleoDebugger