BUILD_NUMBER           = ENV['CIRCLE_BUILD_NUM']
COMMIT_HASH            = ENV['CIRCLE_SHA1']
ARCHIVE_DIRECTORY      = ENV['CIRCLE_ARTIFACTS']

IPA_FILE_PATH           = ''
DSYM_FILE_PATH          = ''
RELEASE_NOTE_FILE_PATH  = ''
INFO_PLIST_FILE_PATH    = ''

namespace :build do
  desc 'prepare to build'
  task :prepare do
    increment_bundle_version
    generate_release_note_file
  end

  desc 'save generated files on CIRCLE_ARTIFACTS'
  task :save do
    save_file(IPA_FILE_PATH)
    save_file(DSYM_FILE_PATH)
    save_file(RELEASE_NOTE_FILE_PATH)
  end

  def save_file(src_path)
    cmd = 'mv'
    cmd += ' ' + src_path
    cmd += ' ' + ARCHIVE_DIRECTORY
    sh cmd
  end

  def generate_release_note_file
    release_note = "commit_hash:#{COMMIT_HASH}"
    File.write(RELEASE_NOTE_FILE_PATH, release_note)
  end

  def increment_bundle_version
    cmd = '/usr/bin/plutil'
    cmd += ' -replace CFBundleVersion -string ' + BUILD_NUMBER
    cmd += ' ' + INFO_PLIST_FILE_PATH
    sh cmd
  end
end
