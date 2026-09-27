USE airline_project;


-- =========================================================
-- Q1. TOTAL NUMBER OF BOOKINGS
-- =========================================================

SELECT
    COUNT(*) AS total_bookings
FROM airline_bookings;


-- =========================================================
-- Q2. TOTAL REVENUE
-- =========================================================

SELECT
    ROUND(SUM(ticket_price_inr), 2) AS total_revenue
FROM airline_bookings;


-- =========================================================
-- Q3. AVERAGE TICKET PRICE
-- =========================================================

SELECT
    ROUND(AVG(ticket_price_inr), 2) AS average_ticket_price
FROM airline_bookings;


-- =========================================================
-- Q4. OVERALL CANCELLATION RATE
-- =========================================================

SELECT
    COUNT(*) AS total_bookings,
    SUM(cancelled) AS cancelled_bookings,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM airline_bookings;


-- =========================================================
-- Q5. REVENUE BY TRAVEL CLASS
-- =========================================================

SELECT
    travel_class,
    COUNT(*) AS bookings,
    ROUND(SUM(ticket_price_inr), 2) AS revenue
FROM airline_bookings
GROUP BY travel_class
ORDER BY revenue DESC;


-- =========================================================
-- Q6. CANCELLATION BY BOOKING CHANNEL
-- =========================================================

SELECT
    booking_channel,
    COUNT(*) AS total_bookings,
    SUM(cancelled) AS cancelled_bookings,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM airline_bookings
GROUP BY booking_channel
ORDER BY cancellation_rate DESC;


-- =========================================================
-- Q7. CANCELLATION BY TRAVELER TYPE
-- =========================================================

SELECT
    traveler_type,
    COUNT(*) AS total_bookings,
    SUM(cancelled) AS cancelled_bookings,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM airline_bookings
GROUP BY traveler_type
ORDER BY cancellation_rate DESC;


-- =========================================================
-- Q8. ROUTE PERFORMANCE
-- =========================================================

SELECT
    route,
    COUNT(*) AS bookings,
    ROUND(SUM(ticket_price_inr), 2) AS revenue,
    ROUND(AVG(ticket_price_inr), 2) AS avg_ticket_price,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM airline_bookings
GROUP BY route
ORDER BY revenue DESC;


-- =========================================================
-- Q9. OUR PRICE VS COMPETITOR PRICE
-- =========================================================

SELECT
    travel_class,
    ROUND(AVG(ticket_price_inr), 2) AS our_avg_price,
    ROUND(AVG(competitor_avg_price_inr), 2) AS competitor_avg_price,
    ROUND(
        AVG(ticket_price_inr) - AVG(competitor_avg_price_inr),
        2
    ) AS price_difference
FROM airline_bookings
GROUP BY travel_class;


-- =========================================================
-- Q10. HIGH-VALUE BOOKINGS
-- Bookings where ticket price is above overall average
-- =========================================================
SELECT
    booking_id,
    route,
    travel_class,
    ticket_price_inr
FROM airline_bookings
WHERE ticket_price_inr >
      (
          SELECT AVG(ticket_price_inr)
          FROM airline_bookings
      )
ORDER BY ticket_price_inr DESC;


-- =========================================================
-- Q11. CASE WHEN - CUSTOMER PRICE SEGMENT
-- =========================================================

SELECT
    booking_id,
    ticket_price_inr,
    CASE
        WHEN ticket_price_inr < 10000 THEN 'Low'
        WHEN ticket_price_inr < 25000 THEN 'Medium'
        ELSE 'High'
    END AS price_segment
FROM airline_bookings
ORDER BY ticket_price_inr DESC;


-- =========================================================
-- Q12. CTE - HIGH CANCELLATION ROUTES
-- =========================================================

WITH route_analysis AS
(
    SELECT
        route,
        COUNT(*) AS total_bookings,
        ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
    FROM airline_bookings
    GROUP BY route
)
SELECT
    route,
    total_bookings,
    cancellation_rate
FROM route_analysis
WHERE cancellation_rate > 20
ORDER BY cancellation_rate DESC;


-- =========================================================
-- Q13. RANK - HIGHEST TICKET PRICES
-- =========================================================

SELECT
    booking_id,
    route,
    ticket_price_inr,
    RANK() OVER (
        ORDER BY ticket_price_inr DESC
    ) AS price_rank
FROM airline_bookings;


-- =========================================================
-- Q14. ROW_NUMBER - HIGHEST PRICE WITHIN EACH ROUTE
-- =========================================================

SELECT
    booking_id,
    route,
    ticket_price_inr,
    ROW_NUMBER() OVER (
        PARTITION BY route
        ORDER BY ticket_price_inr DESC
    ) AS route_price_rank
FROM airline_bookings;


-- =========================================================
-- Q15. LAG - COMPARE WITH PREVIOUS BOOKING PRICE
-- =========================================================

