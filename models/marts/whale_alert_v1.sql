WITH WHALE AS(
SELECT
output_address,
SUM(output_value) AS total_sent,
count(*) as tx_count
FROM {{ ref('stg_btc_transactions') }}
WHERE output_value >= 10
GROUP BY output_address
ORDER BY total_sent DESC
)

SELECT 
'{{ invocation_id }}' as invocation_id,
W.output_address,
W.total_sent,
W.tx_count,
{{ convert_to_usd('W.total_sent') }} AS total_sent_usd
FROM WHALE W 
ORDER BY total_sent DESC
