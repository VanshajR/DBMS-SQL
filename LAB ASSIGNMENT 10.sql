Q1.
CREATE TABLE EMP(
    eno INTEGER,
    ename VARCHAR(100),
    bp NUMBER,
    da NUMBER,
    hra NUMBER,
    total NUMBER DEFAULT NULL
);
INSERT INTO EMP(eno,ename,bp,da,hra) VALUES(1,'abc',500,300,200);
INSERT INTO EMP(eno,ename,bp,da,hra) VALUES(2,'def',700,100,100);
INSERT INTO EMP(eno,ename,bp,da,hra) VALUES(3,'ghi',400,200,250);
INSERT INTO EMP(eno,ename,bp,da,hra) VALUES(4,'jkl',600,800,150);



CREATE OR REPLACE PROCEDURE TotalAndUpdate(
    p_eno IN EMP.eno%TYPE,
    p_total OUT EMP.total%TYPE
) AS
	p_bp EMP.bp%TYPE;
	p_da EMP.da%TYPE;
	p_hra EMP.hra%TYPE;
BEGIN
	SELECT bp,da,hra INTO p_bp,p_da,p_hra
	FROM EMP
	WHERE eno=p_eno;

	p_total:=p_bp+p_da+p_hra;
	
	
UPDATE EMP
	SET total = p_total
	WHERE eno = p_eno;
END;
/

DECLARE 
    emptotal EMP.total%TYPE;
BEGIN
    FOR i IN 1..4 LOOP
    	TotalAndUpdate(i,emptotal);
		DBMS_OUTPUT.PUT_LINE('Total for '||i||' : '||emptotal);
	END LOOP;
END;
/


Q2.
CREATE OR REPLACE FUNCTION Factorial(
    enum IN INTEGER
) RETURN INTEGER IS
    num INTEGER:=enum;
	fact INTEGER :=1;
BEGIN
	WHILE num>0 LOOP
		fact:=fact*num;
		num:=num-1;
	END LOOP;
	RETURN fact;
END;
/

DECLARE 
    n INTEGER;
BEGIN
    n:=Factorial(4);
    DBMS_OUTPUT.PUT_LINE(n);
END;
/


Q3.
CREATE OR REPLACE PROCEDURE PNZ(
    num IN NUMBER
)AS
BEGIN
	IF num>0 THEN
		DBMS_OUTPUT.PUT_LINE('Positive');
	ELSIF num<0 THEN 
		DBMS_OUTPUT.PUT_LINE('Negative');
	ELSIF num=0 THEN 
		DBMS_OUTPUT.PUT_LINE('Zero');
	END IF;
END;
/
DECLARE
    a NUMBER:=10;
	b NUMBER:=-50;
	c NUMBER:=0;
BEGIN
	PNZ(10);
    PNZ(-50);
    PNZ(0);
END;

Q4.
CREATE OR REPLACE FUNCTION sumOfNumbers(
    num IN NUMBER
)RETURN NUMBER IS
    n_sum NUMBER:=0;
BEGIN
	FOR i IN 1..num LOOP
    	n_sum := n_sum + i;
	END LOOP;
	RETURN n_sum;
END;
/
DECLARE
    a NUMBER;
BEGIN
	a:=sumOfNumbers(10);
    DBMS_OUTPUT.PUT_LINE(a);
END;

Q5.
CREATE OR REPLACE PROCEDURE getaverage(
    num1 IN NUMBER,
    num2 IN NUMBER,
    choice IN NUMBER,
    result OUT NUMBER
)AS
    n1_sum NUMBER:=0;
	n2_sum NUMBER:=0;
	n1_avg NUMBER;
	n2_avg NUMBER;
	n_avg NUMBER;
	diff NUMBER;
    diff_avg NUMBER;
	
BEGIN
    
	IF choice=1 THEN
        FOR i IN 1..num1 LOOP
        	n1_sum := n1_sum + i;
    	END LOOP;
    		n1_avg:=n1_sum/num1;
    	FOR i IN 1..num2 LOOP
        	n2_sum := n2_sum + i;
    	END LOOP;
    	n2_avg:=n2_sum/num2;
    	n_avg:=(n1_avg+n2_avg)/2;
	
	ELSIF choice=2 THEN
        
    	IF num1>num2 THEN
            diff:=num1-num2;
    	ELSIF num2>num1 THEN
            diff:=num2-num1;
    	END IF;
		n_avg:=0;
		FOR i IN num1..num2 LOOP
            n_avg:=n_avg+i;
		END LOOP;

    	diff_avg:=n_avg/diff;
        n_avg:=diff_avg;
	END IF;
    result:=n_avg;

