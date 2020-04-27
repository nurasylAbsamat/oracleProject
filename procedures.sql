create or replace PROCEDURE find_sub_1 (p_stud_id Course_selections.stud_id%TYPE,p_term NUMBER,
p_year NUMBER, p_total out float) IS 
v_subject VARCHAR(7);
v_credits float DEFAULT 0;
v_sum_subjects float DEFAULT 0;
v_sum_credits float DEFAULT 0;
v_points float;
CURSOR find_gpa (p_stud_id Course_selections.stud_id%TYPE,
    p_term Course_selections.term%TYPE,p_year Course_selections.year%TYPE) IS
    select qiymet_herf,credits from course_selections sl INNER JOIN course_sections s ON  
    sl.year = s.year and s.ders_kod = sl.ders_kod and sl.term = s.term AND s.section = sl.section 
    where stud_id = p_stud_id AND s.year = p_year and sl.term = p_term;
BEGIN 
 FOR i in find_gpa(p_stud_id, p_term, p_year) 
 LOOP
  IF i.qiymet_herf is null THEN v_subject :='dsa';
  ELSE v_subject := i.qiymet_herf;
  END IF;
  IF i.credits is null THEN v_credits:=3;
  ELSE v_credits := i.credits;
  END IF;
  IF v_subject is null THEN v_points := 0;
    ELSIF v_subject='A' THEN v_points:=4.00;
    ELSIF v_subject='A-' THEN v_points:=3.70;
    ELSIF v_subject='B+' THEN v_points:=3.33;
    ELSIF v_subject='B' THEN v_points:=3.00;
    ELSIF v_subject='B-' THEN v_points:=2.70;
    ELSIF v_subject='C+' THEN v_points:=2.33;
    ELSIF v_subject='C' THEN v_points:=2.00;
    ELSIF v_subject='C-' THEN v_points:=1.70;
    ELSIF v_subject='D+' THEN v_points:=1.33;
    ELSIF v_subject='D' THEN v_points:=1.00;
    ELSIF v_subject='D-' THEN v_points:=0.70;
    ELSE v_points:=0.00;
    END IF;

  v_sum_credits:=v_sum_credits+v_credits;
  v_sum_subjects:=v_sum_subjects+v_points*v_credits;
  END LOOP;
  p_total := v_sum_subjects / v_sum_credits;
  END;
  
  
  
create or replace PROCEDURE total_GPA
( p_stud_id varchar, p_gpa OUT float
) IS
    CURSOR cur_stud IS 
        SELECT distinct year, term FROM course_selections WHERE stud_id= p_stud_id;
    v_spa float(7);
    v_total float(7) DEFAULT 0;
    rec_stud cur_stud%ROWTYPE;
BEGIN
    open cur_stud;
    LOOP
        FETCH cur_stud into rec_stud;
        EXIT WHEN cur_stud%NOTFOUND;
        find_sub_1(p_stud_id, rec_stud.term, rec_stud.year, v_spa);  
        v_total := v_total + v_spa;
        dbms_output.put_line(v_total);
    END LOOP;
    p_gpa := v_total / cur_stud%ROWCOUNT;
    CLOSE cur_stud;
END;