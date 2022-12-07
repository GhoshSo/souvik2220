view: ints {
  sql_table_name: demo_db.ints ;;

  dimension: i {
    type: yesno
    primary_key: yes
    sql: ${TABLE}.i ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
