#
# Cookbook Name:: james
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

docker_image 'linagora/james-project' do
  action :pull
end

docker_image 'cassandra' do
  tag '2.2.3'
  action :pull
end

docker_image 'elasticsearch' do
  tag '2.2.1'
  action :pull
end

docker_container 'my_es' do
  repo 'elasticsearch'
  tag '2.2.1'
  action :run
end

docker_container 'my_cas' do
  repo 'cassandra'
  tag '2.2.3'
  action :run
end

directory '/etc/james' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/james/keystore' do
    source 'keystore'
end
template '/etc/james/dnsservice.xml' do
    source 'dnsservice.xml.erb'
end
template '/etc/james/domainlist.xml' do
    source 'domainlist.xml.erb'
end
template '/etc/james/elasticsearch.properties' do
    source 'elasticsearch.properties.erb'
end
template '/etc/james/fetchmail.xml' do
    source 'fetchmail.xml.erb'
end
template '/etc/james/imapserver.xml' do
    source 'imapserver.xml.erb'
end
template '/etc/james/indexer.xml' do
    source 'indexer.xml.erb'
end
template '/etc/james/jmap.properties' do
    source 'jmap.properties.erb'
end
template '/etc/james/jmx.properties' do
    source 'jmx.properties.erb'
end
cookbook_file '/etc/james/jwt_publickey' do
    source 'jwt_publickey.erb'
end
template '/etc/james/lmtpserver.xml' do
    source 'lmtpserver.xml.erb'
end
template '/etc/james/logback.xml' do
    source 'logback.xml.erb'
end
template '/etc/james/mailetcontainer.xml' do
    source 'mailetcontainer.xml.erb'
end
template '/etc/james/mailrepositorystore.xml' do
    source 'mailrepositorystore.xml.erb'
end
template '/etc/james/managesieve.help.txt' do
    source 'managesieve.help.txt.erb'
end
template '/etc/james/managesieveserver.xml' do
    source 'managesieveserver.xml.erb'
end
template '/etc/james/pop3server.xml' do
    source 'pop3server.xml.erb'
end
template '/etc/james/quota.xml' do
    source 'quota.xml.erb'
end
template '/etc/james/recipientrewritetable.xml' do
    source 'recipientrewritetable.xml.erb'
end
template '/etc/james/smtpserver.xml' do
    source 'smtpserver.xml.erb'
end
template '/etc/james/usersrepository.xml' do
    source 'usersrepository.xml.erb'
end
template '/etc/james/webadmin.properties' do
    source 'webadmin.properties.erb'
end

docker_container 'my_james' do
  repo 'linagora/james-project'
  tag 'latest'
  volumes ['/etc/james:/root/conf']
  port '25:25'
  links ['my_cas:cassandra', 'my_es:elasticsearch']
  action :run
end
