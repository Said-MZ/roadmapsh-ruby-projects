require 'minitest/autorun'
require 'json'
require_relative 'main'

class MainTest < Minitest::Test
  def test_fetch_data_success
    uri = URI('https://api.github.com')
    response = fetch_data(uri)
    assert_equal '200', response.code
  end

  def test_fetch_data_failure
    uri = URI('http://nonexistent.domain')
    assert_raises(SystemExit) { fetch_data(uri) }
  end

  def test_print_result_known_event
    data = [{ 'type' => 'WatchEvent', 'repo' => { 'name' => 'octocat/Hello-World' } }]
    assert_output(/Starred octocat\/Hello-World/) { print_result(data) }
  end

  def test_print_result_unknown_event
    data = [{ 'type' => 'SomeUnknownEvent', 'repo' => { 'name' => 'octocat/Hello-World' } }]
    assert_output(/Performed an unknown action in octocat\/Hello-World/) { print_result(data) }
  end

  def test_print_result_empty
    assert_output("") { print_result([]) }
  end
end
