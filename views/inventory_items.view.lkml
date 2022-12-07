view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.sold_at ;;
  }

  filter: date_selector {
    type: date
  }

  dimension_group: filtered_created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql:
    CASE
    WHEN ${sold_date} >= {% date_start date_selector %} AND ${created_date} < {% date_end date_selector %} AND ${created_date} >= {% date_start date_selector %} THEN ${created_date}
    WHEN ${sold_date} >= {% date_start date_selector %} AND ${created_date} < {% date_end date_selector %} AND ${created_date} < {% date_start date_selector %} THEN {% date_start date_selector %}
    END;;
  }

  dimension_group: filtered_sold {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql:
    CASE
    WHEN ${sold_date} >= {% date_start date_selector %} AND ${created_date} < {% date_end date_selector %} AND ${sold_date} > {% date_end date_selector %} THEN {% date_end date_selector %}
    WHEN ${sold_date} >= {% date_start date_selector %} AND ${created_date} < {% date_end date_selector %} AND ${sold_date} < {% date_start date_selector %} THEN ${sold_date}
    END;;
  }



  measure: count {
    type: count
    drill_fields: [id, products.id, products.item_name, order_items.count, order_items_vijaya.count]
  }
}
