#!/usr/bin/env ruby

require './config'
require './model'

IPhoneVoiceMemo.import!(ARGV[0], ARGV[1])