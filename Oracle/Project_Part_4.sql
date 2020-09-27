---Question1---
CREATE OR REPLACE PROCEDURE p_compare ( n1 NUMBER, n2 NUMBER, result OUT VARCHAR2) AS
v_result VARCHAR2(15);
BEGIN
    IF n1 = n2 THEN
       v_result := 'EQUAL';
    ELSE
       v_result := 'DIFFERENT';
    END IF;
    result := v_result;
END;
/

CREATE OR REPLACE PROCEDURE p_calculate ( side1_area IN OUT NUMBER, side2_perimeter IN OUT NUMBER) AS
side1 NUMBER := side1_area;
side2 NUMBER := side2_perimeter;
BEGIN
    side1_area := side1 * side2;
    side2_perimeter := (side1 +side2) * 2;
END;
/

CREATE OR REPLACE PROCEDURE p4q1 (n1 NUMBER, n2 NUMBER) AS
result VARCHAR2(15);
v_n1 NUMBER := n1;
v_n2 NUMBER := n2;
area NUMBER;
perimeter NUMBER;
BEGIN 
    p_compare(n1, n2 , result);
    p_caculate(v_n1, v_n2);
    area := v_n1 ;
    perimeter := v_n2;
     IF result = 'EQUAL' THEN
       DBMS_OUTPUT.PUT_LINE(' The area of a square size ' ||  n1  || ' by ' ||  n2  || ' is ' ||  area  || ' . It''s perimeter is ' ||  perimeter || '.' );
    ELSE
       DBMS_OUTPUT.PUT_LINE(' The area of a rectangle size ' ||  n1 || ' by ' || n2 || ' is ' ||   area || ' . It''s perimeter is ' ||  perimeter  || '. ');
    END IF;
END;
/


---Question2---
CREATE OR REPLACE PROCEDURE pseudo_fun ( height_area IN OUT NUMBER, width_perimeter IN OUT NUMBER) AS
height NUMBER := height_area;
width NUMBER := width_perimeter;
BEGIN
    height_area := height * width;
    width_perimeter := (height + width) * 2;
END;
/

CREATE OR REPLACE PROCEDURE p4q2 (n1 NUMBER, n2 NUMBER) AS
result VARCHAR2(15);
v_n1 NUMBER := n1;
v_n2 NUMBER := n2;
area NUMBER;
perimeter NUMBER;
BEGIN 
    pseudo_fun(v_n1, v_n2);
    area := v_n1 ;
    perimeter := v_n2;
     IF n1 = n2 THEN
       DBMS_OUTPUT.PUT_LINE(' The area of a square size ' ||  n1  || ' by ' ||  n2  || ' is ' ||  area  || ' . It''s perimeter is ' ||  perimeter || '.' );
    ELSE
       DBMS_OUTPUT.PUT_LINE(' The area of a rectangle size ' ||  n1 || ' by ' || n2 || ' is ' ||   area || ' . It''s perimeter is ' ||  perimeter  || '. ');
    END IF;
END;
/


---Question3---
CREATE OR REPLACE PROCEDURE p4q3_1 (inv_id_qoh IN OUT NUMBER, percentage_new_price IN OUT NUMBER) AS
p_inv_id NUMBER := inv_id_qoh;
p_percentage NUMBER := percentage_new_price;
p_inv_price NUMBER;
p_inv_qoh NUMBER;
BEGIN
    UPDATE inventory
    SET inv_price = inv_price + inv_price * p_percentage * 0.01;
    SELECT inv_qoh, inv_price
    INTO p_inv_qoh, p_inv_price
    FROM inventory
    WHERE inv_id = p_inv_id;
    inv_id_qoh := p_inv_qoh;
    percentage_new_price := p_inv_price;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('Inventory number ' || inv_id_qoh ||
       ' does not exist my friend !');  
END;
/

CREATE OR REPLACE PROCEDURE p4q3_2 (inv_id NUMBER, percentage NUMBER) AS
p_id NUMBER := inv_id;
p_percentage NUMBER := percentage;
value NUMBER;
BEGIN
    p4q3_1(p_id, p_percentage);
    value := p_id * p_percentage;
    DBMS_OUTPUT.PUT_LINE(' The new value of this inventory is $ ' || value);
END;
/

  