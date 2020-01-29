class PostSerializer < ActiveModel::Serializer
  attributes :id, :body
  has_one :user
  has_many :comments
  def comments
    comment_page = instance_options[:nested_page].presence || 1
    comment_per = instance_options[:nested_per].presence || 10
    object.comments.published.by_date.page(comment_page).per(comment_per)
  end
end
