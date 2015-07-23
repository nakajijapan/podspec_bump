$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'podspec_bump'

module SpecHelpers
  module InstanceMethods
    def write(file, content)
      folder = File.dirname(file)
      run "mkdir -p #{folder}" unless File.exist?(folder)
      File.open(file, 'w'){|f| f.write content }
    end

    def read(file)
      File.read(file)
    end

    def run(cmd, options={})
      result = `#{cmd} 2>&1`
      raise "FAILED #{cmd} --> #{result}" if $?.success? != !options[:fail]
      result
    end
  end

end

RSpec.configure do |c|
  c.include SpecHelpers::InstanceMethods
end
