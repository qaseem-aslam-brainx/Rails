class TextValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        if value.length < 5
            record.errors[attribute] << (options[:message] || "is too short!!!")
        end
    end
end

class Article < ApplicationRecord
    has_many :comments, dependent: :destroy
    validates :title, presence: true, uniqueness: true
    validates :title, length: { in: 6..50, too_long: "length is too long! Max is %{count}", 
                                           too_short: "length is too short! Min is %{count}" },
                                           unless: Proc.new { |a| a.title.blank? } 
    validates :text, presence: true
    validates :text, text: true, unless: Proc.new { |a| a.text.blank? }

    before_validation :call_before_validation, on: [ :create, :update ]
    before_create do
        self.title = title.capitalize #unless title.blank?
    end
    around_save :checking_around
  private
    def call_before_validation
        puts "Before validation"
    end
    def checking_around
        x = 10
        print "before X = "
        puts x
        x = 20
        yield
        print "after X = "
        puts x
    end
end
