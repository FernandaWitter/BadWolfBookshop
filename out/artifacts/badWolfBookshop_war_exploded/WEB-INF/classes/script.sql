CREATE DATABASE badwolfbookshop;

-- Table Creation
DROP TABLE IF EXISTS books;
CREATE TABLE books (
    bks_id SERIAL PRIMARY KEY,
    bks_title varchar(100),
    bks_pub_id integer,
    bks_pub_year integer,
    bks_pub_edition integer,
    bks_language varchar(30),
    bks_isbn varchar (20),
    bks_summary varchar(2000),
    bks_height numeric(8,3),
    bks_width numeric(8,3),
    bks_depth numeric(8,3),
    bks_weight numeric(8,3),
    bks_price numeric(8,3),
    bks_inStock integer,
    bks_pages integer,
    bks_is_active boolean
);

DROP TABLE IF EXISTS publishers;
CREATE TABLE publishers(
    pub_id SERIAL PRIMARY KEY,
    pub_name varchar(100)
);

DROP TABLE IF EXISTS categories;
CREATE TABLE categories(
    cat_id SERIAL PRIMARY KEY,
    cat_name varchar(150)
);

DROP TABLE IF EXISTS authors;
CREATE TABLE authors (
    aut_id SERIAL PRIMARY KEY,
    aut_name varchar(200)
);

DROP TABLE IF EXISTS book_authors;
CREATE TABLE book_authors (
    bka_bks_id integer,
    bka_aut_id integer
);

DROP TABLE IF EXISTS book_categories;
CREATE TABLE book_categories (
    bkc_cat_id integer,
    bkc_bks_id integer
);

DROP TABLE IF EXISTS book_images;
CREATE TABLE book_images(
    img_id SERIAL PRIMARY KEY,
    img_path varchar(2000),
    img_bks_id integer,
    img_is_active boolean
);

DROP TABLE IF EXISTS access_credentials;
CREATE TABLE access_credentials(
    acc_id SERIAL PRIMARY KEY,
    acc_username varchar,
    acc_pw varchar(50),
    acc_creation_date date,
    acc_last_access date,
    acc_s varchar,
    acc_is_active boolean
);

DROP TABLE IF EXISTS users;
CREATE TABLE users(
    usr_id SERIAL PRIMARY KEY,
    usr_access_credential integer,
    usr_name varchar(200),
    usr_nickname varchar(30),
    usr_federal_id varchar(11),
    usr_bday date,
    usr_area_code varchar(5),
    usr_phone varchar(10),
    usr_is_active boolean
);

DROP TABLE IF EXISTS states;
CREATE TABLE states(
    stt_id SERIAL PRIMARY KEY,
    stt_code integer,
    stt_name varchar(30)
);

DROP TABLE IF EXISTS countries;
CREATE TABLE countries(
    cnt_id SERIAL PRIMARY KEY,
    cnt_code integer,
    cnt_name varchar(50)
);

DROP TABLE IF EXISTS user_address;
CREATE TABLE user_address(
    add_id SERIAL PRIMARY KEY,
    add_usr_id integer,
    add_place varchar(100),
    add_number varchar(10),
    add_neighborhood varchar(30),
    add_zipcode varchar(10),
    add_compl varchar(200),
    add_city varchar(50),
    add_stt_id integer,
    add_cnt_id integer,
    add_is_delivery boolean,
    add_is_billing boolean,
    add_is_main boolean,
    add_is_active boolean,
    add_nickname varchar(50)
);

DROP TABLE IF EXISTS card_companies;
CREATE TABLE card_companies(
    ccp_id SERIAL PRIMARY KEY,
    ccp_name varchar(50),
    ccp_code varchar(2)
);

DROP TABLE IF EXISTS user_cards;
CREATE TABLE user_cards(
    crd_id SERIAL PRIMARY KEY,
    crd_usr_id integer,
    crd_ccp_id integer,
    crd_expiration char(5),
    crd_number char(16),
    crd_cvv varchar(4),
    crd_holder varchar(30),
    crd_is_active boolean
);

DROP TABLE IF EXISTS user_cart;
CREATE TABLE user_cart(
    crt_id SERIAL PRIMARY KEY,
    crt_usr_id integer,
    crt_date date
);

DROP TABLE IF EXISTS cart_items;
CREATE TABLE cart_items(
    cit_bks_id integer,
    cit_crt_id integer,
    cit_quantity integer
);

DROP TABLE IF EXISTS status;
CREATE TABLE status(
    sts_id integer SERIAL PRIMARY KEY,
    sts_code integer,
    sts_label varchar(20)
)

DROP TABLE IF EXISTS user_order;
CREATE TABLE user_order(
    ord_id SERIAL PRIMARY KEY,
    ord_cli_id integer,
    ord_date date,
    ord_last_modified date,
    ord_sts_id integer,
    ord_add_shipping integer,
    ord_add_billing integer
);

DROP TABLE IF EXISTS order_item;
CREATE TABLE order_item(
    oit_id SERIAL PRIMARY KEY,
    oit_ord_id integer,
    oit_bks_id integer,
    oit_quantity integer,
    oit_sts_id integer,
    oit_date date,
    oit_last_modified date,
    oit_return_motive varchar(2000)
);

DROP TABLE IF EXISTS order_payment;
CREATE TABLE order_payment(
    orp_id SERIAL PRIMARY KEY,
    orp_ord_id integer,
    orp_crd_id integer,
    orp_amount numeric(8,3)
);

DROP TABLE IF EXISTS vouchers;
CREATE TABLE vouchers(
    vou_id SERIAL PRIMARY KEY,
    vou_usr_id integer,
    vou_expiration date,
    vou_creation date,
    vou_code varchar(20),
    vou_amount numeric(8,3),
    vou_is_active boolean
);

