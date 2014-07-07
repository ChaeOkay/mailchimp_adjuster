require_relative 'group'
require_relative 'mail_chimp'

class Member
  attr_reader :member, :member_class, :member_location

  def self.update(member)
    new(member).update
  end

  def initialize(member)
    @member_class = member.fetch('merges').fetch('CLASS')
    @member_location = member.fetch('merges').fetch('CLASSLOC')
    @member = member
  end

  def update
    update_member if groupings_present?
  end

  private

  def groupings_present?
    grouping_class && grouping_location
  end

  def update_member
    MailChimp.update_member(email: member['email'],
                            grouping_class: grouping_class,
                            grouping_location: grouping_location)
  end

  def grouping_class
    @class ||= Group.find_or_create(group_name: member_class,
                                    grouping_id: MailChimp::CLASS_ID,
                                    grouping_name: MailChimp::CLASS_NAME)
  end

  def grouping_location
    @location ||= Group.find_or_create(group_name: member_location,
                                       grouping_id: MailChimp::LOCATION_ID,
                                       grouping_name: MailChimp::LOCATION_NAME)
  end
end
