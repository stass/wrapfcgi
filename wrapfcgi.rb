#!/usr/local/bin/ruby
#
# Copyright (C) 2008 Hosting Telesystems, JSC http://ht-systems.ru/
#
# Aurhor: Stanislav Sedov
#
# This file is in the public domain
#
# Run command as a FastCGI process
# Allows to use CGI programs in only FastCGI capable servers like nginx
#
#
require 'fcgi'
require 'open3'

if ARGV.size < 1 then
	STDERR.print "Usage: #{$0} cmd\n"
	exit 64
end

cmd = ARGV.shift
cmdargs = ARGV

FCGI.each do |request|

	saved_env = ENV.clone
	ENV.clear
	ENV.update(request.env)

	# Fork and run CGI process
	Open3.popen3(cmd, *cmdargs) do |stdin, stdout, stderr|
		stdin.write request.in.read
		request.out.write stdout.read
	end

	ENV.clear
	ENV.update(saved_env)

	request.finish
end
