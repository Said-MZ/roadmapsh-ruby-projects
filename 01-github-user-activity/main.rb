require 'net/http'
require 'json'
require 'debug' #todo remove

MESSAGES = {
  'PullRequestReviewCommentEvent' => 'Commented on a review in %{repo_name}',
  'PullRequestReviewEvent'        => 'Reviewed a pull request in %{repo_name}',
  'IssueCommentEvent'             => 'Commented on an issue in %{repo_name}',
  'PullRequestEvent'              => 'Opened a new pull request in %{repo_name}',
  'ReleaseEvent'                  => 'Published a new release in %{repo_name}',
  'IssuesEvent'                   => 'Opened a new issue in %{repo_name}',
  'WatchEvent'                    => 'Starred %{repo_name}',
  'PushEvent'                     => 'Pushed %{indices} commits to %{repo_name}',
  'unknown'                       => 'Performed an unknown action in %{repo_name}'
}

def main
  name     = gets.chomp
  # uri      = URI("https://api.github.com/users/sindresorhus/events")
  uri      = URI("https://api.github.com/users/#{name}/events")
  response = fetch_data uri

  if response.code == '404'
    return puts "User with username #{name} does not exist, please enter a valid github username"
  end
  return puts 'Something went wrong' unless response.code == '200'

  data = JSON.parse(response.body)
  return puts 'User has no recent activity' if data.empty?

  print_result data
end

def fetch_data(uri)
  Net::HTTP.get_response(uri)
rescue StandardError
  Kernel.abort 'Something went wrong, please check your internet connection'
end

def print_result(data)
  all_events = data.map { |item| [ item['type'], item['repo']['name'] ] }.tally

  all_events.each do |(event, repo_name), indices|
    if MESSAGES.key? event
      puts format(MESSAGES[event], indices: indices, repo_name: repo_name)
    else
      puts format(MESSAGES['unknown'], indices: indices, repo_name: repo_name)
    end
  end
end

main
