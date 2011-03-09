require 'github_cloner/github_helper'

class Cloner
	include Github
	
	def initialize(options)
		@github_uname = options[:username]
		@mode = options[:method]
		@path = options[:path]
		@timeout = options[:timeout]
		@repos = options[:repos]
	end
	
	def clone
		Github::get_repos(@github_uname, @mode, @timeout).each {|repo| system("git clone #{repo[:link]} #{@path}#{repo[:inactive]}/#{repo[:name]}") if @repos.include? repo[:name] or @repos.empty? }
	end
end

