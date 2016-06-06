#
# Author:: Geoff O'Callaghan (<geoffocallaghan@gmail.com>)
#          Michael Huisman <michhuis@gmail.com> 
# License:: Apache License, Version 2.0
#

require 'chef/knife'
require 'chef/knife/BaseOraclevmCommand'
require 'netaddr'
require 'net/ssh'

# Migrate a VM
class Chef::Knife::OvmcliVmMigrate < Chef::Knife::BaseOraclevmCommand

  banner "knife ovmcli vm migrate VMNAME (options)"

  get_common_options

    option :server,
    :short => "-s VALUE",
	:long => "--server VALUE",
	:description => "The name of the Oracle VM Server on which to migrate the virtual machine."

  def run
  
    $stdout.sync = true

    vmname = @name_args[0]
    if vmname.nil?
      show_usage
      ui.fatal("You must specify a virtual machine name")
      exit 1
    end
	
    current=show_vm_status(vmname)
    Chef::Log.debug("Status = #{current[:status]}.  Time = #{current[:time]}. VM Status = #{current[:vmstatus]}.")
   
    if current[:status]=="Success"
	   server=get_config(:server)
       mstatus=migrate_vm(vmname, server)
       if mstatus[:status] == "Success"
          puts "#{mstatus[:status]}"
       else
          puts "Failed with #{mstatus[:errormsg]}"
       end
    else
      puts "Call to OVM CLI Failed with #{current[:errormsg]}"
    end
  end
end
