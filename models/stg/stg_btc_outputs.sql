{{ config(MATERIALIZED='incremental', incremental_strategy='append') }}
WITH FLATTENED_OUTPUTS AS (
SELECT
tx.hashkey,
tx.block_number,
tx.block_timestamp,
tx.is_coinbase,
f.value:address::string as output_address,
f.value:value::float as output_value
FROM {{ ref('stg_btc') }} tx,
LATERAL FLATTEN(input => outputs) f
WHERE f.value:address IS NOT NULL

{% if is_incremental() %}
  AND tx.block_timestamp >= (SELECT MAX(block_timestamp) FROM {{ this }})
{% endif %}
)

SELECT
hashkey,
block_number,
block_timestamp,
is_coinbase,
output_address,
output_value
FROM flattened_outputs 