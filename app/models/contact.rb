class Contact < ActiveRecord::Base

  before_validation :remove_phone_dashes

  validates :phone_number, format: { with: /\A\d{10}\z/, message: 'Phone number must have exactly 10 numbers.' }
  validates_length_of :first_name, :minimum => 1
  validates_length_of :last_name, :minimum => 1

  def pretty_number
    '(' + self.phone_number[0..2] + ') ' + self.phone_number[3..5] + '-' + self.phone_number[6..9]
  end

  private
    def remove_phone_dashes
      raw_digits = ''
      self.phone_number.each_char do |char|
        if char =~ /\d/
          raw_digits += char
        end
      end

      self.phone_number = raw_digits
    end

end
