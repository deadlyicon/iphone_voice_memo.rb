require 'rubygems'
require 'active_record'

# copy the entire Recordings dir from your iphone and then set the path to that dir
# to the IPHONE_VOICE_MEMO_RECORDINGS_DIR constnant before requireing this file
class IPhoneVoiceMemo < ActiveRecord::Base
  

  RECORDINGS_DIR = IPHONE_VOICE_MEMO_RECORDINGS_DIR
  raise "Recordings directory not found"  unless File.exists?(RECORDINGS_DIR)

  RECORDINGS_DB = File.join(RECORDINGS_DIR,'Recordings.db')
  raise "Recordings.db not found"  unless File.exists?(RECORDINGS_DB)
  
  establish_connection(:adapter => "sqlite3", :database => File.join(RECORDINGS_DB))
  
  set_table_name 'ZRECORDING'
  set_primary_key :Z_PK
  validates_uniqueness_of :ZPATH, :Z_PK, :ZCUSTOMLABEL
  attr_accessible :ZPATH, :ZCUSTOMLABEL, :file_name, :label

  def before_create
    # setting defaults
    attributes['Z_OPT'] = 2
    attributes['ZLABELPRESET'] = 7
    attributes['Z_ENT'] = 1
  end
  
  def file_name=(name)
    write_attribute('ZPATH', File.join('/var/mobile/Media/Recordings/',name))
  end
  
  def file=(file)
    file_name = File.basename(file)
  end
  
  def label=(label)
    write_attribute('ZCUSTOMLABEL', label)
  end
  
  def self.import!(file_path, label)
    raise "audio file not found '#{file_path}'"  unless file_path.is_a?(String) && File.exists?(file_path)
    file_name = File.basename(file_path)

    raise "label required"  unless label.is_a?(String) && label != ''

    puts "adding '#{label}':'#{file_name}'"

    dest_path = File.join(IPhoneVoiceMemo::RECORDINGS_DIR,file_name)
    copied = system("cp -vf '#{file_path}' '#{dest_path}'")
    raise "failed to copy audio file"  unless copied

    new_memo = IPhoneVoiceMemo.new :file_name => file_name, :label => label
    puts "SAVE: #{saved = new_memo.save}"
    puts "ERRORS: #{new_memo.errors.inspect}"  unless saved
  end
  
end