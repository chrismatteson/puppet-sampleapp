require 'spec_helper_acceptance'

describe 'Acceptance test' do
  describe 'running puppet code' do
    pp = <<-EOS
      class { 'sampleapp':
        artifactserver => '10.20.1.28',
        version => 1,
      }
    EOS
    it 'should work with no errors' do

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe 'should not return an error on curl' do
      it 'should not return an error on curl' do
        shell("curl localhost:8080/sample -f", :acceptable_exit_codes => 0)
      end
    end
  end
end
