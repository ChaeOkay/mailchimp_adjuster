require_relative 'mail_chimp'

class Group
  extend MailChimp

  attr_reader :grouping_id, :grouping_name, :group_name

  def self.find_or_create(group_name:, grouping_id:, grouping_name:)
    new(group_name: group_name, grouping_id: grouping_id, grouping_name: grouping_name).
      find_or_create unless group_name.empty?
  end

  def initialize(group_name:, grouping_id:, grouping_name:)
    @group_name = group_name
    @grouping_id = grouping_id
    @grouping_name = grouping_name
  end

  def find_or_create
    create_group unless group
    self
  end

  private

  def groupings
    MailChimp.groupings.find { |grouping| grouping['id'] == grouping_id }
  end

  def groups
    groupings['groups']
  end

  def group
    groups.select { |group| group['name'] == group_name }.first
  end

  def create_group
    MailChimp.create_group(grouping_id: grouping_id, group_name: group_name)
  end
end
