create or replace FUNCTION countDersByTermYear
(f_ders_kod in varchar, f_term int, f_year int)
RETURN int IS
countDers int;
BEGIN
    SELECT COUNT(ders_kod)INTO countders FROM course_selections 
    WHERE ders_kod = f_ders_kod AND term = f_term AND year = f_year;
    return countders;
END;