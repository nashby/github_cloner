require 'json'
require 'open-uri'
require 'time'

module Github	
	
	GITHUB_URL_API = 'http://github.com/api/v2/json/repos/show/'
	
	class << self
	
		def get_repos(username, mode, timeout)
			repos_json = JSON.parse(open(GITHUB_URL_API+username).read)
			repos = []
			repos_json['repositories'].each do |repo| 
				if timeout != "" && inactive?(repo, timeout) 
					repos << make_git_url(repo['name'], mode, username, "_inactive") 
				else
					repos << make_git_url(repo['name'], mode, username, "") 
				end
			end
			repos	
		end
		
		def make_git_url(repo_name, mode, username, inactive)
			case mode
				when 'ssh'
					{:link => "git@github.com:#{username}/#{repo_name}.git", :name => repo_name, :inactive => inactive}
				when 'http'
					{:link => "https://#{username}@github.com/#{username}/#{repo_name}.git", :name => repo_name, :inactive => inactive}
				when 'git'
					{:link => "git://github.com/#{username}/#{repo_name}.git", :name => repo_name, :inactive => inactive}
			end
		end	
		
		def inactive?(repo, timeout)
			if ((Time.now - Time.parse(repo["pushed_at"])).to_i / 86400) > timeout.to_i
				true
			else
				false
			end
		end
		
	end
	
end
