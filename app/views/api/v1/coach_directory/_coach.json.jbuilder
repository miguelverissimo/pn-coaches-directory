json.name coach.full_name
json.certification_level coach.level_2 ? 'Level 2' : 'Level 1'
json.(coach, :level_1, :level_2, :business_name, :business_phone, :mobile_phone, :email)
json.url coach.url
json.tag_line coach.specialty
json.location coach.full_address
