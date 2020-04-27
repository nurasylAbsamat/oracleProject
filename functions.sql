create or replace FUNCTION countDersByTermYear
(f_ders_kod in varchar, f_term int, f_year int)
RETURN int IS
countDers int;
BEGIN
    SELECT COUNT(ders_kod)INTO countders FROM course_selections 
    WHERE ders_kod = f_ders_kod AND term = f_term AND year = f_year;
    return countders;
END;

CREATE OR REPLACE FUNCTION find_retakes(p_stud_id Course_selections.stud_id%TYPE,p_term int,
p_year int) RETURN int IS
v_credits int default 0;
v_sum_retake_money int default 0;
v_retake BOOLEAN;
CURSOR find_retakes1 IS SELECT qiymet_yuz, credits FROM Course_selections sl INNER JOIN course_sections s ON  
    sl.year = s.year and s.ders_kod = sl.ders_kod and sl.term = s.term AND s.section = sl.section 
    where stud_id = p_stud_id AND s.year = p_year and sl.term = p_term;
BEGIN
 FOR i in find_retakes1 LOOP
    dbms_output.put_line(i.qiymet_yuz);


     IF i.qiymet_yuz<50 and i.qiymet_yuz is not null THEN 
        IF i.credits is null THEN v_credits:=3;
        else v_credits:=i.credits;
        END IF;
        v_sum_retake_money:=v_sum_retake_money+(v_credits*34000);
     else v_retake := false;
     END IF;   
   END LOOP;
   
   RETURN v_sum_retake_money;
END ;