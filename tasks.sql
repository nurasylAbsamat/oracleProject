
declare 
    v_stud_id varchar(100);
    v_total_gpa float(7);
BEGIN
    v_stud_id := 'FA2AC9DF48A0D4152A5EED30277E6AF2A4712CB5';
    total_gpa(v_stud_id, v_total_gpa);
    dbms_output.put_line(v_total_gpa||'Hello');
END;

DECLARE 
    v_stud_id Course_selections.stud_id%TYPE;
    v_term NUMBER;
    v_year NUMBER;
    v_num number;
    v_credits number;
    v_total float(7);
    BEGIN 
     v_stud_id:='FA2AC9DF48A0D4152A5EED30277E6AF2A4712CB5';
     v_term:=1;
     v_year:=2018;
     find_sub_1(v_stud_id,v_term,v_year, v_total);
    DBMS_OUTPUT.PUT_LINE(v_total);

END;

SET SERVEROUTPUT ON;

declare 
    cursor cur_pop_ders(c_year int, c_term int) IS 
        SELECT DISTINCT ders_kod, term, year, 
        countdersbytermyear(ders_kod, term, year) as num_registered, practice 
        FROM course_selections WHERE year= c_year AND term = c_term AND ROWNUM<=100 ORDER BY num_registered desc;
        
    rec_pop cur_pop_ders%ROWTYPE;
BEGIN
    open cur_pop_ders(2019, 1);
    LOOP
        fetch cur_pop_ders INTO rec_pop;
        EXIT WHEN cur_pop_ders%notfound;
        dbms_output.put_line(rec_pop.ders_kod||' '||rec_pop.practice||' '||rec_pop.num_registered);
        
    END LOOP;
    CLOSE cur_pop_ders;
END;


DECLARE 
 v_stud_id Course_selections.stud_id%TYPE;
    v_term int;
    v_year int;
    v_result int;
BEGIN
     v_stud_id:='C5428D127389AF64AD12D33D86BA7DBC2E2D9B23';
     v_term:=2;
     v_year:=2019;
     v_result:=find_retakes(v_stud_id,v_term,v_year);
     DBMS_OUTPUT.PUT_LINE('The sum for 1 semester is : '||v_result);
END;


DECLARE 
 v_stud_id Course_selections.stud_id%TYPE;

    v_result NUMBER;
BEGIN
      v_stud_id:='B0BFCA1E50BFE669E8A0FD205A1932D841B69D9E';

     v_result:=find_retakes2(v_stud_id);
     DBMS_OUTPUT.PUT_LINE('The sum for 1 semester is : '||v_result);
END;

DECLARE 
    v_id int;
    v_term INT;
    v_year INT;
    v_result int;
BEGIN 
    v_id :=10166;
    v_term:=1;
    v_year:=2015;
    v_result:=find_teach(v_id,v_term,v_year);
    DBMS_OUTPUT.PUT_LINE('The hours: '||v_result);
END;