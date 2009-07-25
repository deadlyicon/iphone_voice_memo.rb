#!/usr/bin/env ruby

require './config'
require './iphone_voice_memo'

IPhoneVoiceMemo.import!(ARGV[0], ARGV[1])