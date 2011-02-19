require 'json'
require 'open-uri'

module Github	
	class Cloner
	
		GITHUB_URL_API = 'http://github.com/api/v2/json/repos/show/'
		
		def initialize(github_uname, mode, path)
			@github_uname = github_uname
			@mode = mode
			@path = path
		end

		def make_git_url(repo_name)
			case @mode
				when 'ssh'
					{:link => "git@github.com:#{@github_uname}/#{repo_name}.git", :name => repo_name}
				when 'http'
					{:link => "https://#{@github_uname}@github.com/#{@github_uname}/#{repo_name}.git", :name => repo_name}
				when 'git'
					{:link => "git://github.com/#{@github_uname}/#{repo_name}.git", :name => repo_name}
			end
		end
		
		def get_gits
			repos = JSON.parse(open(GITHUB_URL_API+@github_uname).read)
			gits = []
			repos['repositories'].each { |repo| gits << make_git_url(repo['name']) }
			gits
		end
		
		def clone
			get_gits.each {|repo| system("git clone #{repo[:link]} #{@path}/#{repo[:name]}")}
		end
	end
end
