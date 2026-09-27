CREATE DATABASE waze_churn_project;
USE waze_churn_project;
SHOW TABLES;
SELECT COUNT(*) AS total_rows
FROM waze_users;
SELECT *
FROM waze_users
LIMIT 10;
SELECT 
    label,
    COUNT(*) AS number_of_users
FROM waze_users
GROUP BY label;
SELECT
    COUNT(*) AS total_rows,
    COUNT(label) AS users_with_label,
    SUM(label = 'churned') AS churned_users,
    SUM(label = 'retained') AS retained_users
FROM waze_users;
SELECT
    COUNT(*) AS known_users,
    SUM(label = 'churned') AS churned_users,
    ROUND(
        100.0 * SUM(label = 'churned') / COUNT(*),
        2
    ) AS churn_rate
FROM waze_users
WHERE label IN ('churned', 'retained');
SELECT
    device,
    COUNT(*) AS users
FROM waze_users
GROUP BY device;
SELECT
    device,
    COUNT(*) AS known_users,
    SUM(label = 'churned') AS churned_users,
    ROUND(
        100.0 * SUM(label = 'churned') / COUNT(*),
        2
    ) AS churn_rate
FROM waze_users
WHERE label IN ('churned', 'retained')
GROUP BY device;
SELECT
    MIN(activity_days) AS minimum_activity_days,
    MAX(activity_days) AS maximum_activity_days,
    ROUND(AVG(activity_days), 2) AS average_activity_days
FROM waze_users
WHERE label IN ('churned', 'retained');
SELECT
    label,
    ROUND(AVG(activity_days), 2) AS avg_activity_days
FROM waze_users
WHERE label IN ('churned', 'retained')
GROUP BY label;
SELECT
    activity_days,
    COUNT(*) AS number_of_users
FROM waze_users
WHERE activity_days > 28
GROUP BY activity_days
ORDER BY activity_days;
SELECT
    label,
    sessions,
    drives,
    activity_days,
    driving_days
FROM waze_users
WHERE activity_days > 28
LIMIT 20;
SELECT
    CASE
        WHEN activity_days <= 10 THEN 'Low'
        WHEN activity_days <= 20 THEN 'Medium'
        ELSE 'High'
    END AS engagement_tier,

    COUNT(*) AS total_users,

    SUM(label = 'churned') AS churned_users,

    ROUND(
        100.0 * SUM(label = 'churned') / COUNT(*),
        2
    ) AS churn_rate

FROM waze_users

WHERE label IN ('churned', 'retained')

GROUP BY engagement_tier

ORDER BY
    CASE engagement_tier
        WHEN 'Low' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'High' THEN 3
    END;