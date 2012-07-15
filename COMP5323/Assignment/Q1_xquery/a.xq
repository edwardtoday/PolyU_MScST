declare default element namespace "http://qingpei.me/COMP5323";

for $l in doc("psudo_data.xml")//leader
where $l/department="COMP" and $l/mode="Full"
return $l/name