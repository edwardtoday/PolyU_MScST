for $d in db2-fn:xmlcolumn('PSUDO_DATA.PSUDO_DATA_TABLE')//details
where $d/activity_item//date/text()="2012-06-20"
return $d/project_name