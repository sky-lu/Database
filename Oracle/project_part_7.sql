----Question1----
CREATE OR REPLACE PROCEDURE p7q1 AS
    CURSOR faculty_curr IS
      SELECT f_id, f_last, f_first, f_rank
      FROM faculty;
      
    CURSOR student_curr (p_f_id NUMBER) IS
       SELECT s_id, s_last, s_first, s_dob, s_class
       FROM student
       WHERE f_id = p_f_id;
       
BEGIN 
       FOR fac_index IN faculty_curr LOOP
       DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------------');
       DBMS_OUTPUT.PUT_LINE('Faculty : ' || fac_index.f_id || ' Last name : ' || fac_index.f_last || ' First name : ' || fac_index.f_first || ' Rank : ' || fac_index.f_rank);
           FOR stu_index IN student_curr(fac_index.f_id) LOOP
               DBMS_OUTPUT.PUT_LINE(' Student number ' || stu_index.s_id || ' is ' || stu_index.s_first   ||   stu_index.s_last || ' Birthdate is ' || stu_index.s_dob || ' Class is ' || stu_index.s_class);
           END LOOP;
        END LOOP;
END;
/


----Question2----
CREATE OR REPLACE PROCEDURE p7q2 AS
   CURSOR consultant_curr IS
      SELECT c_id
      FROM consultant;
     v_consultant_row consultant_curr%ROWTYPE;
   
   CURSOR consultant_skill_curr(p_c_id NUMBER)IS
      SELECT skill_id, certification
      FROM consultant_skill
      WHERE c_id = p_c_id;
      v_consultant_skill_row consultant_skill_curr%ROWTYPE;
   
       v_skill_description skill.skill_description%TYPE;

BEGIN
      OPEN consultant_curr;
      FETCH consultant_curr INTO v_consultant_row;
      WHILE consultant_curr%FOUND  LOOP
          DBMS_OUTPUT.PUT_LINE('--------------------------');
          DBMS_OUTPUT.PUT_LINE('Consultant number : ' || v_consultant_row.c_id);
          
          OPEN consultant_skill_curr(v_consultant_row.c_id);
          FETCH consultant_skill_curr INTO v_consultant_skill_row ;
          WHILE consultant_skill_curr%FOUND LOOP
                SELECT skill_description INTO v_skill_description FROM skill WHERE skill_id =  v_consultant_skill_row.skill_id;
                DBMS_OUTPUT.PUT_LINE(' Skill description : ' || v_skill_description  || '   Certification : ' || v_consultant_skill_row.certification);
                FETCH consultant_skill_curr INTO v_consultant_skill_row;
          END LOOP;
          CLOSE consultant_skill_curr;
          FETCH consultant_curr INTO v_consultant_row;
      END LOOP;
     CLOSE consultant_curr;
END;
/



----Question3----
CREATE OR REPLACE PROCEDURE p7q3 AS

BEGIN 
       FOR item_index IN (SELECT item_id, item_desc, cat_id FROM item) LOOP
       DBMS_OUTPUT.PUT_LINE('--------------------------');
       DBMS_OUTPUT.PUT_LINE('Item number : ' ||  item_index.item_id  ||  '  Item description :  ' || item_index.item_desc || '  Cat number : ' ||  item_index.cat_id);
           FOR inv_index IN (SELECT inv_id, color, inv_size, inv_price, inv_qoh FROM inventory WHERE item_id = item_index.item_id) LOOP
              DBMS_OUTPUT.PUT_LINE('Inventory number : ' ||  inv_index.inv_id  ||  '  Color :  ' || inv_index.color || ' Size : ' ||  inv_index.inv_size ||  ' Price : ' || inv_index.inv_price || ' Quantity on hand : ' || inv_index.inv_qoh);  
           END LOOP;
     END LOOP;
  END;
/


----Question4----
CREATE OR REPLACE PROCEDURE p7q4 AS
value NUMBER := 0;
BEGIN 
       FOR item_index IN (SELECT item_id, item_desc, cat_id FROM item) LOOP
       DBMS_OUTPUT.PUT_LINE('--------------------------');
           FOR inv_index IN (SELECT inv_id, color, inv_size, inv_price, inv_qoh FROM inventory WHERE item_id = item_index.item_id) LOOP
              DBMS_OUTPUT.PUT_LINE('Inventory number : ' ||  inv_index.inv_id  ||  '  Color :  ' || inv_index.color || ' Size : ' ||  inv_index.inv_size ||  ' Price : ' || inv_index.inv_price || ' Quantity on hand : ' || inv_index.inv_qoh);  
              value := value + inv_index.inv_price * inv_index.inv_qoh;
           END LOOP;
       DBMS_OUTPUT.PUT_LINE('Item number : ' ||  item_index.item_id  ||  '  Item description :  ' || item_index.item_desc || '  Item value : ' || value || '  Cat number : ' ||  item_index.cat_id);
     END LOOP;
  END;
/