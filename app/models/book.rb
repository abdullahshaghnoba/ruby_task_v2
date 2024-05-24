class Book < ApplicationRecord

  filterrific(
        
    available_filters: [
      
        :search_query,
        :search_release_date,
        :search_author_name
        ]
    )

    def self.search_query(query)
    where('title LIKE ?', "%#{query}%")
    end

    def self.search_release_date(query)
        # puts query
        where('release_date = ?', "%#{query}%")
    end

    def self.search_author_name(query)
        joins(:author).where('authors.name LIKE ?', "%#{query}%")
    end

    def self.to_csv(collection)
      CSV.generate(col_sep: ';') do |csv|
        csv << ['Title', 'Release Date', 'Author Name']
        collection.find_each do |record|
          csv << [record.title, record.release_date, record.author.name]
        end
      end
    end

  belongs_to :author
  validates :title, uniqueness: true
  validates :release_date, comparison: { less_than: -> { Date.current } }
end