DROP TABLE IF EXISTS wishlist;
CREATE TABLE wishlist(
    wsl_id SERIAL PRIMARY KEY,
    wsl_usr_id integer,
    wsl_name varchar(200),
    wsl_creation_date date,
    wsl_last_update date
);

DROP TABLE IF EXISTS wishilist_item;
CREATE TABLE wishlist_item(
    wit_wsl_id integer,
    wit_bks_id integer,
    wit_quantity integer
);

-- History/Audit Tables
CREATE TABLE h_books (
	hbks_id	INTEGER NOT NULL,
    hbks_title varchar(100),
    hbks_pub_id integer,
    hbks_pub_year integer,
    hbks_pub_edition varchar,
    hbks_language varchar(30),
    hbks_isbn varchar (20),
    hbks_summary varchar(2000),
    hbks_height numeric(8,3),
    hbks_width numeric(8,3),
    hbks_depth numeric(8,3),
    hbks_weight numeric(8,3),
    hbks_price numeric(8,3),
    hbks_inStock integer,
    hbks_pages integer,
    hbks_is_active boolean,
	hbks_date timestamptz,
	hbks_operation	char(6)
);

CREATE TABLE h_publishers(
    hpub_id INTEGER NOT NULL,
    hpub_name varchar(100) NOT NULL,
	hpub_date	timestamptz NOT NULL,
	hpub_operation	char(6) NOT NULL
);

CREATE TABLE h_categories(
    hcat_id INTEGER NOT NULL,
    hcat_name varchar(150) NOT NULL,
	hcat_date	timestamptz NOT NULL,
	hcat_operation	char(6) NOT NULL
);

CREATE TABLE h_authors (
	haut_id		INTEGER NOT NULL,
    haut_name varchar(200) NOT NULL,
	haut_date	timestamptz NOT NULL,
	haut_operation	char(6) NOT NULL
);

CREATE TABLE h_book_authors (
    hbka_bks_id integer NOT NULL,
    hbka_aut_id integer NOT NULL,
	hbka_date	timestamptz NOT NULL,
	hbka_operation	char(6) NOT NULL
);

CREATE TABLE h_book_categories (
    bkc_cat_id integer,
    bkc_bks_id integer NOT NULL,
	hbkc_date	timestamptz NOT NULL,
	hbkc_operation	char(6) NOT NULL
);

CREATE TABLE h_book_images(
    img_id INTEGER NOT NULL,
    img_path varchar(2000),
    img_bks_id integer,
    img_is_active boolean,
	himg_date timestamptz NOT NULL,
	himg_operation	char(6) NOT NULL
);

CREATE TABLE h_access_credentials(
    hacc_id INTEGER NOT NULL,
    hacc_username varchar,
    hacc_pw varchar(50),
    hacc_creation_date date,
    hacc_last_access date,
    hacc_is_active boolean,
	hacc_s varchar,
	hacc_date timestamptz NOT NULL,
	hacc_operation	char(6) NOT NULL
);

CREATE TABLE h_users(
    husr_id INTEGER NOT NULL,
    husr_access_credential integer,
    husr_name varchar(200),
    husr_nickname varchar(30),
    husr_federal_id varchar(11),
    husr_bday date,
    husr_area_code varchar(5),
    husr_phone varchar(10),
    husr_is_active boolean,
	husr_date timestamptz NOT NULL,
	husr_operation	char(6) NOT NULL
);

CREATE TABLE h_user_address(
    hadd_id INTEGER NOT NULL,
    hadd_usr_id integer,
    hadd_place varchar(100),
    hadd_number varchar(10),
    hadd_neighborhood varchar(30),
    hadd_zipcode varchar(10),
    hadd_compl varchar(200),
    hadd_city varchar(50),
    hadd_stt_id integer,
    hadd_cnt_id integer,
    hadd_is_delivery boolean,
    hadd_is_billing boolean,
    hadd_is_main boolean,
    hadd_is_active boolean,
    hadd_nickname varchar(50),
	hadd_date timestamptz NOT NULL,
	hadd_operation	char(6) NOT NULL
);

CREATE TABLE h_user_cards(
    hcrd_id INTEGER NOT NULL,
    hcrd_usr_id integer,
    hcrd_ccp_id integer,
    hcrd_expiration char(5),
    hcrd_number char(16),
    hcrd_cvv varchar(4),
    hcrd_holder varchar(30),
    hcrd_is_active boolean,
	hcrd_date timestamptz NOT NULL,
	hcrd_operation	char(6) NOT NULL
);

CREATE TABLE h_user_order(
    hord_id INTEGER NOT NULL,
    hord_cli_id integer,
    hord_date date,
    hord_last_modified date,
    hord_sts_id integer,
    hord_add_shipping integer,
    hord_add_billing integer,
	hord_register_date timestamptz NOT NULL,
	hord_operation	char(6) NOT NULL
);

CREATE TABLE h_order_item(
    hoit_id INTEGER NOT NULL,
    hoit_ord_id integer,
    hoit_bks_id integer,
    hoit_quantity integer,
    hoit_sts_id integer,
    hoit_date date,
    hoit_last_modified date,
    hoit_return_motive varchar(2000),
	hoit_register_date timestamptz NOT NULL,
	hoit_operation	char(6) NOT NULL
);

CREATE TABLE h_user_cart(
    hcrt_id INTEGER NOT NULL,
    hcrt_usr_id integer,
	hcrt_date timestamptz NOT NULL,
	hcrt_operation	char(6) NOT NULL
);

CREATE TABLE h_cart_items(
    hcit_bks_id integer,
    hcit_crt_id integer,
    hcit_quantity integer,
	hcit_date timestamptz NOT NULL,
	hcit_operation	char(6) NOT NULL
);

CREATE TABLE h_order_payment(
    horp_id INTEGER NOT NULL,
    horp_ord_id integer,
    horp_crd_id integer,
    horp_amount numeric(8,3),
	horp_date timestamptz NOT NULL,
	horp_operation	char(6) NOT NULL
);

