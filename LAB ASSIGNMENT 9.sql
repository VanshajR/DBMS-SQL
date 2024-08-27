Q1.
DECLARE
    num1 NUMBER:= 3;
    num2 NUMBER:= 5;
    num3 NUMBER:= 7;
	greatest NUMBER;
BEGIN
	IF (num1> num2 AND num1>num3) THEN
		greatest:=num1;
	ELSIF (num2>num1 AND num2>num3) THEN
		greatest:=num2;
	ELSIF (num3>num1 AND num3>num2) THEN
		greatest:=num3;
	END IF;
	dbms_output.put_line('Greatest is: '||greatest);
END;
/


Q2.
DECLARE
    num NUMBER:= 3;
BEGIN
	IF (num MOD 2=0) THEN
		dbms_output.put_line(num||' is even.');
	ELSE
		dbms_output.put_line(num||' is odd.');
	END IF;
END;
/

Q3.
DECLARE
    marks NUMBER:= 93;
BEGIN
	IF (marks>80) THEN
		dbms_output.put_line('A');
	ELSIF (marks>70) THEN
		dbms_output.put_line('B');
	ELSIF (marks>50) THEN
		dbms_output.put_line('C');
	ELSIF (marks>40) THEN
		dbms_output.put_line('D');
	ELSIF (marks<40) THEN
		dbms_output.put_line('E');
	END IF;
END;
/

Q4.
DECLARE
    num NUMBER:= 3;
	-- i NUMBER :=1;
BEGIN
	FOR i IN 1..10 LOOP
    	dbms_output.put_line(num||' x '||i||' = '||num*i);
	END LOOP;
END;
/

Q5.
DECLARE
    num NUMBER:= 5;
	fact NUMBER :=1;
BEGIN
	WHILE num>=1 LOOP
    	fact:=fact*num;
		num:=num-1;
	END LOOP;
	dbms_output.put_line('Factorial: '||fact);
END;
/

Q6.
DECLARE
    num NUMBER:= 5;
	a NUMBER :=0;
	b NUMBER :=1;
	c NUMBER;
BEGIN
    dbms_output.put_line(a||' ');
	FOR i IN 2..num LOOP
    	c:=a+b;
		dbms_output.put_line(c||' ');
		a:=b;
		b:=c;
	END LOOP;
END;
/

Q7.
DECLARE
    num INTEGER:= 54321;
	ulta INTEGER :=0;
	u_digit INTEGER;
BEGIN
	WHILE num>0 LOOP
        u_digit:=num MOD 10;
        ulta:= ulta*10 + u_digit;
		num:=TRUNC(num/10);
	END LOOP;
	dbms_output.put_line('Reverse: '||ulta);
END;
/

Q8.
DECLARE
    num1 NUMBER := 5; -- Input first number
    num2 NUMBER := 4; -- Input second number
    operation CHAR(1); -- Variable to store the operation choice
    result NUMBER; -- Variable to store the result
BEGIN
    -- Prompt the user to choose an operation
    DBMS_OUTPUT.PUT_LINE('Choose an operation:');
    DBMS_OUTPUT.PUT_LINE('1. Addition (+)');
    DBMS_OUTPUT.PUT_LINE('2. Subtraction (-)');
    DBMS_OUTPUT.PUT_LINE('3. Multiplication (*)');
    DBMS_OUTPUT.PUT_LINE('4. Division (/)');
    operation := 4;

    -- Perform the selected operation
    CASE operation
        WHEN '1' THEN
            result := num1 + num2; -- Addition
        WHEN '2' THEN
            result := num1 - num2; -- Subtraction
        WHEN '3' THEN
            result := num1 * num2; -- Multiplication
        WHEN '4' THEN
            IF num2 = 0 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Division by zero');
            ELSE
                result := num1 / num2; -- Division
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: Invalid operation choice');
    END CASE;

    -- Display the result
    IF operation IN ('1', '2', '3', '4') THEN
        DBMS_OUTPUT.PUT_LINE('Result: ' || result);
    END IF;
END;
/

Q9.
DECLARE
    num NUMBER := 5; -- Input first number
BEGIN
    FOR i IN 1..4 LOOP
    	dbms_output.put_line(num*i);
	END LOOP;
END;
/

Q10.
DECLARE
    current_hour NUMBER;
    welcome_message VARCHAR2(50);
BEGIN
    -- Get the current hour of the day
    current_hour := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));

    -- Determine the welcome message based on the current hour
    IF current_hour >= 0 AND current_hour < 12 THEN
        welcome_message := 'Good morning!';
    ELSIF current_hour >= 12 AND current_hour < 18 THEN
        welcome_message := 'Good afternoon!';
    ELSE
        welcome_message := 'Good night!';
    END IF;

    -- Display the welcome message
    DBMS_OUTPUT.PUT_LINE(welcome_message);
END;
/
