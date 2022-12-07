view: order_items {

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
  }

  measure: max_sale_price {
    type: max
    sql: ${sale_price} ;;
  }




  parameter: sale_price_metric_picker {
    description: "Use with the Sale Price Metric measure"
    type: unquoted
    allowed_value: {
      label: "Total Sale Price"
      value: "total_sale_price"
    }
    allowed_value: {
      label: "Average Sale Price"
      value: "average_sale_price"
    }
  }

  measure: dynamic_measure {
    type: number
    sql:
    {% if sale_price_metric_picker._parameter_value == 'total_sale_price' %}
    ${total_sale_price}
    {% else %}
    ${average_sale_price}
    {% endif %}
    ;;
  }


  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: phones {
    type: string
    sql: ${TABLE}.phones ;;
  }

  dimension_group: returned {
    type: time
    # timeframes: [
    #   raw,
    #   time,
    #   date,
    #   week,
    #   month,
    #   quarter,
    #   year
    # ]
    sql: ${TABLE}.returned_at ;;
  }


  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

}
