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
  IO.popen("git symbolic-ref --short HEAD") {|pipe| puts @git_branch = pipe.read }
  params = {
    token: @cukehub_token,
    name:   scenario.name,
    location: scenario.location,
    tag: scenario.source_tag_names,
    status: scenario.status.upcase,
    machine: Socket.gethostname,
    os: os,
    runtime: (Time.now - @start),
    domain: @domain,
    branch: @git_branch.chomp
  }
  params[:browser] = @browser.browser.upcase unless @browser.nil?
  params[:exception]=scenario.exception.message unless scenario.passed?

  HTTParty.post("http://cukehub.com/dropin", body: params)
end   