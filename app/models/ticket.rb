class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  has_many :comments

  belongs_to :state

  attr_accessor :tag_names

  has_and_belongs_to_many :tags

  has_many :assets
  accepts_nested_attributes_for :assets

  before_create :associate_tags

  validates :title, presence: true
  validates :description, presence: true,
            length: {minimum: 10}


  private
  def associate_tags
    if tag_names
      tag_names.split(' ').each do |name|
        self.tags << Tag.find_or_create_by(name: name)
      end
    end
  end

  def self.search(query)
    query
        .split(' ')
        .collect do |query|
      query.split(':')
    end.inject(self) do |klass, (name, q)|
      plural_name = name.pluralize.to_sym
      association = klass.reflect_on_association(plural_name)
      association_table = association.klass.arel_table
      if [:has_and_belongs_to_many,
          :belongs_to].include?(association.macro)
        joins(name.pluralize.to_sym)
            .where(association_table['name'].eq(q))
      else
        all
      end
    end
  end
end