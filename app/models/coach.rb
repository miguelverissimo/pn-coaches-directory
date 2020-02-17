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
  default_scope { where(show_in_directory: 1) }

  # remap attributes to follow rails conventions
  alias_attribute :address_1, :address1
  alias_attribute :address_2, :address2
  alias_attribute :business_name, :businessname
  alias_attribute :business_phone, :businessphone
  alias_attribute :full_name, :fullname
  alias_attribute :mobile_phone, :mobilephone
  alias_attribute :postal_code, :postalcode
  alias_attribute :user_id, :userid
  alias_attribute :level_1, :level1_status
  alias_attribute :level_2, :level2_status
  alias_attribute :pro_coach, :procoach_status

  scope :filter_by_country, ->(country) { where country: country }
  scope :filter_by_city, ->(city) { where city: city }
  scope :filter_by_postal_code, ->(postal_code) { where postal_code: postal_code }
  scope :filter_by_name_starts_with, ->(name) { where(arel_table[:fullname].matches("#{name}%")) }

  def full_address
    [address_1, address_2, city, "#{province} #{postal_code}", country]
      .reject(&:empty?)
      .join(', ')
  end
end
