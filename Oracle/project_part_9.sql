----Question1----
CREATE OR REPLACE PACKAGE p9q1_package IS
     PROCEDURE customer_insert(p_c_last VARCHAR2, p_c_address VARCHAR2);
     PROCEDURE customer_insert(p_c_last VARCHAR2, p_c_birthdate date);
     PROCEDURE customer_insert(p_c_last VARCHAR2, p_c_first VARCHAR2, p_c_birthdate date);
     PROCEDURE customer_insert(p_c_id NUMBER, p_c_last VARCHAR2, p_c_birthdate date);
END;
/
CREATE SEQUENCE c_id_seq START WITH 7;

CREATE OR REPLACE PACKAGE BODY p9q1_package IS
     PROCEDURE customer_insert(p_c_last VARCHAR2, p_c_address VARCHAR2) AS
     BEGIN
          INSERT INTO customer (c_id, c_last, c_address)
          VALUES (c_id_seq.NEXTVAL, p_c_last, p_c_address);
          COMMIT;
     END;
     
     PROCEDURE customer_insert(p_c_last VARCHAR2, p_c_birthdate date) AS
     BEGIN
          INSERT INTO customer (c_id, c_last, c_birthdate)
          VALUES (c_id_seq.NEXTVAL, p_c_last, p_c_birthdate );
          COMMIT;
     END;
     
     PROCEDURE customer_insert(p_c_last VARCHAR2, p_c_first VARCHAR2, p_c_birthdate date) AS
     BEGIN
          INSERT INTO customer (c_id, c_last, c_first, c_birthdate)
          VALUES (c_id_seq.NEXTVAL, p_c_last, p_c_first, p_c_birthdate );
          COMMIT;
     END;

     PROCEDURE customer_insert(p_c_id NUMBER, p_c_last VARCHAR2, p_c_birthdate date) AS
     BEGIN
          INSERT INTO customer (c_id, c_last, c_birthdate)
          VALUES (p_c_id, p_c_last, p_c_birthdate);
          COMMIT;
     END;
END;
/

----Testing----
exec p9q1_package.customer_insert('Duyen', '1234 Sherbrook');
exec p9q1_package.customer_insert('Chohan',  to_date('11/14/1988', 'mm/dd/yyyy'));
exec p9q1_package.customer_insert('Lu', 'Honglin',  to_date('11/24/1990', 'mm/dd/yyyy'));
exec p9q1_package.customer_insert(20, 'Cao',  to_date('01/24/1959', 'mm/dd/yyyy'));






----Question2----
CREATE OR REPLACE PACKAGE p9q2_package IS
     PROCEDURE student_insert(p_s_id NUMBER, p_s_last VARCHAR2, p_s_dob date);
     PROCEDURE student_insert(p_s_last VARCHAR2, p_s_dob date);
     PROCEDURE student_insert(p_s_last VARCHAR2, p_s_address VARCHAR2);
     PROCEDURE student_insert(p_s_last VARCHAR2, p_s_first VARCHAR2, p_s_dob date, p_f_id NUMBER);
END;
/

CREATE SEQUENCE student_seq START WITH 7;

CREATE OR REPLACE PACKAGE BODY p9q2_package IS
     PROCEDURE student_insert(p_s_id NUMBER, p_s_last VARCHAR2, p_s_dob date) AS
     v_s_id NUMBER;
     BEGIN
        SELECT s_id
        INTO v_s_id
        FROM student
        WHERE s_id = p_s_id;
         
        DBMS_OUTPUT.PUT_LINE('Student Id : ' ||  p_s_id || ' already exits ');
    EXCEPTION
         WHEN NO_DATA_FOUND THEN
            IF p_s_dob < sysdate THEN
                INSERT INTO student(s_id, s_last, s_dob)
                VALUES (p_s_id, p_s_last, p_s_dob);
                 COMMIT;
           ELSE
                 DBMS_OUTPUT.PUT_LINE(' The date of birth is not valid, check again.');
           END IF;
     END;

     PROCEDURE student_insert(p_s_last VARCHAR2, p_s_dob date) AS
     BEGIN
         IF p_s_dob < sysdate THEN
             INSERT INTO student(s_id, s_last, s_dob)
             VALUES (student_seq.NEXTVAL, p_s_last, p_s_dob);
             COMMIT;
          ELSE
              DBMS_OUTPUT.PUT_LINE(' The date of birth is not valid, check again.');
           END IF;
      END;
         

     PROCEDURE student_insert(p_s_last VARCHAR2, p_s_address VARCHAR2) AS
     BEGIN
         INSERT INTO student(s_id, s_last, s_address)
         VALUES (student_seq.NEXTVAL, p_s_last, p_s_address);
         COMMIT;
      END;


     PROCEDURE student_insert(p_s_last VARCHAR2, p_s_first VARCHAR2, p_s_dob date, p_f_id NUMBER) AS
     v_f_id NUMBER;
     BEGIN
          SELECT f_id
          INTO v_f_id
          FROM faculty
          WHERE f_id = p_f_id;
           
          IF p_s_dob < sysdate THEN
                INSERT INTO student(s_id, s_last, s_first, s_dob, f_id)
                VALUES (student_seq.NEXTVAL, p_s_last, p_s_first, p_s_dob, p_f_id);
                 COMMIT;
           ELSE
                 DBMS_OUTPUT.PUT_LINE(' The date of birth is not valid, check again.');
           END IF;
          
     EXCEPTION
         WHEN NO_DATA_FOUND THEN
           DBMS_OUTPUT.PUT_LINE('Faculty number : ' ||  p_f_id || ' does not exit. '); 
      END;
    
END;
/

----Testing----
exec p9q2_package.student_insert(9, 'Lu', to_date('11/24/1990', 'mm/dd/yyyy') );
exec p9q2_package.student_insert(2, 'Lu', to_date('11/24/1990', 'mm/dd/yyyy') );
exec p9q2_package.student_insert(10, 'Lu', to_date('11/24/2090', 'mm/dd/yyyy') );

exec p9q2_package.student_insert('Chohan', to_date('10/24/1990', 'mm/dd/yyyy') );
exec p9q2_package.student_insert('Chohan', to_date('10/24/2090', 'mm/dd/yyyy') );

exec p9q2_package.student_insert('Cao', '2345 Saint Michiel');

exec p9q2_package.student_insert('Mary', 'Brown', to_date('09/14/1980', 'mm/dd/yyyy'), 10);
exec p9q2_package.student_insert('Mary', 'Brown', to_date('09/14/2080', 'mm/dd/yyyy'), 1);
exec p9q2_package.student_insert('Mary', 'Brown', to_date('09/14/1980', 'mm/dd/yyyy'), 2);
exec p9q2_package.student_insert('Helen', 'Thomas', to_date('09/04/1980', 'mm/dd/yyyy'), 1);
