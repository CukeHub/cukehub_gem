require 'httparty'
require 'os'

if OS.mac? then
  os = "OSX"
elsif OS.linux?
  os = "Linux"
elsif OS.doze?
  os = "Win"
end

Before do
  @start = Time.now.utc
end

After do |scenario|
  finished = Time.now.utc
  ignored_lines = ["Before hook", "After hook", "AfterStep hook"]
  @steps = scenario.test_steps.map{|step| step.text if !ignored_lines.include?(step.text) }.compact.join("\n")
  IO.popen("git symbolic-ref --short HEAD") {|pipe| @git_branch = pipe.read }
  IO.popen("git rev-parse --verify HEAD") {|pipe| @git_sha = pipe.read }
  headers = { "Authorization" => "Token token=\"#{@cukehub_api_key}\""}
  params = {
    name:   scenario.name,
    location: scenario.location,
    tag: scenario.source_tag_names,
    status: scenario.status,
    machine: Socket.gethostname,
    os: os,
    run_completed_at: finished,
    runtime: (finished - @start),
    domain: @domain,
    steps: @steps,
    branch: @git_branch.chomp,
    sha: @git_sha.chomp
  }
  if @browser.inspect =~ /Selenium/
    params[:browser] = @browser.browser unless @browser.nil?
  elsif @driver.inspect =~ /Selenium/
    params[:browser] = @driver.browser unless @driver.nil?
  elsif @browser.inspect =~ /Watir/
    params[:browser] = @browser.name unless @browser.nil?
  elsif @driver.inspect =~ /Watir/
    params[:browser] = @driver.name unless @driver.nil?
  end
  params[:exception]=scenario.exception.backtrace.compact.join("\n") unless scenario.passed?

  HTTParty.post("https://cukehub.com/api/v1/results", headers: headers, body: params, verify: false)
end
