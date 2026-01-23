{% macro convert_to_usd(column_name) %}
{{column_name}} *( 
    SELECT PRICE 
    FROM {{ ref('btc_usd_max') }}
    where to_date(REPLACE(snapped_at,' UTC','')) = current_date())
{% endmacro %}