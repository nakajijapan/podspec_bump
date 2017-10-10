require "podspec_bump/version"

module PodspecBump
  class InvalidOptionError < StandardError; end
  class NotfoundSpecFileError < StandardError; end

  class Bump
    BUMPS         = %w(major minor patch)
    OPTIONS       = BUMPS | ["current"]
    VERSION_REGEX = /(\d+\.\d+\.\d+)/

    def self.defaults
      {
        :commit => true
      }
    end

    def self.run(bump, options={})
      options = defaults.merge(options)
      
      case bump
      when *BUMPS
        bump_part(bump, options)
      when "current"
        puts "Current version: #{version_from_file()}"
      else
        raise InvalidOptionError
      end
    rescue InvalidOptionError
      puts "Invalid option. Choose between #{OPTIONS.join(',')}."
    rescue NotfoundSpecFileError
      puts "Not found your spec file"
    rescue Exception => e
      puts "Something wrong happened: #{e.message}\n#{e.backtrace.join("\n")}"
    end

    def self.bump(current, next_version, options)
      replace(current, next_version)
      commit(next_version, options) if options[:commit]
      ["Bump version #{current} to #{next_version}", 0]
    end

    def self.replace(old, new)
      content = File.read(spec_file)
      File.open(spec_file, "w"){|f| f.write(content.sub(old, new)) }
    end

    def self.commit(version, options)
      return unless File.directory?(".git")
      system_cmd("git add --update #{spec_file()} && git commit -m 'v#{version}'")
      system_cmd("git tag -a -m 'Bump to v#{version}' v#{version}")
    end

    def self.system_cmd(command)
      puts command
      system command
    end

    def self.spec_file
      Dir.glob('*.podspec')[0]
    end

    def self.version_from_file
      raise NotfoundSpecFileError if Dir.glob('*.podspec').empty?
      File.read(spec_file)[VERSION_REGEX]
    end

    def self.bump_part(part, options)
      current = version_from_file
      next_version = next_version(current, part)
      bump(current, next_version, options)
    end

    def self.next_version(current, part)
      major, minor, patch = current.split('.')

      case part
      when "major"
        major, minor, patch = major.succ, 0, 0, nil
      when "minor"
        minor, patch = minor.succ, 0
      when "patch"
        patch = patch.succ
      else
        raise "unknown part #{part.inspect}"
      end

      [major, minor, patch].compact.join('.')
    end

  end

end
