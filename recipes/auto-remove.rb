#
# Cookbook Name:: chef-client-wrapper
# Recipe:: auto-remove 
#
# Copyright 2013, Ryutaro YOSHIBA 
#
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

if platform_family?("rhel")
  node_name = Chef::Config[:node_name]

  template "/etc/rc.d/init.d/chef-client-remove" do
    source "chef-client-remove.erb"
    mode 0755
    owner "root"
    group "root"
    variables({
      :node_name => node_name
    })
  end

  service "chef-client-remove" do
    supports :start => true, :stop => true, :restart => true
    action [:enable, :restart]
  end

  execute "/sbin/chkconfig --level 0 chef-client-remove off" do
    action :run
  end
end
