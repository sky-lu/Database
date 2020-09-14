--Question 1--
CREATE OR REPLACE FUNCTION multiply (p1 NUMBER, p2 NUMBER) RETURN NUMBER AS
   v_result NUMBER;
   BEGIN
     v_result := p1 * p2;
     RETURN v_result;
   END;
  /

--test--
SELECT multiply(2,3) FROM dual;

--Question 2--
CREATE OR REPLACE PROCEDURE p_question2 (x NUMBER, y NUMBER) AS
   v_result NUMBER;
 BEGIN
   v_result := multiply (x, y);
   DBMS_OUTPUT.PUT_LINE (' For a rectangle of size ' || x || ' by ' || y || ' the area is '|| v_result );
END;
/

--test--
EXEC p_question2 (2,3);
EXEC p_question2 (6,8);


--Question 3--
CREATE OR REPLACE PROCEDURE p_question3 (x NUMBER, y NUMBER) AS
   v_result NUMBER;
 BEGIN
   v_result := multiply (x, y);
   IF x = y THEN
      DBMS_OUTPUT.PUT_LINE (' For a square of size ' || x || ' by ' || y || ' the area is '|| v_result );
   ELSE
      DBMS_OUTPUT.PUT_LINE (' For a rectangle of size ' || x || ' by ' || y || ' the area is '|| v_result );
   END IF;
END;
/

--test--
EXEC p_question3 (3,3);
EXEC p_question3 (2,3);

--Question 4--
CREATE OR REPLACE PROCEDURE p_question4 ( x NUMBER, letter VARCHAR2) AS
v_result NUMBER;
new_currency VARCHAR2(50);
BEGIN
  IF letter = 'E' THEN
     v_result := x * 1.5;
     new_currency := 'EURO';
  ELSIF letter = 'Y' THEN
     v_result := x * 100;
     new_currency := 'YEN';
  ELSIF letter = 'V' THEN
     v_result := x * 10000;
     new_currency := 'Viet Nam DONG';
  ELSIF letter = 'Z' THEN
     v_result := x * 1000000;
     new_currency := 'Endora ZIP'; 
  END IF;
DBMS_OUTPUT.PUT_LINE ( ' For ' || x || ' dollars Canadian, you will have ' || v_result || new_currency );
END ;
/


--Question 5--
CREATE OR REPLACE FUNCTION YES_EVEN ( p NUMBER) RETURN BOOLEAN AS
v NUMBER := MOD(p, 2);
v_result BOOLEAN;
BEGIN
   IF v = 0 THEN
      v_result := TRUE;
   ELSE
      v_result := FALSE;
   END IF;
  RETURN v_result;
END;
/

--Question 6--
CREATE OR REPLACE PROCEDURE p_question6 (p NUMBER) AS
BEGIN
  IF YES_EVEN (P) THEN
     DBMS_OUTPUT.PUT_LINE('Number ' || p || ' is EVEN ');
  ELSE
     DBMS_OUTPUT.PUT_LINE('Number ' || p || ' is ODD ');
  END IF;
END;
/

--BONUS QUESTION--
CREATE OR REPLACE PROCEDURE p_bonus (x NUMBER, letter1 VARCHAR2, letter2 VARCHAR2) AS
v_result NUMBER;
currency1 VARCHAR2(50);
currency2 VARCHAR2(50);
BEGIN
   IF letter1 = 'C' THEN
       currency1 := 'dollars Canadian';
       IF letter2 = 'E' THEN
          currency2 := 'EURO';
          v_result := x * 1.5;       
       ELSIF letter2 = 'Y' THEN
          currency2 := 'YEN';
          v_result := x * 100;
       ELSIF letter2 = 'V' THEN
          currency2 := 'Viet Nam DONG';
          v_result := x * 10000;
        ELSIF letter2 = 'Z' THEN
          currency2 := 'Endora ZIP';
          v_result := x * 1000000;
        END IF;
    ELSIF letter1 = 'E' THEN
        currency1 := 'EURO';
        IF letter2 = 'C' THEN
          currency2 := 'dollars Canadian';
          v_result := x / 1.5;
        ELSIF letter2 = 'Y' THEN
          currency2 := 'YEN';
          v_result := x * 100 / 1.5;
        ELSIF letter2 = 'V' THEN
          currency2 := 'Viet Nam DONG';
          v_result := x * 10000 / 1.5;
        ELSIF letter2 = 'Z' THEN
          currency2 := 'Endora ZIP';
          v_result := x * 1000000 / 1.5;
        END IF;  
    ELSIF letter1 = 'Y' THEN
        currency1 := 'YEN';
        IF letter2 = 'C' THEN
          currency2 := 'dollars Canadian';
          v_result := x * 0.01;
        ELSIF letter2 = 'E' THEN
          currency2 := 'EURO';
          v_result := x * 0.01 *1.5;
        ELSIF letter2 = 'V' THEN
          currency2 := 'Viet Nam DONG';
          v_result := x * 100;
        ELSIF letter2 = 'Z' THEN
          currency2 := 'Endora ZIP';
          v_result := x * 10000;
        END IF;  
    ELSIF letter1 = 'V' THEN
        currency1 := 'Viet Nam DONG';
        IF letter2 = 'C' THEN
          currency2 := 'dollars Canadian';
          v_result := x * 0.0001;
        ELSIF letter2 = 'Y' THEN
          currency2 := 'YEN';
          v_result := x * 0.01;
        ELSIF letter2 = 'E' THEN
          currency2 := 'EURO';
          v_result := x * 0.0001 * 1.5;
        ELSIF letter2 = 'Z' THEN
          currency2 := 'Endora ZIP';
          v_result := x * 100;
        END IF;  
   ELSIF letter1 = 'Z' THEN
        currency1 := 'Endora ZIP';
        IF letter2 = 'C' THEN
          currency2 := 'dollars Canadian';
          v_result := x * 0.000001;
        ELSIF letter2 = 'Y' THEN
          currency2 := 'YEN';
          v_result := x * 0.0001;
        ELSIF letter2 = 'E' THEN
          currency2 := 'EURO';
          v_result := x * 0.000001 * 1.5;
        ELSIF letter2 = 'V' THEN
          currency2 := 'Viet Nam DONG';
          v_result := x * 0.01;
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE( ' For ' || x ||  currency1 || ' , you will have ' || v_result ||  currency2);
END;
/