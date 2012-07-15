declare namespace t = "http://qingpei.me/COMP5323";

for $c in doc("show.xml")/t:show/t:star_chef
order by count($c/t:episode_appeared) descending
return
	<p>{data($c/t:name)} , {count($c/t:episode_appeared)}</p>

