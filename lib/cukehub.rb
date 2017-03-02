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
  @start = Time.now
end

After do |scenario|
  ignored_lines = ["Before hook", "After hook", "AfterStep hook"]
  @steps = scenario.test_steps.map{|step| step.name if !ignored_lines.include?(step.name) }.compact.join("\n")
  IO.popen("git symbolic-ref --short HEAD") {|pipe| @git_branch = pipe.read }
  IO.popen("git rev-parse --verify HEAD") {|pipe| @git_sha = pipe.read }
  headers = { "Authorization" => "Token token=\"#{@cukehub_api_key}\""}
  params = {
    name:   scenario.name,
    location: scenario.location,
    tag: scenario.source_tag_names,
    status: scenario.status.upcase,
    machine: Socket.gethostname,
    os: os,
    runtime: (Time.now - @start),
    domain: @domain,
    steps: @steps,
    branch: @git_branch.chomp,
    sha: @git_sha.chomp
  }
  params[:browser] = @browser.browser.upcase unless @browser.nil?
  params[:exception]=scenario.exception.backtrace.compact.join("\n") unless scenario.passed?

  HTTParty.post("https://cukehub.com/api/v1/results", headers: headers, body: params, verify: false)
end
