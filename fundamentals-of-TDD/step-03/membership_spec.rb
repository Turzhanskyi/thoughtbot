# frozen_string_literal: true

describe Membership do
  before(:each) do
    chocolate_membership.promote_to_admin
  end

  let(:user) { User.new('Bill Wonka') }
  let(:chocolate_group) { Group.new('Chocolate Factory') }
  let(:peach_group) { Group.new('Giant Peach Enthusiasts') }
  let(:chocolate_membership) { Membership.new(user: user, group: chocolate_group, admin: false) }
  let(:peach_membership) { Membership.new(user: user, group: peach_group, admin: false) }

  describe '#promote_to_admin' do
    it 'makes a regular membership an admin membership' do
      membership_to_promote = build_non_admin_membership

      membership_to_promote.promote_to_admin

      expect(membership_to_promote).to be_admin
    end

    it "doesn't change other memberships" do
      membership_to_promote = build_non_admin_membership
      membership_to_not_promote = build_non_admin_membership

      membership_to_promote.promote_to_admin

      expect(membership_to_not_promote).not_to be_admin
    end

    def build_non_admin_membership
      user = User.new
      group = Group.new('A group')

      Membership.new(user: user, group: group, admin: false)
    end
  end
end
