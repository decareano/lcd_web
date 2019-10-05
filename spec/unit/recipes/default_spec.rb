#
# Cookbook:: lcd_web
# Spec:: default
#
# Copyright:: 2019, Student Name, All Rights Reserved.

require 'spec_helper'

describe 'lcd_web::default' do
  context 'CentOS' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    let(:chef_run) do
	runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
	runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs httpd' do
      expect(chef_run).to install_package('httpd')
    end
	
    it 'enables the httpd service' do
      expect(chef_run).to enable_service('httpd')
    end

    it 'starts the httpd service' do
      expect(chef_run).to start_service('httpd')
    end

    it 'installs perl' do
      expect(che_run).to install_package('perl')
    end
  end
end
 
  end
end
