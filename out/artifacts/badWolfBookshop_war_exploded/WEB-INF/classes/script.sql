CREATE DATABASE badwolfbookshop;

-- Table Creation
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

CREATE TABLE publishers(
    pub_id SERIAL PRIMARY KEY,
    pub_name varchar(100)
);

CREATE TABLE categories(
    cat_id SERIAL PRIMARY KEY,
    cat_name varchar(150)
);

CREATE TABLE authors (
    aut_id SERIAL PRIMARY KEY,
    aut_name varchar(200)
);

CREATE TABLE book_authors (
    bka_bks_id integer,
    bka_aut_id integer
);

CREATE TABLE book_categories (
    bkc_cat_id integer,
    bkc_bks_id integer
);

CREATE TABLE book_images(
    img_id SERIAL PRIMARY KEY,
    img_path varchar(2000),
    img_bks_id integer,
    img_is_active boolean
);

CREATE TABLE access_credentials(
    acc_id SERIAL PRIMARY KEY,
    acc_username varchar,
    acc_pw varchar(50),
    acc_creation_date date,
    acc_last_access date,
    acc_is_active boolean
)

CREATE TABLE users(
    usr_id SERIAL PRIMARY KEY,
    usr_name varchar(200),
    usr_nickname varchar(30),
    usr_federal_id varchar(11),
    usr_bday date,
    usr_area_code varchar(5),
    usr_phone varchar(10),
    usr_is_active boolean
);

CREATE TABLE states(
    stt_id integer,
    stt_name varchar(30)
);

CREATE TABLE countries(
    cnt_id integer,
    cnt_name varchar(50)
);

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
    add_is_active boolean
);

CREATE TABLE card_companies(
    ccp_id SERIAL PRIMARY KEY,
    ccp_acronym varchar(3),
    ccp_name varchar(50)
);

CREATE TABLE user_cards(
    crd_id SERIAL PRIMARY KEY,
    crd_usr_id integer,
    crd_ccp_id integer,
    crd_expiration date,
    crd_number char(16),
    crd_cvv varchar(4),
    crd_holder varchar(30),
    crd_is_active boolean
);

CREATE TABLE user_cart(
    crt_id SERIAL PRIMARY KEY,
    crt_usr_id integer,
    crt_date date
);

CREATE TABLE cart_items(
    cit_bks_id integer,
    cit_crt_id integer
);

CREATE TABLE status(
    sts_id integer,
    sts_label varchar(20)
)

CREATE TABLE order(
    ord_id SERIAL PRIMARY KEY,
    ord_code varchar(20),
    ord_cli_id integer,
    ord_date date,
    ord_last_modified date,
    ord_sts_id integer
);

CREATE TABLE order_item(
    oit_ord_id integer,
    oit_bks_id integer,
    oit_quantity integer,
    oit_sts_id integer
);

CREATE TABLE returns(
    ret_ord_id integer,
    ret_bks_id integer,
    ret_date date,
    ret_reason varchar(2000),
    ret_is_approved boolean
);

CREATE TABLE vouchers(
    vou_id SERIAL PRIMARY KEY,
    vou_usr_id integer,
    vou_expiration date,
    vou_amout numeric(8,3),
    vou_is_used boolean,
    vou_is_active boolean
)

CREATE TABLE wishlist(
    wsl_id SERIAL PRIMARY KEY,
    wsl_usr_id integer,
    wsl_name varchar(200),
    wsl_creation_date date,
    wsl_last_update date
)

CREATE TABLE whishlist_item(
    wit_wsl_id integer,
    wit_bks_id integer,
    wit_quantity integer
)

CREATE TABLE operation_history(
    oph_id SERIAL PRIMARY KEY,
    oph_ord_id integer,
    oph_date date,
    oph_sts_id integer
)

-- Unique Constraints
ALTER TABLE books ADD CONSTRAINT uq_bks_isbn UNIQUE (bks_isbn);
ALTER TABLE categories ADD CONSTRAINT uq_cat_name UNIQUE (cat_name);
ALTER TABLE authors ADD CONSTRAINT uq_aut_name UNIQUE (aut_name);
ALTER TABLE book_authors ADD CONSTRAINT uq_bka UNIQUE (bka_bks_id, bka_aut_id);

-- Foreign Key Constraints
ALTER TABLE book_authors ADD CONSTRAINT fk_bka_bks FOREIGN KEY (bka_bks_id) REFERENCES books(bks_id);
ALTER TABLE book_authors ADD CONSTRAINT fk_bka_aut FOREIGN KEY (bka_aut_id) REFERENCES authors(aut_id);
ALTER TABLE book_categories ADD CONSTRAINT fk_bkc_bks FOREIGN KEY (bkc_bks_id) REFERENCES books(bks_id);
ALTER TABLE book_categories ADD CONSTRAINT fk_bkc_cat FOREIGN KEY (bkc_cat_id) REFERENCES categories(cat_id);
ALTER TABLE book_images ADD CONSTRAINT fk_img_bks FOREIGN KEY (img_bks_id) REFERENCES books(bks_id);
ALTER TABLE books ADD CONSTRAINT fk_bks_pub FOREIGN KEY (bks_pub_id) REFERENCES publishers(pub_id);
