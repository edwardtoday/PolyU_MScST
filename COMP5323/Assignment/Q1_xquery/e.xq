declare default element namespace "http://qingpei.me/COMP5323";

for $d in doc("psudo_data.xml")//form[.//total_expenditure/applied>30000][count(.//activity_item)<3]/details
return $d/project_name