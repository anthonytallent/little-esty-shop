module ApplicationHelper
  # def format_time
  # end

  @user_names = nil

  # def get_names
  #   response = HTTParty.get("https://api.github.com/repos/anthonytallent/little-esty-shop/collaborators", headers: { 'User-Agent' => 'anthonytallent', 'Authorization' => "token #{Rails.application.credentials.config[:github]}"})
  #   parsed_json = JSON.parse(response.body, symbolize_names: true)
  #   @user_names = parsed_json.map do |user|
  #     user[:login] if user[:login]
  #     # binding.pry
  #     # user[:login]
  #   end
  # end

  # def repo_name
  #   response = HTTParty.get("https://api.github.com/repos/anthonytallent/little-esty-shop", headers: { 'User-Agent' => 'anthonytallent', 'Authorization' => "token #{Rails.application.credentials.config[:github]}"})
  #   parsed_json = JSON.parse(response.body, symbolize_names: true)
  #   parsed_json[:full_name]
  # end

  # def pull_request
  #   response = HTTParty.get("https://api.github.com/repos/anthonytallent/little-esty-shop/pulls?state=closed", headers: { 'User-Agent' => 'anthonytallent', 'Authorization' => "token #{Rails.application.credentials.config[:github]}"})
  #   parsed_json = JSON.parse(response.body, symbolize_names: true)
  #   parsed_json.count
  # end

  # def get_commits
  #   @commits = []
  #   loop.with_index do |_, page_count|
  #     response = HTTParty.get("https://api.github.com/repos/anthonytallent/little-esty-shop/commits?per_page=100&page=#{page_count + 1}", headers: { 'User-Agent' => 'anthonytallent', 'Authorization' => "token #{Rails.application.credentials.config[:github]}"})
  #     parsed_json = JSON.parse(response.body, symbolize_names: true)
  #     @commits << parsed_json
  #     if response.count < 100
  #       @commits.flatten!
  #       break
  #     end
  #   end
  #   @commits
  # end

  # def commit_count
  #   get_names
  #   get_commits
  #   hash = {}
  #   @commits.each do |commit|
  #     if commit[:author].nil?
  #     else
  #       if @user_names.include? commit[:author][:login]
  #         hash[commit[:author][:login].to_sym] ||= 0
  #         hash[commit[:author][:login].to_sym] += 1
  #       end
  #     end
  #   end
  #   hash
  # end
  
  def price_round(totalcost)
    '$' + sprintf("%.2f", totalcost/100.to_f)
  end
end
