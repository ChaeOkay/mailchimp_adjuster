require_relative 'mail_chimp'
require_relative 'member'

class Adjuster
  def self.update_all_members
    new.update_all_members
  end

  def initialize
    @batch = 0
    @unreviewed_members = [{ 'merges' => { 'CLASS' => '', 'CLASSLOC' => '' } }]
  end

  attr_accessor :batch, :unreviewed_members

  def update_all_members
    until all_members_reviewed?
      update
      load_unreviewed_members
    end
  end

  def all_members_reviewed?
    unreviewed_members.empty?
  end

  def update
    unreviewed_members.each { |member| Member.update(member) }
  end

  def load_unreviewed_members
    puts "Batch #{batch} updated."
    @batch += 1
    @unreviewed_members = MailChimp.members(@batch)
  end
end
