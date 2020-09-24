--Question1--
CREATE OR REPLACE PROCEDURE p3q1(p_empno NUMBER) AS
    v_empno NUMBER := p_empno;
    v_dname VARCHAR2(100);
    v_deptno NUMBER;
    v_ename VARCHAR2(10); --- v_ename emp.ename%TYPE;---
    v_year_salary NUMBER;
    v_month_salary NUMBER;
    v_commission NUMBER;
BEGIN
     SELECT ename, sal, comm, deptno 
     INTO v_ename, v_month_salary, v_commission, v_deptno
     From emp
     WHERE empno = v_empno;
     v_year_salary := 12 * v_month_salary + NVL( v_commission, 0);
     SELECT dname
     INTO v_dname
     FROM dept
     WHERE deptno = v_deptno;    
  DBMS_OUTPUT.PUT_LINE('Employee number ' || v_empno || ' is ' ||
     v_ename || ' , he works in the department : ' || v_dname || ' and his annual salary is $' || v_year_salary);
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('Employee number ' || v_empno || ' does not exist MY FRIEND, try again! ');
END;
/


--Question2--
CREATE OR REPLACE PROCEDURE p3q2 (p_inv_id NUMBER) AS
      v_item_id NUMBER;
      v_item_desc VARCHAR2(30);
      v_inv_price NUMBER;
      v_color VARCHAR2(20);
      v_inv_qoh NUMBER;
      value NUMBER;
BEGIN
     SELECT item_id, inv_price, color, inv_qoh
     INTO v_item_id, v_inv_price, v_color, v_inv_qoh
     FROM inventory
     WHERE inv_id = p_inv_id;
     value := v_inv_price * v_inv_qoh;
     SELECT item_desc
     INTO v_item_desc
     FROM item
     WHERE item_id = v_item_id;
   DBMS_OUTPUT.PUT_LINE ( v_item_desc || ' Its price is $' || v_inv_price || ', its color is ' 
                                            ||  v_color || ', its quantity on hand is ' || v_inv_qoh || ' and its value is $' || value );
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('Inventory number ' || p_inv_id || ' does not exist MY FRIEND, try again! ');
END;
/


--Question3--
CREATE OR REPLACE FUNCTION find_age (p_dob DATE) RETURN NUMBER AS
     v_age NUMBER;
BEGIN
     SELECT TO_NUMBER(TO_CHAR(sysdate,'YYYY')-TO_CHAR(p_dob,'YYYY'))    --- v_age :=  FLOOR (sysdate - p_dob) / 365.25;---
     INTO v_age 
     FROM dual;
     RETURN v_age;
END;
/

SELECT find_age('18-OCT-90') FROM dual;

CREATE OR REPLACE PROCEDURE p3q3 (p_s_id NUMBER) AS
     v_last VARCHAR2(30);
     v_first VARCHAR2(30);
     v_dob DATE;
     s_age NUMBER;s
  BEGIN 
     SELECT s_last, s_first, s_dob
     INTO v_last, v_first, v_dob
     FROM student
     WHERE s_id = p_s_id;
     s_age := find_age(v_dob);
     DBMS_OUTPUT.PUT_LINE( ' Student nunmber ' || p_s_id || ' Name is ' || v_first  ||  v_last || ' Birthdate is ' || v_dob || ' Age is ' || s_age);
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('Student number ' || p_s_id || ' does not exist MY FRIEND, try again! ');
END;
/


--Question4--
CREATE OR REPLACE PROCEDURE p3q4 (p_c_id NUMBER, p_skill_id NUMBER, p_certification VARCHAR2) AS
v_c_last VARCHAR2(20);
v_c_first VARCHAR2(20);
v_skill_description VARCHAR2(20);
v_certification VARCHAR2(8);
BEGIN
    SELECT c_last, c_first
    INTO v_c_last, v_c_first
    FROM consultant
    WHERE c_id = p_c_id;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('Consultant number ' || p_c_id || ' does not exist MY FRIEND, try again! ');
    SELECT skill_description
    INTO v_skill_description
    FROM skill
    WHERE skill_id = p_skill_id;
   EXCEPTION
    WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('Skill number ' || p_skill_id || ' does not exist MY FRIEND, try again! ');
   SELECT certification
   INTO v_certification
   FROM consultant_skill
   WHERE c_id = p_c_id;
   DBMS_OUTPUT.PUT_LINE('UPDATE');
      UPDATE consultant_skill SET certification = p_certification WHERE c_id = p_c_id;
    COMMIT;
  EXCEPTION 
   WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('INSERT');
   INSERT INTO consultant_skill(c_id , skill_id, certification)
   VALUES (p_c_id, p_skill_id, p_certification);
  COMMIT;
  DBMS_OUTPUT.PUT_LINE(' Consultant''s last name is ' || v_c_last || ', first name is ' || v_c_first || ' skill description : ' || v_skill_description );
END;
/


---Question4 correction---
CREATE OR REPLACE PROCEDURE p_p3q4(p_c_id NUMBER, p_skill_id
    number, p_status VARCHAR2) AS
  v_c_last consultant.c_last%TYPE;
  v_c_first consultant.c_first%TYPE;
  v_skill_description skill.skill_description%TYPE;
  v_certification  consultant_skill.certification%TYPE;
 
   v_flag NUMBER := 0;

  BEGIN
IF p_status = 'Y' OR p_status = 'N' THEN

    SELECT c_last, c_first
    INTO   v_c_last, v_c_first
    FROM   consultant
    WHERE  c_id = p_c_id;

     v_flag := 1;
DBMS_OUTPUT.PUT_LINE('CONSULTANT FOUND');
    SELECT skill_description
    INTO   v_skill_description
    FROM   skill
    WHERE  skill_id = p_skill_id;

    v_flag := 2;
 DBMS_OUTPUT.PUT_LINE('SKILL FOUND');   

   SELECT certification
   INTO   v_certification
   FROM   consultant_skill
   WHERE  c_id = p_c_id AND skill_id = p_skill_id;

DBMS_OUTPUT.PUT_LINE('COMBINATION  FOUND -- UPDATE');

       IF v_certification <> p_status THEN
         UPDATE consultant_skill
         SET   certification = p_status
         WHERE  c_id = p_c_id AND skill_id = p_skill_id;
       ELSE
        DBMS_OUTPUT.PUT_LINE('Nothing to update my friend');
       END IF;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Please insert only Y or N');
   END IF;
EXCEPTION
WHEN  NO_DATA_FOUND THEN
   IF v_flag = 0 THEN
DBMS_OUTPUT.PUT_LINE('CONSULTANT number ' || p_C_ID ||
          ' does not exist my friend Kani' );
   ELSIF v_flag = 1 THEN
DBMS_OUTPUT.PUT_LINE('SKILL number ' || p_skill_ID ||
          ' does not exist my friend Kani' );
   ELSIF v_flag = 2 THEN
DBMS_OUTPUT.PUT_LINE('combination not exist my friend Kani INSERT' );
   INSERT INTO consultant_skill
   VALUES (p_c_id , p_skill_id, p_status );  

END IF;
COMMIT;
END;
/

set serveroutput on
exec p_p3q4(99,5,'Y')



    
    
   


   
      