CREATE TABLE h_vouchers(
    hvou_id INTEGER NOT NULL,
    hvou_usr_id integer,
    hvou_expiration date,
    hvou_creation date,
    hvou_code varchar(20),
    hvou_amount numeric(8,3),
    hvou_is_active boolean,
	hvou_date timestamptz NOT NULL,
	hvou_operation	char(6) NOT NULL
);

CREATE TABLE h_wishlist(
    hwsl_id INTEGER NOT NULL,
    hwsl_usr_id integer,
    hwsl_name varchar(200),
    hwsl_creation_date date,
    hwsl_last_update date,
	hwsl_date timestamptz NOT NULL,
	hwsl_operation	char(6) NOT NULL
);

CREATE TABLE h_wishlist_item(
    hwit_wsl_id integer,
    hwit_bks_id integer,
    hwit_quantity integer,
	hwit_date timestamptz NOT NULL,
	hwit_operation	char(6) NOT NULL
);


-- Unique Constraints
ALTER TABLE books ADD CONSTRAINT uq_bks_isbn UNIQUE (bks_isbn);
ALTER TABLE categories ADD CONSTRAINT uq_cat_name UNIQUE (cat_name);
ALTER TABLE authors ADD CONSTRAINT uq_aut_name UNIQUE (aut_name);
ALTER TABLE book_authors ADD CONSTRAINT uq_bka UNIQUE (bka_bks_id, bka_aut_id);
ALTER TABLE access_credentials ADD CONSTRAINT uq_acc_username UNIQUE (acc_username);
ALTER TABLE users ADD CONSTRAINT uq_usr_federal_id UNIQUE (usr_federal_id);
ALTER TABLE countries ADD CONSTRAINT uq_cnt_name UNIQUE (cnt_name);
ALTER TABLE countries ADD CONSTRAINT uq_cnt_code UNIQUE (cnt_code);
ALTER TABLE states ADD CONSTRAINT uq_stt_name UNIQUE (stt_name);
ALTER TABLE states ADD CONSTRAINT uq_stt_code UNIQUE (stt_code);
ALTER TABLE user_address ADD CONSTRAINT uq_add_nickname UNIQUE (add_usr_id, add_nickname);
ALTER TABLE card_companies ADD CONSTRAINT uq_ccp_name UNIQUE (ccp_name);
ALTER TABLE card_companies ADD CONSTRAINT uq_ccp_acronym UNIQUE (ccp_acronym);
ALTER TABLE user_cards ADD CONSTRAINT uq_crd_number UNIQUE (crd_number);
ALTER TABLE vouchers ADD CONSTRAINT uq_vou_code UNIQUE (vou_code);
ALTER TABLE states ADD CONSTRAINT uq_stt_code UNIQUE (stt_code);
ALTER TABLE countries ADD CONSTRAINT uq_cnt_code UNIQUE (cnt_code);
ALTER TABLE status ADD CONSTRAINT uq_sts_code UNIQUE (sts_code);


-- Foreign Key Constraints
ALTER TABLE book_authors ADD CONSTRAINT fk_bka_bks FOREIGN KEY (bka_bks_id) REFERENCES books(bks_id);
ALTER TABLE book_authors ADD CONSTRAINT fk_bka_aut FOREIGN KEY (bka_aut_id) REFERENCES authors(aut_id);
ALTER TABLE book_categories ADD CONSTRAINT fk_bkc_bks FOREIGN KEY (bkc_bks_id) REFERENCES books(bks_id);
ALTER TABLE book_categories ADD CONSTRAINT fk_bkc_cat FOREIGN KEY (bkc_cat_id) REFERENCES categories(cat_id);
ALTER TABLE book_images ADD CONSTRAINT fk_img_bks FOREIGN KEY (img_bks_id) REFERENCES books(bks_id);
ALTER TABLE books ADD CONSTRAINT fk_bks_pub FOREIGN KEY (bks_pub_id) REFERENCES publishers(pub_id);
ALTER TABLE users ADD CONSTRAINT fk_usr_acc FOREIGN KEY (usr_access_credential) REFERENCES access_credentials(acc_id);
ALTER TABLE user_address ADD CONSTRAINT fk_add_usr FOREIGN KEY (add_usr_id) REFERENCES users(usr_id);
ALTER TABLE user_address ADD CONSTRAINT fk_add_stt FOREIGN KEY (add_stt_id) REFERENCES states(stt_code);
ALTER TABLE user_address ADD CONSTRAINT fk_add_cnt FOREIGN KEY (add_cnt_id) REFERENCES countries(cnt_code);
ALTER TABLE user_cards ADD CONSTRAINT fk_crd_usr FOREIGN KEY (crd_usr_id) REFERENCES users(usr_id);
ALTER TABLE user_cards ADD CONSTRAINT fk_crd_ccp FOREIGN KEY (crd_ccp_id) REFERENCES card_companies(ccp_id);
ALTER TABLE vouchers ADD CONSTRAINT fk_vou_usr FOREIGN KEY (vou_usr_id) REFERENCES users(usr_id);
ALTER TABLE user_order ADD CONSTRAINT fk_ord_add_shipping FOREIGN KEY (ord_add_shipping) REFERENCES user_address(add_id);
ALTER TABLE user_order ADD CONSTRAINT fk_ord_add_billing FOREIGN KEY (ord_add_billing) REFERENCES user_address(add_id);
ALTER TABLE user_order ADD CONSTRAINT fk_ord_stt FOREIGN KEY(ord_sts_id) REFERENCES status(sts_code);
ALTER TABLE order_item ADD CONSTRAINT fk_oit_ord FOREIGN KEY (oit_ord_id) REFERENCES user_order(ord_id);
ALTER TABLE order_item ADD CONSTRAINT fk_oit_sts FOREIGN KEY (oit_sts_id) REFERENCES status(sts_code);
ALTER TABLE order_item ADD CONSTRAINT fk_oit_bks FOREIGN KEY (oit_bks_id) REFERENCES books(bks_id);
ALTER TABLE order_payment ADD CONSTRAINT fk_orp_ord FOREIGN KEY (orp_ord_id) REFERENCES user_order(ord_id);
ALTER TABLE order_payment ADD CONSTRAINT fk_orp_crd FOREIGN KEY (orp_crd_id) REFERENCES user_cards(crd_id);
ALTER TABLE wishlist ADD CONSTRAINT fk_wsl_usr FOREIGN KEY (wsl_usr_id) REFERENCES users(usr_id);
ALTER TABLE wishlist_item ADD CONSTRAINT fk_wit_wsl FOREIGN KEY (wit_wsl_id) REFERENCES wishlist(wsl_id);
ALTER TABLE wishlist_item ADD CONSTRAINT fk_wit_bks FOREIGN KEY (wit_bks_id) REFERENCES books(bks_id);

