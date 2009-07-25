#!/usr/bin/env ruby

require './config'
require './model'

IPhoneVoiceMemo.find_by_ZCUSTOMLABEL!(ARGV[0]).destroy