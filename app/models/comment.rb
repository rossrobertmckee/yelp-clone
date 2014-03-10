class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :place

  RATINGS = {
    'One Star'    => '1_star',
    'Two Stars'   => '2_stars',
    'Three Stars' => '3_stars',
    'Four Stars'  => '4_stars',
    'Five Stars'  => '5_stars'
  }

  validates :rating, :inclusion => {:in => (RATINGS.values + [nil, ''])}

end