-- Views

-- Select most used item data for each item order
DROP VIEW IF EXISTS order_item_data;
CREATE VIEW order_item_data AS (
    SELECT oit_id, oit_ord_id, oit_quantity, oit_sts_id, oit_return_motive, bks_id, bks_title, bks_price, bks_inStock, img_path
    FROM order_item
    JOIN books ON oit_bks_id = bks_id
    JOIN (
        SELECT DISTINCT ON(img_bks_id) img_path, img_bks_id
        FROM book_images
    ) AS image ON bks_id = img_bks_id
);

-- Triggers

-- Update current amount in stock on order acceptance
CREATE OR REPLACE FUNCTION update_product() RETURNS TRIGGER AS $update_product$
	BEGIN
		IF (NEW.oit_sts_id = 2) THEN
			UPDATE books SET bks_inStock = bks_inStock - NEW.oit_quantity WHERE bks_id = NEW.oit_bks_id;
		END IF;
		RETURN NULL;
	END
$update_product$ LANGUAGE plpgsql;

CREATE TRIGGER update_product
	AFTER UPDATE ON order_item
		FOR EACH ROW EXECUTE PROCEDURE update_product();

-- Triggers to generate history/audit data

CREATE OR REPLACE FUNCTION audit_book() RETURNS TRIGGER AS $audit_book$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_books SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_books SELECT
				coalesce(NEW.bks_id, OLD.bks_id),
				coalesce(NEW.bks_title, OLD.bks_title),
				coalesce(NEW.bks_pub_id, OLD.bks_pub_id),
				coalesce(NEW.bks_pub_year, OLD.bks_pub_year),
				coalesce(NEW.bks_pub_edition, OLD.bks_pub_edition),
				coalesce(NEW.bks_language, OLD.bks_language),
				coalesce(NEW.bks_isbn, OLD.bks_isbn),
				coalesce(NEW.bks_summary, OLD.bks_summary),
				coalesce(NEW.bks_height, OLD.bks_height),
				coalesce(NEW.bks_width, OLD.bks_width),
				coalesce(NEW.bks_depth, OLD.bks_depth),
				coalesce(NEW.bks_weight, OLD.bks_weight),
				coalesce(NEW.bks_price, OLD.bks_price),
				coalesce(NEW.bks_inStock, OLD.bks_inStock),
				coalesce(NEW.bks_pages, OLD.bks_pages),
				coalesce(NEW.bks_is_active, OLD.bks_is_active),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_book$ LANGUAGE plpgsql;

CREATE TRIGGER book_audit
	AFTER INSERT OR UPDATE ON books
		FOR EACH ROW EXECUTE PROCEDURE audit_book();

CREATE OR REPLACE FUNCTION audit_pub() RETURNS TRIGGER AS $audit_pub$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_publishers SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_publishers SELECT
				coalesce(NEW.pub_id, OLD.pub_id),
				coalesce(NEW.pub_name, OLD.pub_name),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_pub$ LANGUAGE plpgsql;

CREATE TRIGGER pub_audit
	AFTER INSERT OR UPDATE ON publishers
		FOR EACH ROW EXECUTE PROCEDURE audit_pub();

CREATE OR REPLACE FUNCTION audit_cat() RETURNS TRIGGER AS $audit_cat$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_categories SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_categories SELECT
				coalesce(NEW.cat_id, OLD.cat_id),
				coalesce(NEW.cat_name, OLD.cat_name),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_cat$ LANGUAGE plpgsql;

CREATE TRIGGER cat_audit
	AFTER INSERT OR UPDATE ON categories
		FOR EACH ROW EXECUTE PROCEDURE audit_cat();

CREATE OR REPLACE FUNCTION audit_authors() RETURNS TRIGGER AS $audit_authors$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_authors SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_authors SELECT
				coalesce(NEW.aut_id, OLD.aut_id),
				coalesce(NEW.aut_name, OLD.aut_name),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_authors$ LANGUAGE plpgsql;

CREATE TRIGGER authors_audit
	AFTER INSERT OR UPDATE ON authors
		FOR EACH ROW EXECUTE PROCEDURE audit_authors();

CREATE OR REPLACE FUNCTION audit_book_authors() RETURNS TRIGGER AS $audit_book_authors$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_book_authors SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_book_authors SELECT
				coalesce(NEW.bka_bks_id, OLD.bka_bks_id),
				coalesce(NEW.bka_aut_id, OLD.bka_aut_id),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_book_authors$ LANGUAGE plpgsql;

CREATE TRIGGER book_authors_audit
	AFTER INSERT OR UPDATE ON book_authors
		FOR EACH ROW EXECUTE PROCEDURE audit_book_authors();

CREATE OR REPLACE FUNCTION audit_book_categories() RETURNS TRIGGER AS $audit_book_categories$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_book_categories SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_book_categories SELECT
				coalesce(NEW.bkc_cat_id, OLD.bkc_cat_id),
				coalesce(NEW.bkc_bks_id, OLD.bkc_bks_id),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_book_categories$ LANGUAGE plpgsql;

