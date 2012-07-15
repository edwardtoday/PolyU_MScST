let $f:=db2-fn:xmlcolumn('PSUDO_DATA.PSUDO_DATA_TABLE')/forms
let $m:=$f/form//group_member
for $l in $f/form/leader
where $l/name=$m/name
return count($l)