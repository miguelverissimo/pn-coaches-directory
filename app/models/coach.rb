# == Schema Information
#
# Table name: wp_fitpro_directory
#
#  id                :integer          not null, primary key
#  address1          :string(255)
#  address2          :string(255)
#  businessname      :string(255)
#  businessphone     :string(255)
#  city              :string(255)
#  country           :string(255)
#  email             :string(255)
#  fullname          :string(255)
#  level1_status     :integer          default(0)
#  level2_status     :integer          default(0)
#  mobilephone       :string(255)
#  postalcode        :string(255)
#  procoach_status   :integer          default(0)
#  province          :string(255)
#  show_in_directory :integer          default(0)
#  source            :string(80)
#  specialty         :text
#  url               :string(255)
#  url_last_checked  :integer
#  url_last_status   :integer
#  userid            :integer
#

class Coach < ApplicationRecord
  self.table_name = 'wp_fitpro_directory'

  # default to query only the coaches to be shown in the directory
  default_scope { where(show_in_directory: true) }

  # remap attributes to follow rails conventions
  alias_attribute :address_1, :address1
  alias_attribute :address_2, :address2
  alias_attribute :business_name, :businessname
  alias_attribute :business_phone, :businessphone
  alias_attribute :full_name, :fullname
  alias_attribute :mobile_phone, :mobilephone
  alias_attribute :postal_code, :postalcode
  alias_attribute :user_id, :userid

  after_initialize do
    {
      level_1: :level1_status,
      level_2: :level2_status,
      pro_coach: :procoach_status,
      show_in_directory: :show_in_directory,
      url_last_status: :url_last_status
    }.each  do |method_name, column|
      define_boolean_aliases(method_name, column)
    end
  end

  private

  def define_boolean_aliases(method_name, column)
    (class << self; self; end).instance_eval do
      define_method method_name do
        read_attribute(column) == 1
      end

      define_method "#{method_name}=" do |val|
        write_attribute column, bool_to_int(val)
      end
    end
  end

  def bool_to_int(val)
    val ? 1 : 0
  end
end
