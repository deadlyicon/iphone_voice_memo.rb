require './config'
require './iphone_voice_memo'

FILES = %(DJing.mp3
Series of tubes.mp3
are you feeling it wendal.mp3
dont fuck a goat.mp3
fail.mp3
).split("\n")


FILES.each do |file_name|
  file_path = File.join('~/Library/Sounds',file_name)
  new_file_path = file_path.gsub(/\.mp3$/,'.m4a')
  system("/opt/local/bin/ffmpeg -i '#{file_path}' '#{new_file_path}'")
  IPhoneVoiceMemo.import!(new_file_path, file_name)
end