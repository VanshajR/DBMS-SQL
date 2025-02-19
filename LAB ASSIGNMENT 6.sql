ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YYYY';
CREATE TABLE SALES(SNUM INT CONSTRAINT SPK PRIMARY KEY,
    SNAME VARCHAR(30) CONSTRAINT USNAME UNIQUE,
    CITY VARCHAR(30),COMM FLOAT
);

CREATE TABLE CUSTOMERS(CNUM INT CONSTRAINT CPK PRIMARY KEY,
    CNAME VARCHAR(30),CITY VARCHAR(30) CONSTRAINT CNOT NOT NULL,
    SNUM INT, CONSTRAINT CFK FOREIGN KEY(SNUM) REFERENCES SALES(SNUM) ON DELETE SET NULL
);

CREATE TABLE ORDERS(
    ONUM INT CONSTRAINT OPK PRIMARY KEY,
    AMT FLOAT,
    ODATE DATE,
    CNUM INT, SNUM INT,
    CONSTRAINT OCFK FOREIGN KEY(CNUM) REFERENCES CUSTOMERS(CNUM),
    CONSTRAINT OSFK FOREIGN KEY(SNUM) REFERENCES SALES(SNUM)
);

INSERT INTO SALES VALUES(1001,'Peel','London',0.12);
INSERT INTO SALES VALUES(1002,'Serres','Sanjose',0.13);
INSERT INTO SALES VALUES(1004,'Motika','London',0.11);
INSERT INTO SALES VALUES(1007, 'Rifkin', 'Barcelona' ,0.15);
INSERT INTO SALES VALUES(1003,'Axelrod', 'New York', 0.10);

INSERT INTO CUSTOMERS VALUES(2001, 'Hoffman', 'London', 1001);
INSERT INTO CUSTOMERS VALUES(2002, 'Giovanni', 'Rome', 1003);
INSERT INTO CUSTOMERS VALUES(2003, 'Liu', 'San Jose', 1002);
INSERT INTO CUSTOMERS VALUES(2004, 'Grass', 'Berlin', 1002);
INSERT INTO CUSTOMERS VALUES(2006, 'Clemens', 'London', 1001);
INSERT INTO CUSTOMERS VALUES(2008, 'Cisneros', 'San Jose', 1007);
INSERT INTO CUSTOMERS VALUES(2007, 'Pereira', 'Rome', 1004);

INSERT INTO ORDERS VALUES(3001,18.69,'03-10-1990',2008,1007);
INSERT INTO ORDERS VALUES(3003,767.19,'03-10-1990',2001,1001);
INSERT INTO ORDERS VALUES(3002,1900.10,'03-10-1990',2007,1004);
INSERT INTO ORDERS VALUES(3005,5160.45,'03-10-1990',2003,1002);
INSERT INTO ORDERS VALUES(3006,1098.16,'03-10-1990',2008,1007);
INSERT INTO ORDERS VALUES(3007,75.75,'04-10-1990',2004,1002);
INSERT INTO ORDERS VALUES(3008,4273.00,'05-10-1990',2006,1001);
INSERT INTO ORDERS VALUES(3010,1309.95,'06-10-1990',2004,1002);
INSERT INTO ORDERS VALUES(3011,9891.88,'06-10-1990',2006,1001);
INSERT INTO ORDERS VALUES(3009,1713.23,'04-10-1990',2002,1003);

SELECT * FROM SALES;
SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;

SELECT * FROM SALES WHERE SNUM IN (SELECT SNUM FROM ORDERS WHERE AMT>2000);

SELECT SNUM FROM SALES WHERE SNUM IN (SELECT DISTINCT SNUM FROM CUSTOMERS GROUP BY SNUM HAVING COUNT(CNUM)>=2);

SELECT SNAME FROM SALES WHERE SNUM IN (SELECT DISTINCT SNUM FROM CUSTOMERS GROUP BY SNUM HAVING COUNT(CNUM)>=2);

SELECT COUNT(SNUM) FROM SALES WHERE UPPER(CITY) IN ('LONDON','PARIS');

SELECT CNAME FROM CUSTOMERS WHERE SNUM IN (SELECT SNUM FROM SALES WHERE UPPER(CITY) IN ('LONDON','PARIS')) AND UPPER(CITY) IN ('LONDON','PARIS');

SELECT CNAME FROM CUSTOMERS WHERE CNUM IN (SELECT CNUM FROM ORDERS WHERE AMT=1200);

SELECT CNAME FROM CUSTOMERS WHERE CITY IN (SELECT CITY FROM SALES);

SELECT SNAME FROM SALES WHERE COMM>0.10 AND SNUM IN (SELECT SNUM FROM CUSTOMERS GROUP BY SNUM HAVING COUNT(DISTINCT CNUM)>2);

-- SELECT O.CNUM,C.CNAME,S.SNAME FROM CUSTOMERS C,SALES S 
-- WHERE C.CNUM IN (SELECT CNUM FROM ORDERS GROUP BY CNUM HAVING COUNT(DISTINCT CNUM)=1) AND 
-- S.SNUM IN (SELECT SNUM FROM ORDERS GROUP BY SNUM HAVING COUNT(DISTINCT ONUM)=1);

SELECT C.CNAME,S.SNAME FROM CUSTOMERS C 
JOIN SALES S ON C.SNUM=S.SNUM
JOIN ORDERS O ON C.CNUM=O.CNUM
GROUP BY C.CNAME,S.SNAME HAVING COUNT(DISTINCT O.CNUM)=1;

INSERT INTO SALES VALUES(1005,'XYZ','DDun',0.20);
SELECT * FROM SALES WHERE SNUM NOT IN (SELECT DISTINCT SNUM FROM CUSTOMERS);


SELECT COUNT(DISTINCT ENO) AS TOTAL FROM EMP WHERE DEPTNO<>10 AND DEPTNO IN (SELECT DISTINCT DEPTNO FROM EMP GROUP BY DEPTNO HAVING COUNT(DISNTICT ENO)>5) ORDER BY TOTAL DESC;
