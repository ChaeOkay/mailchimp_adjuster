require 'gibbon'

Gibbon::API.api_key = ENV['MAILCHIMP_KEY']

module MailChimp
  CLASS_ID = 11111 # replace with interest grouping id
  CLASS_NAME = 'CLASS'# replace with interest grouping name
  LOCATION_ID = 22222
  LOCATION_NAME = 'CLASSLOC'

  class << self

    # Adjuster
    def members(page)
      Gibbon::API.lists.members({ id: ENV['MAILCHIMP_LIST'], opts: { start: page } })['data']
    end

    # Group
    def groupings
      Gibbon::API.lists.interest_groupings({ id: ENV['MAILCHIMP_LIST'] })
    end

    def create_group(grouping_id:, group_name:)
      Gibbon::API.lists.interest_group_add({ grouping_id: grouping_id,
                                             group_name: group_name,
                                             id: ENV['MAILCHIMP_LIST']})
    end

    # Member
    def update_member(email:, grouping_class:, grouping_location:)
      Gibbon::API.lists.update_member({ id: ENV['MAILCHIMP_LIST'],
                                        email: { email: email },
                                        replace_interests: false,
                                        merge_vars: { groupings: [{ id: grouping_class.grouping_id,
                                                                    name: grouping_class.grouping_name,
                                                                    groups: [grouping_class.group_name]
                                                                  },
                                                                  { id: grouping_location.grouping_id,
                                                                    name: grouping_location.grouping_name,
                                                                    groups: [grouping_location.group_name]
                                                                  },
                                                                 ]
                                                                }
                                                              })
    end
  end
end