CREATE TRIGGER book_categories_audit
	AFTER INSERT OR UPDATE ON book_categories
		FOR EACH ROW EXECUTE PROCEDURE audit_book_categories();

CREATE OR REPLACE FUNCTION audit_book_images() RETURNS TRIGGER AS $audit_book_images$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_book_images SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_book_images SELECT
				coalesce(NEW.img_id, OLD.img_id),
				coalesce(NEW.img_path, OLD.img_path),
				coalesce(NEW.img_bks_id, OLD.img_bks_id),
				coalesce(NEW.img_is_active, OLD.img_is_active),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_book_images$ LANGUAGE plpgsql;

CREATE TRIGGER book_images_audit
	AFTER INSERT OR UPDATE ON book_images
		FOR EACH ROW EXECUTE PROCEDURE audit_book_images();

CREATE OR REPLACE FUNCTION audit_access_credentials() RETURNS TRIGGER AS $audit_access_credentials$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_access_credentials SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_access_credentials SELECT
				coalesce(NEW.acc_id, OLD.acc_id),
				coalesce(NEW.acc_username, OLD.acc_username),
				coalesce(NEW.acc_pw, OLD.acc_pw),
				coalesce(NEW.acc_creation_date, OLD.acc_creation_date),
				coalesce(NEW.acc_last_access, OLD.acc_last_access),
				coalesce(NEW.acc_is_active, OLD.acc_is_active),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_access_credentials$ LANGUAGE plpgsql;

CREATE TRIGGER access_credentials_audit
	AFTER INSERT OR UPDATE ON access_credentials
		FOR EACH ROW EXECUTE PROCEDURE audit_access_credentials();

CREATE OR REPLACE FUNCTION audit_users() RETURNS TRIGGER AS $audit_users$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_users SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_users SELECT
				coalesce(NEW.usr_id, OLD.usr_id),
				coalesce(NEW.usr_access_credential, OLD.usr_access_credential),
				coalesce(NEW.usr_name, OLD.usr_name),
				coalesce(NEW.usr_nickname, OLD.usr_nickname),
				coalesce(NEW.usr_federal_id, OLD.usr_federal_id),
				coalesce(NEW.usr_bday, OLD.usr_bday),
				coalesce(NEW.usr_area_code, OLD.usr_area_code),
				coalesce(NEW.usr_phone, OLD.usr_phone),
				coalesce(NEW.usr_is_active, OLD.usr_is_active),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_users$ LANGUAGE plpgsql;

CREATE TRIGGER users_audit
	AFTER INSERT OR UPDATE ON users
		FOR EACH ROW EXECUTE PROCEDURE audit_users();

CREATE OR REPLACE FUNCTION audit_user_address() RETURNS TRIGGER AS $audit_user_address$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_user_address SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_user_address SELECT
				coalesce(NEW.add_id, OLD.add_id),
				coalesce(NEW.add_usr_id, OLD.add_usr_id),
				coalesce(NEW.add_place, OLD.add_place),
				coalesce(NEW.add_number, OLD.add_number),
				coalesce(NEW.add_neighborhood, OLD.add_neighborhood),
				coalesce(NEW.add_zipcode, OLD.add_zipcode),
				coalesce(NEW.add_compl, OLD.add_compl),
				coalesce(NEW.add_city, OLD.add_city),
				coalesce(NEW.add_stt_id, OLD.add_stt_id),
				coalesce(NEW.add_cnt_id, OLD.add_cnt_id),
				coalesce(NEW.add_is_delivery, OLD.add_is_delivery),
				coalesce(NEW.add_is_billing, OLD.add_is_billing),
				coalesce(NEW.add_is_main, OLD.add_is_main),
				coalesce(NEW.add_is_active, OLD.add_is_active),
				coalesce(NEW.add_nickname, OLD.add_nickname),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_user_address$ LANGUAGE plpgsql;

CREATE TRIGGER user_address_audit
	AFTER INSERT OR UPDATE ON user_address
		FOR EACH ROW EXECUTE PROCEDURE audit_user_address();

CREATE OR REPLACE FUNCTION audit_user_cards() RETURNS TRIGGER AS $audit_user_cards$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_user_cards SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_user_cards SELECT
				coalesce(NEW.crd_id, OLD.crd_id),
				coalesce(NEW.crd_usr_id, OLD.crd_usr_id),
				coalesce(NEW.crd_ccp_id, OLD.crd_ccp_id),
				coalesce(NEW.crd_expiration, OLD.crd_expiration),
				coalesce(NEW.crd_number, OLD.crd_number),
				coalesce(NEW.crd_cvv, OLD.crd_cvv),
				coalesce(NEW.crd_holder, OLD.crd_holder),
				coalesce(NEW.crd_is_active, OLD.crd_is_active),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_user_cards$ LANGUAGE plpgsql;

CREATE TRIGGER user_cards_audit
	AFTER INSERT OR UPDATE ON user_cards
		FOR EACH ROW EXECUTE PROCEDURE audit_user_cards();

CREATE OR REPLACE FUNCTION audit_user_order() RETURNS TRIGGER AS $audit_user_order$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_user_order SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_user_order SELECT
				coalesce(NEW.ord_id, OLD.ord_id),
				coalesce(NEW.ord_cli_id, OLD.ord_cli_id),
				coalesce(NEW.ord_date, OLD.ord_date),
				coalesce(NEW.ord_modified, OLD.ord_last_modiified),
				coalesce(NEW.ord_sts_id, OLD.ord_sts_id),
				coalesce(NEW.ord_add_shipping, OLD.ord_add_shipping),
				coalesce(NEW.ord_add_billing, OLD.ord_add_billing),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_user_order$ LANGUAGE plpgsql;

CREATE TRIGGER user_order_audit
	AFTER INSERT OR UPDATE ON user_order
		FOR EACH ROW EXECUTE PROCEDURE audit_user_order();