SELECT
    booking_date,
    ticket_price_inr,
    LAG(ticket_price_inr) OVER (
        ORDER BY booking_date, booking_id
    ) AS previous_ticket_price
FROM airline_bookings
ORDER BY booking_date, booking_id;

USE airline_project;


-- =========================================================
-- Q16. CANCELLATION RATE BY TRAVEL CLASS
-- =========================================================

SELECT
    travel_class,
    COUNT(*) AS total_bookings,
    SUM(cancelled) AS cancelled_bookings,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM airline_bookings
GROUP BY travel_class
ORDER BY cancellation_rate DESC;


-- =========================================================
-- Q17. BOOKINGS WITH ABOVE-AVERAGE ADVANCE BOOKING DAYS
-- =========================================================

SELECT
    booking_id,
    route,
    advance_booking_days,
    ticket_price_inr
FROM airline_bookings
WHERE advance_booking_days >
      (
          SELECT AVG(advance_booking_days)
          FROM airline_bookings
      )
ORDER BY advance_booking_days DESC;


-- =========================================================
-- Q18. CANCELLATION RATE BY ADVANCE BOOKING CATEGORY
-- =========================================================

SELECT
    CASE
        WHEN advance_booking_days <= 7 THEN '0-7 Days'
        WHEN advance_booking_days <= 30 THEN '8-30 Days'
        WHEN advance_booking_days <= 60 THEN '31-60 Days'
        ELSE '60+ Days'
    END AS booking_window,
    COUNT(*) AS total_bookings,
    SUM(cancelled) AS cancelled_bookings,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM airline_bookings
GROUP BY booking_window
ORDER BY cancellation_rate DESC;


-- =========================================================
-- Q19. NPS CATEGORY ANALYSIS
-- =========================================================

SELECT
    CASE
        WHEN nps_score < 7 THEN 'Detractor'
        WHEN nps_score < 9 THEN 'Passive'
        ELSE 'Promoter'
    END AS nps_category,
    COUNT(*) AS bookings,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM airline_bookings
GROUP BY nps_category
ORDER BY cancellation_rate DESC;


-- =========================================================
-- Q20. CANCELLATION BY LOUNGE ACCESS
-- =========================================================

SELECT
    lounge_access_used,
    COUNT(*) AS total_bookings,
    SUM(cancelled) AS cancelled_bookings,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM airline_bookings
GROUP BY lounge_access_used
ORDER BY cancellation_rate DESC;


-- =========================================================
-- Q21. HIGH LOAD FACTOR FLIGHTS
-- =========================================================

SELECT
    route,
    COUNT(*) AS bookings,
    ROUND(AVG(flight_load_factor_pct), 2) AS avg_load_factor,
    ROUND(AVG(cancelled) * 100, 2) AS cancellation_rate
FROM airline_bookings
GROUP BY route
HAVING AVG(flight_load_factor_pct) > 80
ORDER BY avg_load_factor DESC;


-- =========================================================
-- Q22. PRICE DIFFERENCE FROM COMPETITOR
-- =========================================================

SELECT
    booking_id,
    route,
    travel_class,
    ticket_price_inr,
    competitor_avg_price_inr,
    ROUND(
        ticket_price_inr - competitor_avg_price_inr,
        2
    ) AS price_difference,
    CASE
        WHEN ticket_price_inr > competitor_avg_price_inr
            THEN 'Higher Than Competitor'
        WHEN ticket_price_inr < competitor_avg_price_inr
            THEN 'Lower Than Competitor'
        ELSE 'Same Price'
    END AS price_position
FROM airline_bookings;


-- =========================================================
-- Q23. TOP 10 MOST EXPENSIVE BOOKINGS
-- =========================================================

SELECT
    booking_id,
    route,
    travel_class,
    ticket_price_inr
FROM airline_bookings
ORDER BY ticket_price_inr DESC
LIMIT 10;


-- =========================================================
-- Q24. ROUTES WITH ABOVE-AVERAGE REVENUE
-- =========================================================

WITH route_revenue AS
(
    SELECT
        route,
        COUNT(*) AS bookings,
        SUM(ticket_price_inr) AS revenue
    FROM airline_bookings
    GROUP BY route
)
SELECT
    route,
    bookings,
    ROUND(revenue, 2) AS revenue
FROM route_revenue
WHERE revenue >
      (
          SELECT AVG(revenue)
          FROM route_revenue
      )
ORDER BY revenue DESC;


-- =========================================================
-- Q25. RANK ROUTES BY REVENUE
-- =========================================================

WITH route_revenue AS
(
    SELECT
        route,
        COUNT(*) AS bookings,
        SUM(ticket_price_inr) AS revenue
    FROM airline_bookings
    GROUP BY route
)
SELECT
    route,
    bookings,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM route_revenue
ORDER BY revenue_rank;








