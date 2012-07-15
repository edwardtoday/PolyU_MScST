for $l in db2-fn:xmlcolumn('PSUDO_DATA.PSUDO_DATA_TABLE')//leader
where $l/department="COMP" and $l/mode="Full"
return $l/name