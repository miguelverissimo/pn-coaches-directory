json.array! @coaches do |coach|
  json.partial! 'api/v1/coach_directory/coach', coach: coach
end
