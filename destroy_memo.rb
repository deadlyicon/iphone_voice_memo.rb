#!/usr/bin/env ruby

require './config'
require './iphone_voice_memo'

IPhoneVoiceMemo.find_by_ZCUSTOMLABEL!(ARGV[0]).destroy