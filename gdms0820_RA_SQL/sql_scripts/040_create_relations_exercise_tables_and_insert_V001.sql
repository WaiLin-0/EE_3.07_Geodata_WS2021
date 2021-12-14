/* Create table R */

DROP TABLE R;

CREATE TABLE R
(
    A decimal(3),
	B decimal(3)
)
WITH (
    OIDS = FALSE
);

insert into r values (1,2);
insert into r values (5,6);
insert into r values (1,2);


/* Create table S */

DROP TABLE S;

CREATE TABLE S
(
    B decimal(3),
	C decimal(3)
)
WITH (
    OIDS = FALSE
);

insert into S values (3,4);
insert into S values (7,8);


/* Create table R1 */

DROP TABLE r1;

CREATE TABLE r1
(
    a decimal(3),
	b decimal(3)
)
WITH (
    OIDS = FALSE
);

insert into r1 values (1,2);
insert into r1 values (3,4);


/* Create table R2 */

DROP TABLE r2;

CREATE TABLE r2
(
    b decimal(3),
	c decimal(3)
)
WITH (
    OIDS = FALSE
);

insert into r2 values (5,6);
insert into r2 values (7,8);
insert into r2 values (9,10);
