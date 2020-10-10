---Question1---
CREATE OR REPLACE PROCEDURE p6q1 AS
    CURSOR faculty_curr IS
      SELECT f_id, f_last, f_first, f_rank
      FROM faculty;
      v_f_id faculty.f_id%TYPE;
      v_f_last faculty.f_last%TYPE;
      v_f_first faculty.f_first%TYPE;
      v_f_rank faculty.f_rank%TYPE;
      
    CURSOR student_curr (p_f_id NUMBER) IS
       SELECT s_id, s_last, s_first, s_dob, s_class
       FROM student
       WHERE f_id = p_f_id;
       v_s_id student.s_id%TYPE;
       v_s_last student.s_last%TYPE;
       v_s_first student.s_first%TYPE;
       v_s_dob student.s_dob%TYPE;
       v_s_class student.s_class%TYPE;

BEGIN
    OPEN faculty_curr;
    FETCH faculty_curr INTO v_f_id, v_f_last, v_f_first, v_f_rank;
    WHILE faculty_curr%FOUND LOOP
       DBMS_OUTPUT.PUT_LINE('-------------------------------');
       DBMS_OUTPUT.PUT_LINE('Faculty : ' || v_f_id || ' Last name : ' || v_f_last || ' First name : ' || v_f_first || ' Rank : ' || v_f_rank);
   
       OPEN student_curr(v_f_id);
       FETCH student_curr INTO v_s_id, v_s_last, v_s_first, v_s_dob, v_s_class ;
       WHILE student_curr%FOUND LOOP
          DBMS_OUTPUT.PUT_LINE(' Student number ' || v_s_id || ' is ' || v_s_first  ||  v_s_last || ' Birthdate is ' || v_s_dob || ' Class is ' || v_s_class);
          FETCH student_curr INTO v_s_id, v_s_last, v_s_first, v_s_dob, v_s_class ;
      END LOOP;
      CLOSE student_curr;
      FETCH faculty_curr INTO v_f_id, v_f_last, v_f_first, v_f_rank;
   END LOOP;
   CLOSE faculty_curr;
END;
/


---Question2---
CREATE OR REPLACE PROCEDURE p6q2 AS
   CURSOR consultant_curr IS
      SELECT c_id
      FROM consultant;
      v_c_id consultant.c_id%TYPE;
   
   CURSOR consultant_skill_curr(p_c_id NUMBER)IS
      SELECT skill_id, certification
      FROM consultant_skill
      WHERE c_id = p_c_id;
      v_skill_id consultant_skill.skill_id%TYPE;
      v_certification consultant_skill.certification%TYPE;
   
       v_skill_description skill.skill_description%TYPE;

BEGIN
      OPEN consultant_curr;
      FETCH consultant_curr INTO v_c_id;
      WHILE consultant_curr%FOUND  LOOP
          DBMS_OUTPUT.PUT_LINE('--------------------------');
          DBMS_OUTPUT.PUT_LINE('Consultant number : ' || v_c_id);
          
          OPEN consultant_skill_curr(v_c_id);
          FETCH consultant_skill_curr INTO v_skill_id, v_certification;
          WHILE consultant_skill_curr%FOUND LOOP
                SELECT skill_description INTO v_skill_description FROM skill WHERE skill_id =  v_skill_id;
                DBMS_OUTPUT.PUT_LINE(' Skill description : ' || v_skill_description  || '   Certification : ' || v_certification);
                FETCH consultant_skill_curr INTO v_skill_id, v_certification;
          END LOOP;
          CLOSE consultant_skill_curr;
          FETCH consultant_curr INTO v_c_id;
      END LOOP;
     CLOSE consultant_curr;
END;
/


---Question3---
CREATE OR REPLACE PROCEDURE p6q3 AS
   CURSOR item_curr IS
      SELECT item_id, item_desc, cat_id
      FROM item;
      v_item_id item.item_id%TYPE;
      v_item_desc item.item_desc%TYPE;
      v_cat_id item.cat_id%TYPE;
   
   CURSOR inventory_curr(p_item_id NUMBER) IS
      SELECT inv_id, color, inv_size, inv_price, inv_qoh
      FROM inventory
      WHERE item_id = p_item_id;
      v_inv_id inventory.inv_id%TYPE;
      v_inv_size inventory.inv_size%TYPE;
      v_color inventory.color%TYPE;
      v_inv_price inventory.inv_price%TYPE;
      v_inv_qoh inventory.inv_qoh%TYPE;

