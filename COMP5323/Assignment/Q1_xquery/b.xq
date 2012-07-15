declare default element namespace "http://qingpei.me/COMP5323";

let $f:=doc("psudo_data.xml")/forms
let $m:=$f/form//group_member
for $l in $f/form/leader
where $l/name=$m/name
return count($l)