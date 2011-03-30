#!/usr/bin/ruby
# defaults write com.googlecode.iterm2 PathHandler <where you put this file>
$debug = true
if $debug
  $stderr.reopen('/Users/chendo/trouter.log', 'a+')
  $stdout.reopen('/Users/chendo/trouter.log', 'a+')
end
class Trouter
  class << self
    def go!
      path, ppid = *ARGV

      path = path.gsub(/:(\d+)(?::.+$)?/, '')
      line_number = $1

      path = "#{get_current_directory(ppid)}/#{path}" if !File.exists?(path)

      return if !File.exists?(path)

      route path, line_number
    end

    def route(path, line_number)
      puts "Routing #{path} line_number: #{line_number}" if $debug
      if File.directory?(path)
        `open #{path}`
      elsif `file #{path}` =~ /text/
        if editor = which_editor
          `open "#{editor}://open?url=file://#{path}&line=#{line_number}"`
        else
          `open #{path}`
        end
      else
        `open #{path}`
      end
    end

    def which_editor
      return 'mvim'
      return 'mvim' if `which mvim` =~ /mvim/
      return 'txmt' if `which mate` =~ /mate/
      return nil
    end

    protected

    def get_current_directory(ppid)
      pid = `ps -j | grep -w #{ppid} | grep -v grep`.split(/\s+/)[1]
      `lsof -a -p #{pid} -d cwd -Fcn`.split(/\n/).last.gsub(/^n/, '')
    end
  end
end

Trouter.go!

