# == Schema Information
#
# Table name: whitelisted_clients
#
#  id               :bigint           not null, primary key
#  domain           :string
#  granted_by       :string
#  granted_on       :datetime
#  last_accessed_by :string
#  last_accessed_on :datetime
#  name             :string
#  notes            :string
#  token            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class WhitelistedClient < ApplicationRecord
end