CREATE OR REPLACE FUNCTION audit_order_item() RETURNS TRIGGER AS $audit_order_item$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_order_item SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_order_item SELECT
				coalesce(NEW.oit_id, OLD.oit_id),
				coalesce(NEW.oit_ord_id, OLD.oit_ord_id),
				coalesce(NEW.oit_bks_id, OLD.oit_bks_id),
				coalesce(NEW.oit_quantity, OLD.oit_quantity),
				coalesce(NEW.oit_sts_id, OLD.oit_sts_id),
				coalesce(NEW.oit_date, OLD.oit_date),
				coalesce(NEW.oit_last_modified, OLD.oit_last_modified),
				coalesce(NEW.oit_return_motive, OLD.oit_return_motive),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_order_item$ LANGUAGE plpgsql;

CREATE TRIGGER order_item_audit
	AFTER INSERT OR UPDATE ON order_item
		FOR EACH ROW EXECUTE PROCEDURE audit_order_item();

CREATE OR REPLACE FUNCTION audit_user_cart() RETURNS TRIGGER AS $audit_user_cart$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_user_cart SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_user_cart SELECT
				coalesce(NEW.crt_id, OLD.crt_id),
				coalesce(NEW.crt_usr_id, OLD.crt_usr_id),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_user_cart$ LANGUAGE plpgsql;

CREATE TRIGGER user_cart_audit
	AFTER INSERT OR UPDATE ON user_cart
		FOR EACH ROW EXECUTE PROCEDURE audit_user_cart();

CREATE OR REPLACE FUNCTION audit_cart_items() RETURNS TRIGGER AS $audit_cart_items$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_cart_items SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_cart_items SELECT
				coalesce(NEW.cit_bks_id, OLD.cit_bks_id),
				coalesce(NEW.cit_crt_id, OLD.cit_crt_id),
				coalesce(NEW.cit_quantity, OLD.cit_quantity),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_cart_items$ LANGUAGE plpgsql;

CREATE TRIGGER cart_items_audit
	AFTER INSERT OR UPDATE ON cart_items
		FOR EACH ROW EXECUTE PROCEDURE audit_cart_items();

CREATE OR REPLACE FUNCTION audit_order_payment() RETURNS TRIGGER AS $audit_order_payment$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_order_payment SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_order_payment SELECT
				coalesce(NEW.orp_id, OLD.orp_id),
				coalesce(NEW.orp_ord_id, OLD.orp_ord_id),
				coalesce(NEW.orp_crd_id, OLD.orp_crd_id),
				coalesce(NEW.orp_amount, OLD.orp_amount),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_order_payment$ LANGUAGE plpgsql;

CREATE TRIGGER order_payment_audit
	AFTER INSERT OR UPDATE ON order_payment
		FOR EACH ROW EXECUTE PROCEDURE audit_order_payment();

CREATE OR REPLACE FUNCTION audit_vouchers() RETURNS TRIGGER AS $audit_vouchers$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_vouchers SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_vouchers SELECT
				coalesce(NEW.vou_id, OLD.vou_id),
				coalesce(NEW.vou_usr_id, OLD.vou_usr_id),
				coalesce(NEW.vou_expiration, OLD.vou_expiration),
				coalesce(NEW.vou_creation, OLD.vou_creation),
				coalesce(NEW.vou_code, OLD.vou_code),
				coalesce(NEW.vou_amout, OLD.vou_amount),
				coalesce(NEW.vou_is_active, OLD.vou_is_active),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_vouchers$ LANGUAGE plpgsql;

CREATE TRIGGER vouchers_audit
	AFTER INSERT OR UPDATE ON vouchers
		FOR EACH ROW EXECUTE PROCEDURE audit_vouchers();

CREATE OR REPLACE FUNCTION audit_wishlist() RETURNS TRIGGER AS $audit_wishlist$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_wishlist SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_wishlist SELECT
				coalesce(NEW.wsl_id, OLD.wsl_id),
				coalesce(NEW.wsl_usr_id, OLD.wsl_usr_id),
				coalesce(NEW.wsl_name, OLD.wsl_name),
				coalesce(NEW.wsl_creation_date, OLD.wsl_creation_date),
				coalesce(NEW.wsl_last_update, OLD.wsl_last_update),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_wishlist$ LANGUAGE plpgsql;

CREATE TRIGGER wishlist_audit
	AFTER INSERT OR UPDATE ON wishlist
		FOR EACH ROW EXECUTE PROCEDURE audit_wishlist();


CREATE OR REPLACE FUNCTION audit_wishlist_item() RETURNS TRIGGER AS $audit_wishlist_item$
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			INSERT INTO h_wishlist_item SELECT NEW.*, now(), 'INSERT';
		ELSE
			INSERT INTO h_wishlist_item SELECT
				coalesce(NEW.wit_wsl_id, OLD.wit_wsl_id),
				coalesce(NEW.wit_bks_id, OLD.wit_bks_id),
				coalesce(NEW.wit_quantity, OLD.wit_quantity),
				now(), 'UPDATE';
		END IF;
		RETURN NULL;
	END
$audit_wishlist_item$ LANGUAGE plpgsql;

CREATE TRIGGER wishlist_item_audit
	AFTER INSERT OR UPDATE ON wishlist_item
		FOR EACH ROW EXECUTE PROCEDURE audit_wishlist_item();

