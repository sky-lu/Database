-----Question1-----
CREATE TABLE cust_audit (cust_audit_id NUMBER, date_updated DATE, updating_user VARCHAR2(25));
CREATE SEQUENCE cust_audit_seq;
CREATE OR REPLACE TRIGGER customer_audit
AFTER INSERT OR UPDATE OR DELETE ON customer
    BEGIN
        INSERT INTO cust_audit
        VALUES(cust_audit_seq.NEXTVAL, sysdate, user);
    END;
/

GRANT SELECT, INSERT, UPDATE, DELETE ON customer TO c##scott;
----c##scott
SELECT * FROM c##nora02.customer;
UPDATE c##nora02.customer
SET c_password = 'honglin'
WHERE  c_id = 1;
commit;

----c##nora02
SELECT cust_audit_id, TO_CHAR(date_updated,'DD Month YYYY HH:MI:SS'), updating_user
FROM cust_audit;

-----Question2----
CREATE TABLE order_line_audit (order_line_audit_id NUMBER, date_updated DATE, updating_user VARCHAR2(25), action_performed VARCHAR2(25));
CREATE SEQUENCE order_line_audit_seq;

CREATE OR REPLACE TRIGGER orderline_audit
  AFTER INSERT OR UPDATE OR DELETE ON order_line
    BEGIN
     IF INSERTING THEN
         INSERT INTO order_line_audit
         VALUES(order_line_audit_seq.NEXTVAL, sysdate, user, 'INSERT');
     ELSIF UPDATING THEN
         INSERT INTO order_line_audit
         VALUES(order_line_audit_seq.NEXTVAL, sysdate, user, 'UPDATE');
     ELSIF DELETING THEN
          INSERT INTO order_line_audit
         VALUES(order_line_audit_seq.NEXTVAL, sysdate, user, 'DELETE');
       END IF;
    END;
/
GRANT SELECT, INSERT, UPDATE, DELETE ON order_line TO c##scott;
----c##scott
SELECT * FROM c##nora02.order_line;
UPDATE c##nora02.order_line
SET ol_quantity = 5
WHERE o_id = 1 and inv_id = 1;

DELETE FROM c##nora02.order_line
WHERE o_id = 6 and inv_id = 7;

----c##nora02
SELECT order_line_audit_id, TO_CHAR(date_updated,'DD MON YY HH:MI:SS'),
    updating_user, action_performed
FROM order_line_audit;

----Question3----
CREATE TABLE order_line_row_audit (order_line_row_audit_id NUMBER, o_id NUMBER, inv_id NUMBER, old_ol_quantity NUMBER, date_updated DATE, updating_user VARCHAR2(25));
CREATE SEQUENCE order_line_row_audit_seq;
CREATE OR REPLACE TRIGGER order_line_row_audit
AFTER UPDATE ON order_line
FOR EACH ROW
BEGIN
    INSERT INTO order_line_row_audit
    VALUES(order_line_row_audit_seq.NEXTVAL,:OLD.o_id, :OLD.inv_id, :OLD.ol_quantity, sysdate, user);
END;
/
----c##scott
UPDATE c##nora02.order_line
SET ol_quantity = 15
WHERE o_id = 1 and inv_id = 1;

-----c##nora02
SELECT order_line_row_audit_id, o_id, inv_id, old_ol_quantity, TO_CHAR(date_updated,'DD Month YYYY HH:MI:SS'), updating_user
FROM order_line_row_audit;