END;
/
    
DECLARE
    a NUMBER:=10;
	b NUMBER:=20;
	c1 NUMBER:=1;
	c2 NUMBER:=2;
	r1 NUMBER;
	r2 NUMBER;
BEGIN
	getaverage(a,b,c1,r1);
	getaverage(a,b,c2,r2);
	DBMS_OUTPUT.PUT_LINE(r1);
	DBMS_OUTPUT.PUT_LINE(r2);
END;

Q6.
CREATE OR REPLACE FUNCTION print(
    str IN VARCHAR2,
	p_counter NUMBER
)RETURN VARCHAR2 IS
BEGIN
	IF p_counter=0 THEN
    	RETURN 'End.';
	ELSE
        DBMS_OUTPUT.PUT_LINE(str);
		RETURN print(str,p_counter-1);        
	END IF;
END;
/
    
DECLARE
    hw VARCHAR2(2000) :='HELLO WORLD';
    -- val NUMBER:=10;
	res VARCHAR2(2000);
BEGIN
	res:=print(hw,10);
    DBMS_OUTPUT.PUT_LINE(res);

END;

Q7-10

-- CREATE TABLE STUDENT(
--     rollno NUMBER,
--     name VARCHAR(30),
--     subid NUMBER,
--     mark1 NUMBER,
--     mark2 NUMBER,
--     mark3 NUMBER
-- );

-- INSERT INTO STUDENT VALUES(1,'abc',10,80,62,88);
-- INSERT INTO STUDENT VALUES(2,'def',20,85,74,94);
-- INSERT INTO STUDENT VALUES(3,'ghi',30,70,41,51);
-- INSERT INTO STUDENT VALUES(4,'jkl',40,50,78,85);
-- INSERT INTO STUDENT VALUES(5,'mno',50,90,60,55);

CREATE OR REPLACE PROCEDURE p1(
    rno IN STUDENT.rollno%TYPE,
	total OUT STUDENT.mark1%TYPE
)AS
m1 STUDENT.mark1%TYPE;
m2 STUDENT.mark1%TYPE;
m3 STUDENT.mark1%TYPE;

BEGIN

SELECT mark1, mark2, mark3 INTO m1,m2,m3
FROM STUDENT
WHERE rollno=rno;
total:=m1+m2+m3;

END;
/

CREATE OR REPLACE FUNCTION fun2(
    rno IN STUDENT.rollno%TYPE
) RETURN NUMBER IS
	fun_tot STUDENT.mark1%TYPE;
	f_avg STUDENT.mark1%TYPE;
BEGIN
	p1(rno,fun_tot);
	f_avg:= fun_tot/3;
	RETURN f_avg;
END;
/
    
CREATE OR REPLACE FUNCTION fun3(
    rno IN STUDENT.mark1%TYPE
) RETURN NUMBER IS
    maxval STUDENT.mark1%TYPE;
BEGIN
    SELECT GREATEST(mark1,mark2,mark3) INTO maxval
    FROM STUDENT
    WHERE rollno=rno;
	RETURN maxval;
END;
/
    
CREATE OR REPLACE PROCEDURE p2(
    rno IN STUDENT.mark1%TYPE
)AS
    tot_marks STUDENT.mark1%TYPE;
	f_m1 STUDENT.mark1%TYPE;
	f_m2 STUDENT.mark1%TYPE;
	f_m3 STUDENT.mark1%TYPE;
BEGIN
    p1(rno,tot_marks);
	SELECT mark1,mark2,mark3 INTO f_m1,f_m2,f_m3 
    FROM STUDENT
    WHERE rollno=rno;
	DBMS_OUTPUT.PUT_LINE('TotalP2: '||tot_marks);
	DBMS_OUTPUT.PUT_LINE('Mark1_P2: '||f_m1);
	DBMS_OUTPUT.PUT_LINE('Mark2_P2: '||f_m2);
	DBMS_OUTPUT.PUT_LINE('Marks3_P2: '||f_m3);
END;
/
    


DECLARE 
    tot_marks_p NUMBER;
    avg_marks_f NUMBER;
	maxmarks NUMBER;

BEGIN
	p1(2,tot_marks_p);
	DBMS_OUTPUT.PUT_LINE('TotalP: '||tot_marks_p);
	avg_marks_f:=fun2(2);
	DBMS_OUTPUT.PUT_LINE('AvgF: '||avg_marks_f);
	maxmarks:=fun3(2);
	DBMS_OUTPUT.PUT_LINE('MaxF2: '||maxmarks);
	p2(2);

END;
/