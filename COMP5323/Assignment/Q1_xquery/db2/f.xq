<group>
{
for $f in db2-fn:xmlcolumn('PSUDO_DATA.PSUDO_DATA_TABLE')//forms/form
let $sum := sum($f//activity_item/number_of_user)
where $sum < 100
return 
<project>
<name>{data($f//project_name)}</name>,
<users>{$sum}</users>
<peruser>{$f//total_expenditure/applied div $sum}</peruser>
</project>
}
</group>
,
<group>
{
for $f in db2-fn:xmlcolumn('PSUDO_DATA.PSUDO_DATA_TABLE')//forms/form
let $sum := sum($f//activity_item/number_of_user)
where $sum < 1000 and $sum > 100
return 
<project>
<name>{data($f//project_name)}</name>,
<users>{$sum}</users>
</project>
}
</group>
,
<group>
{
for $f in db2-fn:xmlcolumn('PSUDO_DATA.PSUDO_DATA_TABLE')//forms/form
let $sum := sum($f//activity_item/number_of_user)
where $sum > 1000
return 
<project>
<name>{data($f//project_name)}</name>,
<users>{$sum}</users>
</project>
}
</group>