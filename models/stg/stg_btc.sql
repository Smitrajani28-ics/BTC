{{ config(materialized='incremental', incremental_strategy='merge', unique_key='HASHKEY') }}
SELECT *
FROM {{ source('btc', 'btc') }}

{% if is_incremental() %}
  WHERE BLOCK_TIMESTAMP >= (SELECT MAX(BLOCK_TIMESTAMP) FROM {{ this }})
{% endif %}

