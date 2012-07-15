declare default element namespace "http://qingpei.me/COMP5323";

for $d in doc("psudo_data.xml")//details
where $d/activity_item//date/text()="2012-06-20"
return $d/project_name