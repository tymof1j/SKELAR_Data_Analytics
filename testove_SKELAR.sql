DROP DATABASE IF EXISTS test_s;
CREATE DATABASE test_s;
USE test_s;

-- First task
WITH UserTotalSpend AS (
    SELECT
        id_user,
        id_region,
        SUM(amount) AS user_ts
    FROM orders
    WHERE status = 'success'
    GROUP BY id_user, id_region
),
RegionAverage AS (
    SELECT
        id_region,
        AVG(user_ts) AS region_avg_ts
    FROM UserTotalSpend
    GROUP BY id_region
)
SELECT
    u.id_user,
    u.id_region,
    u.user_ts,
    r.region_avg_ts
FROM UserTotalSpend u
JOIN RegionAverage r ON u.id_region = r.id_region
WHERE u.user_ts > r.region_avg_ts
ORDER BY u.user_ts DESC;

-- Second task
