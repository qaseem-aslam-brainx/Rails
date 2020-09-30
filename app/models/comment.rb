class Comment < ApplicationRecord
  belongs_to :article#, -> { where title: "Title" } #cannot comment unless title is "Title"
end