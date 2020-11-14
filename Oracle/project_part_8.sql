----Question1----
CREATE OR REPLACE PACKAGE duyen IS
    global_inv_id NUMBER(6);
    global_quantity NUMBER(6);
    FUNCTION compare_quantity(old_inv_qoh NUMBER, current_ol_quantity NUMBER) RETURN Boolean;
    PROCEDURE create_new_line(current_o_id NUMBER);
END;
/

CREATE OR REPLACE PACKAGE BODY duyen IS
    FUNCTION compare_quantity(old_inv_qoh NUMBER, current_ol_quantity NUMBER) RETURN BOOLEAN AS
    BEGIN
          IF old_inv_qoh >= current_ol_quantity THEN
               RETURN true;
          ELSE
               RETURN false;
          END IF;
     END compare_quantity;
     
    PROCEDURE create_new_line(current_o_id NUMBER) AS
    old_inv_qoh NUMBER;
    new_inv_qoh NUMBER;
    new_ol_quantity NUMBER;
    BEGIN 
        SELECT inv_qoh
        INTO old_inv_qoh
        FROM inventory
        WHERE inv_id = global_inv_id;
       
        IF compare_quantity(old_inv_qoh, global_quantity) THEN
            new_inv_qoh := old_inv_qoh - global_quantity;
            new_ol_quantity := global_quantity;
        ELSE
            new_inv_qoh := 0;
            new_ol_quantity := old_inv_qoh;
            DBMS_OUTPUT.PUT_LINE(' Inventory quantity is not enough, we will supply soon ! ');
        END IF;
        INSERT INTO order_line VALUES(current_o_id, global_inv_id, new_ol_quantity);
        UPDATE inventory SET inv_qoh = new_inv_qoh WHERE inv_id = global_inv_id;
        COMMIT;
      EXCEPTION
       WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE(' Inventory number ' || global_inv_id || ' does not exist MY FRIEND, try again! ');
        END  create_new_line;
END;
/
 ----TEST PACKAGE---
BEGIN
       duyen.global_inv_id := 26;
       duyen.global_quantity :=20 ;
     END;
     /

BEGIN
      duyen.create_new_line(2);
END;
/


----Question2----
CREATE OR REPLACE PACKAGE duyen IS
    PROCEDURE create_consultant_skill( current_c_id NUMBER, current_skill_id NUMBER, current_certification VARCHAR2);
END;
/
CREATE OR REPLACE PACKAGE BODY duyen IS
   PROCEDURE create_consultant_skill( current_c_id NUMBER, current_skill_id NUMBER, current_certification VARCHAR2) AS
       v_c_last consultant.c_last%type;
       v_c_first consultant.c_first%type;
       v_skill_description skill.skill_description%type;
       v_certification consultant_skill.certification%type;
       v_counter NUMBER := 0;
       BEGIN
        IF current_certification = 'Y' OR current_certification = 'N' THEN
          SELECT c_last, c_first
          INTO v_c_last, v_c_first
          FROM consultant
          WHERE c_id = current_c_id;
          
           v_counter := 1;
          SELECT skill_description
          INTO v_skill_description
          FROM skill
          WHERE skill_id = current_skill_id;

          DBMS_OUTPUT.PUT_LINE('Consultant last name : ' || v_c_last);
          DBMS_OUTPUT.PUT_LINE('Consultant first name : ' || v_c_first);
          DBMS_OUTPUT.PUT_LINE('Skill description : ' || v_skill_description);
           
           v_counter := 2;
           
           SELECT certification
           INTO v_certification
           FROM consultant_skill
           WHERE c_id = current_c_id AND skill_id = current_skill_id;
            DBMS_OUTPUT.PUT_LINE('Certificated or not : ' || v_certification );
        ELSE
           DBMS_OUTPUT.PUT_LINE('Please insert only Y or N');
    END IF;  

 EXCEPTION
      WHEN  NO_DATA_FOUND THEN
       IF v_counter = 0 THEN
          DBMS_OUTPUT.PUT_LINE('CONSULTANT number ' || current_c_id || ' does not exist my friend ' );
       ELSIF v_counter = 1 THEN
          DBMS_OUTPUT.PUT_LINE('SKILL number ' || current_skill_id || ' does not exist my friend ' );
       ELSIF v_counter = 2 THEN
          INSERT INTO consultant_skill VALUES (current_c_id , current_skill_id, current_certification );  
          COMMIT;
           DBMS_OUTPUT.PUT_LINE('Certificated or not : ' ||  current_certification);
       END IF;
END create_consultant_skill;
END;
/
   
 exec duyen.create_consultant_skill(105, 1, 'Y')