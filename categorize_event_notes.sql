-- Categorize free-text event notes using pattern matching
-- Enables aggregation and filtering by issue type, location, or condition

WITH categorized AS (
  SELECT
    event_id,
    event_notes,
    metric_value,
    CASE
      WHEN event_notes ILIKE '%issue type A%' THEN 'Category A'
      WHEN event_notes ILIKE '%issue type B%' THEN 'Category A'
      WHEN event_notes ILIKE '%issue type C%' THEN 'Category A'
      WHEN event_notes ILIKE '%issue type D%' THEN 'Category A'
      WHEN event_notes ILIKE '%issue type E%' THEN 'Category A'
      WHEN event_notes ILIKE '%condition X%' THEN 'Category B'
      WHEN event_notes ILIKE '%condition Y%' THEN 'Category B'
      WHEN event_notes ILIKE '%condition Z%' THEN 'Category B'
      WHEN event_notes ILIKE '%obstruction%' THEN 'Category B'
      WHEN event_notes ILIKE '%location A%' THEN 'Category C'
      WHEN event_notes ILIKE '%location B%' THEN 'Category C'
      WHEN event_notes ILIKE '%condition A%' THEN 'Category C'
      WHEN event_notes ILIKE '%no data%' THEN 'Category C'
      WHEN event_notes ILIKE '%special case%' THEN 'Category C'
      WHEN event_notes ILIKE '%edge case%' THEN 'Category C'
      ELSE 'Uncategorized'
    END AS category
  FROM your_schema.your_event_table
  WHERE event_status = 'Filtered Status'
    AND event_date >= '2024-08-01'
)

SELECT
  event_id,
  category,
  SUM(metric_value) AS total_metric
FROM categorized
GROUP BY event_id, category;