BEGIN
    OPEN item_curr;
    FETCH item_curr INTO v_item_id, v_item_desc, v_cat_id;
    WHILE item_curr%FOUND LOOP
       DBMS_OUTPUT.PUT_LINE('--------------------------');
       DBMS_OUTPUT.PUT_LINE('Item number : ' ||  v_item_id  ||  '  Item description :  ' || v_item_desc || '  Cat number : ' ||  v_cat_id);
       
       OPEN inventory_curr(v_item_id);
       FETCH inventory_curr INTO v_inv_id, v_color, v_inv_size, v_inv_price, v_inv_qoh;
       WHILE inventory_curr%FOUND LOOP
         DBMS_OUTPUT.PUT_LINE('Inventory number : ' ||  v_inv_id  ||  '  Color :  ' || v_color || ' Size : ' ||  v_inv_size ||  ' Price : ' || v_inv_price || ' Quantity on hand : ' || v_inv_qoh);  
         FETCH inventory_curr INTO v_inv_id, v_color, v_inv_size, v_inv_price, v_inv_qoh;
       END LOOP;
       CLOSE inventory_curr;
    FETCH item_curr INTO v_item_id, v_item_desc, v_cat_id;
    END LOOP;
   CLOSE item_curr;
END;
/



---Question4---
CREATE OR REPLACE PROCEDURE p6q4 AS
   CURSOR item_curr IS
      SELECT item_id, item_desc, cat_id
      FROM item;
      v_item_id item.item_id%TYPE;
      v_item_desc item.item_desc%TYPE;
      v_cat_id item.cat_id%TYPE;
   
   CURSOR inventory_curr(p_item_id NUMBER) IS
      SELECT inv_id, color, inv_size, inv_price, inv_qoh
      FROM inventory
      WHERE item_id = p_item_id;
      v_inv_id inventory.inv_id%TYPE;
      v_inv_size inventory.inv_size%TYPE;
      v_color inventory.color%TYPE;
      v_inv_price inventory.inv_price%TYPE;
      v_inv_qoh inventory.inv_qoh%TYPE;
      value NUMBER := 0;

BEGIN
    OPEN item_curr;
    FETCH item_curr INTO v_item_id, v_item_desc, v_cat_id;
    WHILE item_curr%FOUND LOOP
       DBMS_OUTPUT.PUT_LINE('--------------------------');
        
       OPEN inventory_curr(v_item_id);
       FETCH inventory_curr INTO v_inv_id, v_color, v_inv_size, v_inv_price, v_inv_qoh;
       WHILE inventory_curr%FOUND LOOP
          value := value + v_inv_price * v_inv_qoh;
         DBMS_OUTPUT.PUT_LINE('Inventory number : ' ||  v_inv_id  ||  '  Color :  ' || v_color || ' Size : ' ||  v_inv_size ||  ' Price : ' || v_inv_price || ' Quantity on hand : ' || v_inv_qoh);  
         FETCH inventory_curr INTO v_inv_id, v_color, v_inv_size, v_inv_price, v_inv_qoh;
       END LOOP;
       
       DBMS_OUTPUT.PUT_LINE('Item number : ' ||  v_item_id  ||  '  Item description :  ' || v_item_desc || '  Item value : ' || value || '  Cat number : ' ||  v_cat_id);
       CLOSE inventory_curr;
    FETCH item_curr INTO v_item_id, v_item_desc, v_cat_id;
    END LOOP;
   CLOSE item_curr;
END;
/


           
---Question5---
CREATE OR REPLACE PROCEDURE p6q5(p_c_id NUMBER, p_certification VARCHAR2) AS
   
   CURSOR consultant_skill_curr(p_c_id NUMBER)IS
      SELECT skill_id, certification
      FROM consultant_skill
      WHERE c_id = p_c_id
      FOR UPDATE OF certification;
      v_skill_id consultant_skill.skill_id%TYPE;
      v_certification consultant_skill.certification%TYPE;
   
       v_skill_description skill.skill_description%TYPE;
       v_c_last consultant.c_last%TYPE;
       v_c_first consultant.c_first%TYPE;
       v_c_email consultant.c_email%TYPE;

BEGIN
      SELECT c_last, c_first, c_email INTO v_c_last, v_c_first, v_c_email FROM consultant WHERE c_id = p_c_id;
      DBMS_OUTPUT.PUT_LINE('--------------------------');
      DBMS_OUTPUT.PUT_LINE('Consultant number : ' || p_c_id || ' First name : ' ||  v_c_first || '  Last name : ' || v_c_last || '  Email : ' || v_c_email);
      
      OPEN consultant_skill_curr(p_c_id);
      FETCH consultant_skill_curr INTO v_skill_id, v_certification;
      WHILE consultant_skill_curr%FOUND LOOP
         SELECT skill_description INTO v_skill_description FROM skill WHERE skill_id =  v_skill_id;
         DBMS_OUTPUT.PUT_LINE(' Skill description : ' || v_skill_description  || '   Old certification : ' || v_certification || '  New certification : ' || p_certification);
         UPDATE consultant_skill SET certification = p_certification WHERE CURRENT OF consultant_skill_curr;
         FETCH consultant_skill_curr INTO v_skill_id, v_certification;
     END LOOP;
     CLOSE consultant_skill_curr;
     COMMIT;
END;
/

       
 