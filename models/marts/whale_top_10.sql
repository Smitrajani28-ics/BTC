WITH BASE AS(
    SELECT *
    FROM {{ ref('whale_alert') }}
    ORDER BY total_sent DESC
    LIMIT 10
)

SELECT *
FROM BASE