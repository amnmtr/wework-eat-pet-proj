# == Schema Information
#
# Table name: tests
#
#  id         :integer          not null, primary key
#  name       :string
#  j          :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Test, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
