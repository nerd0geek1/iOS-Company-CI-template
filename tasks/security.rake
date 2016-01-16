DEVELOPMENT_CERTIFICATE_FILE_PATH = ''
CERTIFICATE_FILE_PATH             = ''

DEVELOPMENT_CERTIFICATE_PASSWORD = ENV['DEVELOPMENT_CERTIFICATE_PASSWORD']
CERTIFICATE_PASSWORD             = ENV['CERTIFICATE_PASSWORD']

namespace :security do
  desc 'register certificates on Keychain'
  task :add_key do
    import_p12(DEVELOPMENT_CERTIFICATE_FILE_PATH, DEVELOPMENT_CERTIFICATE_PASSWORD)
    import_p12(CERTIFICATE_FILE_PATH, CERTIFICATE_PASSWORD)
  end

  def import_p12(file_path, password)
    cmd = "security import #{file_path}"
    cmd += ' -k login.keychain'
    cmd += " -P #{password}"
    cmd += ' -T /usr/bin/codesign'
    system cmd
  end
end
