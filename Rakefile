require "bundler/gem_tasks"
require "rake/testtask"

task :default => :test

Rake::TestTask.new do |t|
  t.test_files = FileList["test/**/test_*.rb"]
end

desc "Changelog"
task :changelog do
  tag   = ENV["FROM"] || `git describe --abbrev=0 --tags`.strip
  range = [tag, "HEAD"].compact.join ".."
  cmd   = "git log --no-merges #{range} '--format=tformat:%B|||%aN|||%aE|||'"
  now   = Time.new.strftime "%Y-%m-%d"

  changes = `#{cmd}`.split(/\|\|\|/).each_slice(3).map do |msg, author, email|
    msg.split(/\n/).reject { |s| s.empty? }
  end

  changes = changes.flatten

  next if changes.empty?

  $changes = Hash.new { |h,k| h[k] = [] }

  codes = {
    "!" => :major,
    "+" => :minor,
    "*" => :minor,
    "-" => :bug,
    "?" => :unknown,
  }

  codes_re = Regexp.escape codes.keys.join

  changes.each do |change|
    if change =~ /^\s*([#{codes_re}])\s*(.*)/ then
      code, line = codes[$1], $2
    else
      code, line = codes["?"], change.chomp
    end

    $changes[code] << line
  end

  puts "=== #{ENV['VERSION'] || 'NEXT'} / #{now}"
  puts
  changelog_section :major
  changelog_section :minor
  changelog_section :bug
  changelog_section :unknown
  puts
end

def changelog_section code
  name = {
    :major   => "major enhancement",
    :minor   => "minor enhancement",
    :bug     => "bug fix",
    :unknown => "unknown",
  }[code]

  changes = $changes[code]
  count = changes.size
  name += "s" if count > 1
  name.sub!(/fixs/, 'fixes')

  return if count < 1

  puts "* #{count} #{name}:"
  puts
  changes.sort.each do |line|
    puts "  * #{line}"
  end
  puts
end