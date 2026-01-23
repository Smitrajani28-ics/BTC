{{ config(materialized='ephemeral') }}

SELECT *
FROM {{ ref('stg_btc_outputs') }}
where is_coinbase = false

