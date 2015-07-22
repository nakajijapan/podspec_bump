require 'spec_helper'

describe PodspecBump do

  after do
    File.delete('fixture.podspec') if File.exist?('fixture.podspec')
  end

  it 'has a version number' do
    expect(PodspecBump::VERSION).not_to be nil
  end

  it 'fail if it cannot find anything to bump' do
    expect(podspec_bump('current', fail: false)).to include 'Not found your spec file'
  end

  it 'fail without command' do
    write_podspec
    expect(podspec_bump('', fail: false)).to include 'Invalid option. Choose between major,minor,patch,current.'
  end

  it "show help" do
    expect(podspec_bump("--help")).to include 'podspec_bump current'
  end

  context 'version in fixture.podspec' do
    before do
      write_podspec
    end

    it 'current is correct version' do
      expect(podspec_bump('current', fail: false)).to include 'Current version: 4.2.3'
    end

    it 'patch is correct version' do
      expect(podspec_bump('patch', fail: false)).to include '4.2.4'
      expect(read('fixture.podspec')).to include '4.2.4'
    end

    it 'minor is correct version' do
      expect(podspec_bump('minor', fail: false)).to include '4.3.0'
      expect(read('fixture.podspec')).to include '4.3.0'
    end

    it 'major is correct version' do
      expect(podspec_bump('major', fail: false)).to include '5.0.0'
      expect(read('fixture.podspec')).to include '5.0.0'
    end

    it 'podspec_bump more then 10' do
      expect(podspec_bump("patch")).to include '4.2.4'
      expect(podspec_bump("patch")).to include '4.2.5'
      expect(podspec_bump("patch")).to include '4.2.6'
      expect(podspec_bump("patch")).to include '4.2.7'
      expect(podspec_bump("patch")).to include '4.2.8'
      expect(podspec_bump("patch")).to include '4.2.9'
      expect(podspec_bump("patch")).to include '4.2.10'
      expect(podspec_bump("patch")).to include '4.2.11'
      expect(read('fixture.podspec')).to include '"4.2.11"'
    end

  end

  private

  def podspec_bump(command='', options={})
    cmdline = "#{File.expand_path("../../bin/podspec_bump", __FILE__)} #{command}"
    run cmdline, options
  end

  def write_podspec(version = '"4.2.3"')
    write 'fixture.podspec', <<-RUBY.sub(" "*6, "")
      Pod::Spec.new do |s|
        s.name             = "PodspecBump"
        s.version          = #{version}
        s.summary          = "summary summary"
        s.homepage         = "https://github.com"
        s.license          = 'MIT'
        s.author           = { "nakajijapan" => "test@google.com" }
        s.source           = { :git => "https://github.com/" :tag => s.version.to_s }
      end
    RUBY
  end

end
