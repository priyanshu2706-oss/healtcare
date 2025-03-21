CREATE DATABASE healthcare_data;

USE healthcare_data;

# Shows publication trends over the years.
SELECT year, COUNT(*) AS article_count 
FROM healthcare_data 
WHERE year BETWEEN 2010 AND 2024
GROUP BY year 
ORDER BY year ASC;

# Finds the most frequently discussed healthcare topics.
SELECT topic, COUNT(*) AS count 
FROM healthcare_data 
GROUP BY topic 
ORDER BY count DESC 
LIMIT 5;

# Shows how healthcare topics evolve over time.
SELECT year, topic, COUNT(*) AS count
FROM healthcare_data
WHERE year BETWEEN 2010 AND 2024
GROUP BY year, topic
ORDER BY year ASC, count DESC;

# Tracks healthcare trends on a monthly basis.
SELECT year, month, COUNT(*) AS count
FROM healthcare_data
WHERE year BETWEEN 2010 AND 2024
GROUP BY year, month
ORDER BY year ASC, FIELD(month, 
    'January', 'February', 'March', 'April', 'May', 'June', 
    'July', 'August', 'September', 'October', 'November', 'December');
    
# Identifies which regions contribute the most research.
SELECT region, COUNT(*) AS research_count
FROM healthcare_data
GROUP BY region
ORDER BY research_count DESC;

ALTER TABLE healthcare_data
RENAME COLUMN `Region/Country` TO Region;

ALTER TABLE healthcare_data
RENAME COLUMN `Sentiment Score` TO Sentiment;

# Analyzes overall sentiment per topic.
SELECT topic, 
       ROUND(AVG(sentiment), 2) AS avg_sentiment
FROM healthcare_data
GROUP BY topic
ORDER BY avg_sentiment DESC;

# Finds years with unusually high research activity.
SELECT year, COUNT(*) AS article_count
FROM healthcare_data
WHERE year BETWEEN 2010 AND 2024
GROUP BY year
HAVING COUNT(*) > (SELECT AVG(article_count) FROM 
                   (SELECT year, COUNT(*) AS article_count 
                    FROM healthcare_data WHERE year BETWEEN 2010 AND 2024 GROUP BY year) AS yearly_avg);
                    
                    
# Analyzes if increased research correlates with positive/negative sentiment.
SELECT year, 
       COUNT(*) AS article_count, 
       ROUND(AVG(sentiment), 2) AS avg_sentiment
FROM healthcare_data
WHERE year BETWEEN 2010 AND 2024
GROUP BY year
ORDER BY year ASC;
