json.name coach.full_name
json.certification_level coach.level_2? ? 'Level 2' : 'Level 1'
json.call(coach, :business_name, :business_phone, :mobile_phone, :email)
json.level_1 coach.level_1?
json.level_2 coach.level_2?
json.url coach.url
json.tag_line coach.specialty
json.location coach.full_address
