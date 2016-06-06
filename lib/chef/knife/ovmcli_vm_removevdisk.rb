#
# Code copied from Author:: Geoff O'Callaghan (<geoffocallaghan@gmail.com>)
# Author:: Michael Huisman michhuis@gmail.com
# License:: Apache License, Version 2.0
#

require 'chef/knife'
require 'chef/knife/BaseOraclevmCommand'
require 'netaddr'
require 'net/ssh'

# Remove a virtual disk
class Chef::Knife::OvmcliVmRemovevdisk < Chef::Knife::BaseOraclevmCommand

  banner "knife ovmcli vm removevdisk VDISKID"
  
  get_common_options

  def run
  
    $stdout.sync = true

    vdiskid = @name_args[0]
	
    current=remove_vdisk(vdiskid)
    Chef::Log.debug("Status = #{current[:status]}.  Time = #{current[:time]}. VM Status = #{current[:vmstatus]}.")

    if current[:status]!="Success"
      puts "Call to OVM CLI Failed with #{current[:errormsg]}"
    end

  end
end
