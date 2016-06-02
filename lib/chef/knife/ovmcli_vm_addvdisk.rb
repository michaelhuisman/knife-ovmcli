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
class Chef::Knife::OvmcliVmAddvdisk < Chef::Knife::BaseOraclevmCommand

  banner "knife ovmcli vm addvdisk VMNAME (options)"

  option :slot,
    :short => "-s VALUE",
	:long => "--slot VALUE",
	:description => "The slot number for the disk in the virtual machine."
  
  option :vdisk,
    :short => "-d VALUE",
	:long => "--vdisk VALUE",
	:description => "The name or ID of the virtual disk"
  
  get_common_options

  def run
  
    $stdout.sync = true

    vmname = @name_args[0]
	
	slot=get_config(:slot)
	vdisk=get_config(:vdisk)
	
    current=add_vdisk(vmname, slot, vdisk)
    Chef::Log.debug("Status = #{current[:status]}.  Time = #{current[:time]}. VM Status = #{current[:vmstatus]}.")

    if current[:status]!="Success"
      puts "Call to OVM CLI Failed with #{current[:errormsg]}"
    end

  end
end