-- DB Data
-- States
INSERT INTO states (stt_code, stt_name)  VALUES
     (11, 'Rondônia / RO'),
     (12, 'Acre / AC'),
     (13, 'Amazonas / AM'),
     (14, 'Roraima / RR'),
     (15, 'Pará / PA'),
     (16, 'Amapá / AP'),
     (17, 'Tocantins / TO'),
     (21, 'Maranhão / MA'),
     (22, 'Piauí / PI'),
     (23, 'Ceará / CE'),
     (24, 'Rio Grande do Norte / RN'),
     (25, 'Paraíba / PB'),
     (26, 'Pernambuco / PE'),
     (27, 'Alagoas / AL'),
     (28, 'Sergipe / SE'),
     (29, 'Bahia / BA'),
     (31, 'Minas Gerais / MG'),
     (32, 'Espírito Santo / ES'),
     (33, 'Rio de Janeiro / RJ'),
     (35, 'São Paulo / SP'),
     (41, 'Paraná / PR'),
     (42, 'Santa Catarina / SC'),
     (43, 'Rio Grande do Sul / RS'),
     (50, 'Mato Grosso do Sul / MS'),
     (51, 'Mato Grosso / MT'),
     (52, 'Goiás / GO'),
     (53, 'Distrito Federal / DF'),
     (99, 'Exterior');

-- Countries
INSERT INTO countries (cnt_code, cnt_name) VALUES
    (4, 'Afeganistão'),
    (710, 'África do Sul'),
    (8, 'Albânia'),
    (276, 'Alemanha'),
    (12, 'Algéria'),
    (20, 'Andorra'),
    (24, 'Angola'),
    (660, 'Anguilla'),
    (10, 'Antártica'),
    (28, 'Antigua e Barbuda'),
    (682, 'Arábia Saudita'),
    (32, 'Argentina'),
    (51, 'Armênia'),
    (533, 'Aruba'),
    (36, 'Austrália'),
    (40, 'Áustria'),
    (31, 'Azerbaijão'),
    (44, 'Bahamas'),
    (48, 'Bahrain'),
    (50, 'Bangladesh'),
    (52, 'Barbados'),
    (112, 'Bielorrússia'),
    (56, 'Bélgica'),
    (84, 'Belize'),
    (204, 'Benin'),
    (60, 'Bermudas'),
    (68, 'Bolívia'),
    (535, 'Bonaire, Sint Eustatius e Saba'),
    (70, 'Bósnia e Herzegovina'),
    (72, 'Botswana'),
    (76, 'Brasil'),
    (96, 'Brunei Darussalam'),
    (100, 'Bulgaria'),
    (854, 'Burkina Faso'),
    (108, 'Burundi'),
    (64, 'Butão'),
    (132, 'Cabo Verde'),
    (120, 'Camarões'),
    (116, 'Camboja'),
    (124, 'Canadá'),
    (634, 'Catar'),
    (398, 'Cazaquistão'),
    (148, 'Chade'),
    (152, 'Chile'),
    (156, 'China'),
    (196, 'Chipre'),
    (170, 'Colômbia'),
    (174, 'Comoros'),
    (408, 'Coréia do Norte'),
    (410, 'Coréia do Sul'),
    (384, 'Costa do Marfim'),
    (188, 'Costa Rica'),
    (191, 'Croácia'),
    (192, 'Cuba'),
    (531, 'Curaçao'),
    (208, 'Dinamarca'),
    (262, 'Djibouti'),
    (212, 'Dominica'),
    (818, 'Egito'),
    (222, 'El Salvador'),
    (784, 'Emirados Árabes Unidos'),
    (218, 'Equador'),
    (232, 'Eritrea'),
    (703, 'Eslovaquia'),
    (705, 'Eslovênia'),
    (724, 'Espanha'),
    (840, 'Estados Unidos'),
    (748, 'Essuatíni'),
    (233, 'Estonia'),
    (231, 'Etiópia'),
    (242, 'Fiji'),
    (608, 'Filipinas'),
    (246, 'Finlândia'),
    (250, 'França'),
    (266, 'Gabão'),
    (270, 'Gâmbia'),
    (288, 'Gana'),
    (268, 'Geórgia'),
    (292, 'Gibraltar'),
    (300, 'Grécia'),
    (304, 'Groenlândia'),
    (308, 'Grenada'),
    (312, 'Guadalupe'),
    (316, 'Guam'),
    (320, 'Guatemala'),
    (831, 'Guernsey'),
    (328, 'Guiana'),
    (254, 'Guiana Francesa'),
    (324, 'Guiné'),
    (624, 'Guiné-Bissau'),
    (226, 'Guiné Equatorial'),
    (332, 'Haiti'),
    (528, 'Holanda'),
    (340, 'Honduras'),
    (344, 'Hong Kong'),
    (348, 'Hungria'),
    (887, 'Iêmen'),
    (248, 'Ilhas Aaland'),
    (74, 'Ilhas Bouvet'),
    (136, 'Ilhas Cayman'),
    (162, 'Ilhas Christmas'),
    (166, 'Ilhas Cocos (Keeling)'),
    (184, 'Ilhas Cook'),
    (833, 'Ilha de Man'),
    (238, 'Ilhas Falkland (Malvinas)'),
    (234, 'Ilhas Faroe'),
    (239, 'Ilhas Geórgias do Sul e Sandwich do Sul'),
    (334, 'Ilhas Heard and Mc Donald'),
    (580, 'Ilhas Marianas Setentrionais'),
    (584, 'Ilhas Marshall'),
    (581, 'Ilhas Menores Distantes dos Estados Unidos'),
    (612, 'Ilhas Pitcairn'),
    (90, 'Ilhas Salomão'),
    (796, 'Ilhas Turcas e Caicos'),
    (850, 'Ilhas Virgens Americanas'),
    (92, 'Ilhas Virgens Britânicas'),
    (356, 'Índia'),
    (360, 'Indonésia'),
    (364, 'Irã (República Islâmica do)'),
    (352, 'Islâdia'),
    (368, 'Iraque'),
    (372, 'Irlanda'),
    (376, 'Israel'),
    (380, 'Itália'),
    (388, 'Jamaica'),
    (392, 'Japão'),
    (832, 'Jersey'),
    (400, 'Jordânia'),
    (296, 'Kiribati'),
    (898, 'Kosovo, República do'),
    (414, 'Kuwait'),
    (418, 'Laos'),
    (428, 'Letônia'),
    (422, 'Líbano'),
    (434, 'Líbia'),
    (426, 'Lesoto'),
    (430, 'Libéria'),
    (438, 'Liechtenstein'),
    (440, 'Lituânia'),
    (442, 'Luxemburgo'),
    (446, 'Macau'),
    (807, 'Macedônia do Norte'),
    (450, 'Madagascar'),
    (454, 'Malawi'),
    (458, 'Malásia'),
    (462, 'Maldivas'),
    (466, 'Mali'),
    (470, 'Malta'),
    (504, 'Marrocos'),
    (474, 'Martinica'),
    (480, 'Maurícia'),
    (478, 'Mauritânia'),
    (175, 'Mayotte'),
    (484, 'México'),
    (583, 'Micronésia'),
    (508, 'Moçambique'),
    (498, 'Moldova'),
    (492, 'Mônaco'),
    (496, 'Mongólia'),
    (499, 'Montenegro'),
    (500, 'Montserrat'),
    (104, 'Myanmar'),
    (516, 'Namíbia'),
    (520, 'Nauru'),
    (524, 'Nepal'),
    (540, 'Nova Caledônia'),
    (554, 'Nova Zealândia'),
    (558, 'Nicarágua'),
    (562, 'Níger'),
    (566, 'Nigéria'),
    (570, 'Niue'),
    (574, 'Norfolk'),
    (578, 'Noruega'),
    (512, 'Omã'),
    (586, 'Paquistão'),
    (585, 'Palau'),
    (275, 'Palestina'),
    (591, 'Panamá'),
    (598, 'Papua Nova Guiné'),
    (600, 'Paraguai'),
    (604, 'Peru'),
    (616, 'Polônia'),
    (258, 'Polinésia Francesa'),
    (620, 'Portugal'),
    (630, 'Porto Rico'),
    (404, 'Quênia'),
    (417, 'Quirguistão'),
    (826, 'Reino Unido'),
    (140, 'República da África Central'),
    (180, 'República Democrática do Congo'),
    (178, 'República do Congo'),
    (203, 'República Tcheca'),
    (638, 'Reunião (DOM)'),
    (642, 'România'),
    (646, 'Ruanda'),
    (643, 'Rússia'),
    (732, 'Saara Ocidental'),
    (882, 'Samoa'),
    (16, 'Samoa Americana'),
    (674, 'San Marino'),
    (654, 'Santa Helena, Ascención, e Tristan da Cunha'),
    (662, 'Santa Lúcia'),
    (652, 'São Bartolomeu'),
    (659, 'São Cristóvão e Neves'),
    (663, 'São Martin (França)'),
    (534, 'São Martin (Holanda)'),
    (666, 'São Pierre e Miquelon'),
    (678, 'São Tomé e Príncipe'),
    (670, 'São Vicente e Grenadinas'),
    (686, 'Senegal'),
    (694, 'Serra Leoa'),
    (688, 'Sérvia'),
    (690, 'Seychelles'),
    (702, 'Singapura'),
    (760, 'Síria'),
    (706, 'Somália'),
    (144, 'Sri Lanka'),
    (728, 'Sudão do Sul'),
    (729, 'Sudão'),
    (752, 'Suécia'),
    (756, 'Suíça'),
    (740, 'Suriname'),
    (744, 'Svalbard e Ilhas Jan Mayen'),
    (764, 'Tailândia'),
    (158, 'Taiwan'),
    (762, 'Tajiquiistão'),
    (834, 'Tanzânia'),
    (260, 'Terras Austrais Francesas'),
    (86, 'Território Britânico do Oceano Índico'),
    (626, 'Timor Leste'),
    (768, 'Togo'),
    (772, 'Tokelau'),
    (776, 'Tonga'),
    (780, 'Trinidade e Tobago'),
    (788, 'Tunísia'),
    (792, 'Turquia'),
    (795, 'Turcomenistão'),
    (798, 'Tuvalu'),
    (804, 'Ucrânia'),
    (800, 'Uganda'),
    (858, 'Uruguai'),
    (860, 'Uzbequistão'),
    (548, 'Vanuatu'),
    (336, 'Vaticano'),
    (862, 'Venezuela'),
    (704, 'Vietnã'),
    (876, 'Wallis e Futuna'),
    (894, 'Zâmbia'),
    (716, 'Zimbabwe');

