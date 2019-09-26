class Task < ApplicationModel
  attr_reader :user_id
  attr_accessor :title, :body
end
