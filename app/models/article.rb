require 'acts_as_xlsx'
class Article < ActiveRecord::Base
 acts_as_xlsx columns: [:id, :title, :content, :status]
    
 has_many :comments, dependent: :destroy
 
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      article = find_or_initialize_by_id(row["id"]) || Article.new
      article.attributes = row.to_hash
      article.save!
    end
  end
  
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end