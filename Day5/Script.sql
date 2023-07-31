
create table user_detail (
"id" uuid not null default uuid_generate_v4(),
"email" character varying not null,
"name" character varying not null,
"phone_no" character varying not null,
"password" character varying not null,
constraint "PK_USER_DETAIL" primary key ("id")
);

create table address (
"id" uuid not null default uuid_generate_v4(),
"user_id" uuid,
"address_line1" character varying not null,
"address_line2" character varying not null,
"pincode" character varying not null,
constraint "PK_ADDRESS" primary key ("id"),
constraint "FK_ADDRESS" foreign key ("user_id") references user_detail("id") on delete cascade
);

create table product_category (
"id" uuid not null default uuid_generate_v4(),
"name" character varying not null,
constraint "PK_PRODUCT_CATEGORY" primary key ("id")
);


create table product_detail (
"id" uuid not null default uuid_generate_v4(),
"sku" character varying not null,
"name" character varying not null,
"description" character varying,
"product_category_id" uuid,
"price" float not null,
constraint "PK_PRODUCT_DETAIL" primary key ("id"),
constraint "FK_PRODUCT_CATEGORY" foreign key ("product_category_id") references product_category("id") on delete cascade
);


create table order_detail (
"id" uuid not null default uuid_generate_v4(),
"ordered_user_id" uuid,
"order_address_id" uuid, 
"count" float,
"total_price" float,
constraint "PK_ORDER_DETAIL" primary key ("id"),
constraint "FK_ORDER_DETAIL_USER" foreign key ("ordered_user_id") references user_detail("id") on delete cascade,
constraint "FK_ORDER_ADDRESS" foreign key ("order_address_id") references address("id") on delete cascade
);

create table order_product (
"order_id" uuid,
"product_id" uuid,
"quantity" float not null,
constraint "PK_ORDER_PRODUCT" primary key ("order_id", product_id),
constraint "FK_ORDER" foreign key ("order_id") references order_detail("id") on delete cascade,
constraint "FK_PRODUCT" foreign key ("product_id") references product_detail("id") on delete cascade
);

INSERT INTO public.user_detail
(id, "name", email, phone_no, "password")
VALUES(uuid_generate_v4(), 'abc', 'abc@gmail.com', 'abc@123', '123'),
(uuid_generate_v4(), 'def', 'def@gmail.com', 'def@123', '456'),
(uuid_generate_v4(), 'ghi', 'ghi@gmail.com', 'ghi@123', '454');


INSERT INTO public.address
(id, user_id, address_line1, address_line2, pincode)
VALUES(uuid_generate_v4(), (select id from user_detail where "name"='abc'), 'abc', 'def', '600'),
(uuid_generate_v4(), (select id from user_detail where "name"='def'), 'jkl', 'mno', '700'),
(uuid_generate_v4(), (select id from user_detail where "name"='ghi'), 'pqr', 'stu', '800');

INSERT INTO public.product_category
(id, "name")
VALUES(uuid_generate_v4(), 'Electronics'),
(uuid_generate_v4(), 'Home Decor'),
(uuid_generate_v4(), 'Fashion');


INSERT INTO public.product_detail
(id, sku, "name", description, product_category_id, price)
VALUES(uuid_generate_v4(), 'ph1', 'ph001', 'mobile phone', (select id from product_category where "name"='Electronics'), 10000),
(uuid_generate_v4(), 'lp1', 'lp201', 'laptop', (select id from product_category where "name"='Electronics'), 50000),
(uuid_generate_v4(), 'j1', 'j501', 'jeans', (select id from product_category where "name"='Fashion'), 700),
(uuid_generate_v4(), 's1', 's502', 'shirt', (select id from product_category where "name"='Fashion'), 400),
(uuid_generate_v4(), 'b1', 'b101', 'floor mat', (select id from product_category where "name"='Home Decor'), 100);


INSERT INTO public.order_detail
(id, order_address_id, ordered_user_id)
VALUES(uuid_generate_v4(), (select id from address where "pincode"='123'), (select id from user_detail where "name"='abc')),
(uuid_generate_v4(), (select id from address where "pincode"='123'), (select id from user_detail where "name"='abc')),
(uuid_generate_v4(), (select id from address where "pincode"='123'), (select id from user_detail where "name"='abc')),
(uuid_generate_v4(), (select id from address where "pincode"='454'), (select id from user_detail where "name"='ghi')),
(uuid_generate_v4(), (select id from address where "pincode"='454'), (select id from user_detail where "name"='ghi'));


INSERT INTO public.order_product
(order_id, product_id, quantity)
VALUES('e4bc5e61-ca5f-46a9-859c-a3d9160fcac3', '0e86384b-9121-4a84-9de5-22848b225cdd', 1),
('e4bc5e61-ca5f-46a9-859c-a3d9160fcac3', 'e00aa51a-271e-4776-9a80-7a4c04258e0c', 2),
('73c0d367-2258-40ee-87e1-f30f32b7f45e', '2fdc15ac-6e5e-482a-a53c-304b90ee92ed', 1),
('9b4124b5-1117-4709-83a8-6372b96a8ce3', 'bdfa1233-c899-4635-8962-714e488fae23', 4),
('20d14ec8-bb86-4512-b03f-cb92259b6ac3', '0e86384b-9121-4a84-9de5-22848b225cdd', 1),
('20d14ec8-bb86-4512-b03f-cb92259b6ac3', 'bdfa1233-c899-4635-8962-714e488fae23', 3),
('71da0261-a175-463d-bae6-a690000e9dc2', '3ad1cd4e-3626-490d-9d77-e1f3fe9c92da', 1);


CREATE INDEX poduct_category_name_index ON public.product_category (name);


CREATE INDEX product_details_name_index ON public.product_details ("name");