-- User
INSERT INTO access_credentials (acc_username, acc_pw, acc_creation_date, acc_last_access, acc_is_active) VALUES
    ('test@user.com', 'teste123', now(), now(), true);

INSERT INTO users (usr_access_credential, usr_name, usr_nickname, usr_federal_id, usr_bday, usr_area_code, usr_phone, usr_is_active) VALUES
    (1, 'Alon Orion', 'Alon', '12345678997', '2000-07-13', '11', '987654321', true);

-- Credit Card Companies
INSERT INTO card_companies(ccp_code, ccp_name) VALUES
    ('1', 'MasterCard'),
    ('2', 'Visa'),
    ('3', 'American Express'),
    ('4', 'Diners Club'),
    ('5', 'Cirrus'),
    ('6', 'Discovery'),
    ('7', 'Elo'),
    ('8', 'Outro');

-- Order and Order Item Status
INSERT INTO status(sts_code, sts_label) VALUES
    (1, 'EM PROCESSAMENTO'),
    (2, 'APROVADA'),
    (3, 'EM TRÂNSITO'),
    (4, 'ENTREGUE'),
    (5, 'EM TROCA'),
    (6, 'TROCA AUTORIZADA'),
    (7, 'TROCADO'),
    (8, 'EM DEVOLUÇÃO'),
    (9, 'DEVOLVIDO'),
    (10, 'REPROVADA'),
    (11, 'EM FALTA')
    (12, 'CANCELAMENTO SOLICITADO'),
    (13, 'CANCELADO'),
    (14, 'DEVOLUÇÃO AUTORIZADA');