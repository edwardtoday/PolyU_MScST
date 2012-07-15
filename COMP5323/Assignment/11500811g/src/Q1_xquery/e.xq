for $d in db2-fn:xmlcolumn('PSUDO_DATA.PSUDO_DATA_TABLE')//form[.//total_expenditure/applied>30000][count(.//activity_item)<3]/details
return $d/project_name