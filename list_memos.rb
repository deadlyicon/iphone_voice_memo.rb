#!/usr/bin/env ruby

require './config'
require './iphone_voice_memo'

IPhoneVoiceMemo.all.each do |r|
  puts "'#{r.read_attribute('ZCUSTOMLABEL')}' => '#{r.read_attribute('ZPATH')}'"
end