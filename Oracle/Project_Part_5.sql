---Question1---
CREATE OR REPLACE PROCEDURE p5q1 AS
     CURSOR term_curr IS
       SELECT term_id, term_desc, status
       FROM term;
       v_term_id term.term_id%TYPE;
       v_term_desc term.term_desc%TYPE;
       v_status term.status%TYPE;
BEGIN
    OPEN term_curr;
    FETCH term_curr INTO v_term_id, v_term_desc, v_status;
      WHILE term_curr%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(' Term ID: ' || v_term_id || ' ; term desc : ' || v_term_desc || ' ; status: ' || v_status );
        FETCH term_curr INTO v_term_id, v_term_desc, v_status;
      END LOOP;
   CLOSE term_curr;
END;
/

---Question2---
CREATE OR REPLACE PROCEDURE p5q2 AS
    CURSOR item_curr IS
     SELECT item_desc, color, inv_price, inv_qoh
     FROM item, inventory
     WHERE item.item_id = inventory.item_id;
     v_item_desc item.item_desc%TYPE;
     v_color inventory.color%TYPE;
     v_inv_price inventory.inv_price%TYPE;
     v_inv_qoh inventory.inv_qoh%TYPE;
BEGIN
     OPEN item_curr;
     FETCH item_curr INTO v_item_desc, v_color, v_inv_price, v_inv_qoh;
        WHILE item_curr%FOUND LOOP
          DBMS_OUTPUT.PUT_LINE('Item description : ' || v_item_desc || ' ; color : ' || v_color || ' ; price : ' || v_inv_price || ' ; quantity on hand : ' || v_inv_qoh);
          FETCH item_curr INTO v_item_desc, v_color, v_inv_price, v_inv_qoh;
       END LOOP;
    CLOSE item_curr;
END;
/

---Question3---
CREATE OR REPLACE PROCEDURE p5q3 (percentage NUMBER) AS
    CURSOR price_curr IS
       SELECT inv_price
       FROM inventory
       FOR UPDATE of inv_price;
       v_inv_price inventory.inv_price%TYPE;
       new_price inventory.inv_price%TYPE;
BEGIN
      OPEN price_curr;
      FETCH price_curr INTO v_inv_price;
        WHILE price_curr%FOUND LOOP
            new_price := v_inv_price + v_inv_price * percentage * 0.01;
            DBMS_OUTPUT.PUT_LINE(' Old price : ' || v_inv_price || ' New price : ' || new_price);
            UPDATE inventory
            SET inv_price = new_price
            WHERE CURRENT OF price_curr;
           FETCH price_curr INTO v_inv_price;
       END LOOP;
    CLOSE price_curr;
 COMMIT;
END;
/

---Question4---
CREATE OR REPLACE PROCEDURE p5q4 (num NUMBER) AS
     CURSOR emp_curr IS
       SELECT ename, sal
       FROM emp
       ORDER BY 2 DESC;
       v_ename emp.ename%TYPE;
       v_sal emp.sal%TYPE;
       v_counter NUMBER := 1;
BEGIN
     OPEN emp_curr; 
     DBMS_OUTPUT.PUT_LINE(' Top ' || num || ' employees are ');
     WHILE v_counter <= num LOOP
       FETCH emp_curr INTO v_ename, v_sal;
       IF emp_curr%FOUND THEN
          DBMS_OUTPUT.PUT_LINE(v_ename);
       END IF;
       v_counter := v_counter + 1;
    END LOOP;
  CLOSE emp_curr;
END;
/


---Question5---
CREATE OR REPLACE PROCEDURE p5q5 (num NUMBER) AS
    CURSOR sal_curr IS
     SELECT DISTINCT sal
     FROM emp
     ORDER BY 1 DESC;
     v_sal emp.sal%TYPE;
     v_counter NUMBER := 1;
        
    CURSOR emp_curr (p_sal NUMBER) IS
    SELECT ename
    FROM emp
    WHERE sal = p_sal;
    v_ename emp.ename%TYPE;

BEGIN
    OPEN sal_curr;
    DBMS_OUTPUT.PUT_LINE(' Employee who make the top ' ||  num || ' salary are ');
      WHILE v_counter <= num LOOP
        FETCH sal_curr INTO v_sal;
         OPEN emp_curr(v_sal);
           FETCH emp_curr INTO v_ename;
            WHILE emp_curr%FOUND LOOP
               DBMS_OUTPUT.PUT_LINE(v_ename);
               FETCH emp_curr INTO v_ename;
            END LOOP;
         CLOSE emp_curr;
        v_counter := v_counter + 1;
      END LOOP;
   CLOSE sal_curr;
END;
/

        
    

     

  
