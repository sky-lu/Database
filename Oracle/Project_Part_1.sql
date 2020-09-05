SPOOL D:\Lasalle\study\2020Fall\project_part_1.txt

--Question 1--

CREATE OR REPLACE PROCEDURE tri_calculate
(tri_num_in IN NUMBER) AS
v_num_in NUMBER;
v_result NUMBER;
BEGIN
      v_num_in := tri_num_in;
      v_result := v_num_in * 3;
DBMS_OUTPUT.PUT_LINE('The triple of ' || tri_num_in || ' is ' || v_result);
END;
/

--Question 2--

CREATE OR REPLACE PROCEDURE c_convert_f
(c_temp_in IN NUMBER) AS
c_temp NUMBER;
f_temp NUMBER;
BEGIN
      c_temp := c_temp_in;
      f_temp := (9/5) * c_temp +32;
DBMS_OUTPUT.PUT_LINE(c_temp_in || ' degree in C is equivalent to ' || f_temp || ' in F');
END;
/

--Question 3--

CREATE OR REPLACE PROCEDURE f_convert_c
(f_temp_in IN NUMBER) AS
f_temp NUMBER;
c_temp NUMBER;
BEGIN
      f_temp := f_temp_in; 
      c_temp := (5/9) * (f_temp - 32);
DBMS_OUTPUT.PUT_LINE(f_temp_in || ' degree in F is equivalent to ' || c_temp || ' in C ');
END;
/

--Question 4--

CREATE OR REPLACE PROCEDURE tax_calculate
(price_in IN NUMBER) AS
price NUMBER;
GST NUMBER;
QST NUMBER;
total_tax NUMBER;
grand_total NUMBER;
BEGIN
      price := price_in;
      GST := price * 0.05;
      QST := price * 0.0998;
      total_tax := GST + QST;
      grand_total := price + total_tax;
DBMS_OUTPUT.PUT_LINE('For the price of $' || price_in);
DBMS_OUTPUT.PUT_LINE('You will have to pay $' || GST || ' GST ');
DBMS_OUTPUT.PUT_LINE('$' || QST || ' QST for a total of $' || total_tax);
DBMS_OUTPUT.PUT_LINE('The GRAND TOTAL is $' || grand_total);
END;
/

--Question 5--

CREATE OR REPLACE PROCEDURE rectangular_calculate
(width_in IN NUMBER, height_in IN NUMBER) AS
width NUMBER;
height NUMBER;
area NUMBER;
perimeter NUMBER;
BEGIN
      width := width_in;
      height := height_in;
      area := width * height;
      perimeter := (width + height) * 2;
DBMS_OUTPUT.PUT_LINE('The area of a ' || width_in || ' by ' || height_in || ' rectangle is ' || area || ' It''s parimeter is ' || perimeter);
END;
/

--Question 6--

CREATE OR REPLACE FUNCTION c_to_f
(c_temp_in IN NUMBER) RETURN NUMBER AS
c_temp NUMBER;
f_temp NUMBER;
BEGIN
      c_temp := c_temp_in;
      f_temp := (9/5) * c_temp +32;
      RETURN f_temp;
END;
/

SELECT c_to_f(0) FROM dual;

--Question 7--

CREATE OR REPLACE FUNCTION f_to_c
(f_temp_in IN NUMBER) RETURN NUMBER AS
f_temp NUMBER;
c_temp NUMBER;
BEGIN
      f_temp := f_temp_in; 
      c_temp := (5/9) * (f_temp - 32);
      RETURN c_temp;
END;
/

SELECT f_to_c(32) FROM dual;
