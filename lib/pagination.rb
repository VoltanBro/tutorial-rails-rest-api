# /lib/pagination.rb
class Pagination
  def self.build_json object
    ob_name = object.name.downcase + 's'
    json = Hash.new
    json[ob_name] = object
    json[:pagination] = {
        current_page: object.current_page,
        next_page: object.next_page,
        prev_page: object.prev_page,
        total_pages: object.total_pages,
        total_count: object.total_count
    }
    return json
  end
end