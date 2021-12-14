
-- Play with Time Zones :-)

create table meas (
  sid  numeric(4,0),
  ts   timestamptz,
  val  real
)


insert into meas values (1, now() - interval '4 hour', -1.0);
insert into meas values (1, now() - interval '3 hour', -0.2);
insert into meas values (1, now() - interval '2 hour',  0.5);
insert into meas values (1, now() - interval '1 hour',  1.7);
insert into meas values (1, now() - interval '0 hour',  2.2);

select to_

set time zone 'CET';
