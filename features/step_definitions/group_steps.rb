require 'database_cleaner'
require 'database_cleaner/cucumber'
require 'factory_bot'
require File.expand_path(File.join(File.dirname(__FILE__), "../..", "spec", "factories", "group.rb"))


Given /^the following group[s]? exist[s]?/ do |groups_table|
  groups_table.hashes.each do |group|
    Group.create!(group)
  end
end

Given(/^there are (\d+) groups$/) do |num_groups|
  for i in 1..(num_groups.to_i)
  	FactoryBot.create(:group, name: "Group#{i}")
  	FactoryBot.create(:collection_matrix, id: i, :group => "Group#{i}", :name => "Matrix#{i}")
  end
end