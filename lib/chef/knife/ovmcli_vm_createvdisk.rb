#
# Code copied from Author:: Geoff O'Callaghan (<geoffocallaghan@gmail.com>)
# Author:: Michael Huisman michhuis@gmail.com
# License:: Apache License, Version 2.0
#

require 'chef/knife'
require 'chef/knife/BaseOraclevmCommand'
require 'netaddr'
require 'net/ssh'

# Create a virtual disk
class Chef::Knife::OvmcliVmCreatevdisk < Chef::Knife::BaseOraclevmCommand

  banner "knife ovmcli vm createvdisk VDISK (options)"

  option :size,
    :short => "-s VALUE",
	:long => "--size VALUE",
	:description => "The size of the virtual disk in GiB. "
  
  option :sparse,
    :short => "-p VALUE",
	:long => "--sparse VALUE",
	:description => "Whether to create a sparse or non-sparse virtual disk  Yes or No"
	
  option :reposotory,
    :short => "-r VALUE",
	:long => "--reposotory VALUE",
	:description => "The name of the reposotory where the disk will be created" 
  
  get_common_options

  def run
  
    $stdout.sync = true

    vdisk = @name_args[0]
	
	size=get_config(:size)
	sparse=get_config(:sparse)
	reposotory=get_config(:reposotory)

    current=create_vdisk(vdisk, size, sparse, reposotory)
    Chef::Log.debug("Status = #{current[:status]}.  Time = #{current[:time]}. VM Status = #{current[:vmstatus]}.")

    if current[:status]!="Success"
      puts "Call to OVM CLI Failed with #{current[:errormsg]}"
    end

  end
end
