declare namespace t = "http://qingpei.me/COMP5323";

let $d := doc("show.xml")
for $name in $d/t:show//t:star_chef/t:name
	let $ep := $d/t:show/t:episode
	let $pool := $ep/t:star_chef | $ep/t:challenged_chef
	let $count := count($pool[@ref = $name])
	order by $count  descending
return
	<chef>{$name/text()}, {$count }</chef>