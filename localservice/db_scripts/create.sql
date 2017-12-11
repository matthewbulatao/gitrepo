create table additional_charge (id integer generated by default as identity, code varchar(255), description varchar(255), name varchar(255), primary key (id))
create table guest (id integer generated by default as identity, address varchar(255), contact_number varchar(255), email varchar(255), first_name varchar(255), last_name varchar(255), password varchar(255), username varchar(255), primary key (id))
create table payment (id integer generated by default as identity, mode varchar(255), reference_id varchar(255), remarks varchar(255), reservation_ref_id varchar(255), status varchar(255), total_amount double not null, transaction_type varchar(255), primary key (id))
create table payment_item (id integer generated by default as identity, amount double not null, description varchar(255), payment_id integer, primary key (id))
create table reservation (id integer generated by default as identity, check_in timestamp, check_out timestamp, count_adult integer not null, count_children integer not null, reference_id varchar(255), remarks varchar(255), status varchar(255), type varchar(255), primary key (id))
create table role (id integer generated by default as identity, code varchar(255), description varchar(255), name varchar(255), primary key (id))
create table room (id integer generated by default as identity, capacity integer not null, code varchar(255), description varchar(255), number integer not null, rate double not null, status varchar(255), type varchar(255), primary key (id))
create table user (id integer generated by default as identity, contact_number varchar(255), email varchar(255), first_name varchar(255), last_name varchar(255), password varchar(255), user_name varchar(255), primary key (id))
alter table payment_item add constraint FK2n2y0k5ju4e1bndwikq8igyj2 foreign key (payment_id) references payment