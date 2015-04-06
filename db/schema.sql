create table if not exists auths (
    id          bigint unsigned auto_increment primary key,
    user_id     bigint unsigned not null,
    provider    varchar(255),
    config_pvt  mediumblob not null, 
    created_at  timestamp not null,

    key         auth_user_id(user_id)
);

create table if not exists users (
    id          bigint unsigned auto_increment primary key,
    card_id     bigint unsigned not null,
    country     char(2) not null,
    email       varchar(255) not null,
    crypt_of_pw varchar(255) not null,
    config      mediumblob not null, 
    config_pvt  mediumblob not null, 
    created_at  timestamp not null,
    public_key  text not null,
    private_key text not null,

    key         user_card_id(card_id)
);

create table if not exists cardnames (
    id          bigint unsigned auto_increment primary key,
    user_id     bigint unsigned not null,
    card_id     bigint unsigned not null,
    cardname    varchar(255),
    created_at  timestamp not null,

    key         cardname_user_id(user_id),
    key         cardname_card_id(card_id),
    unique key  cardname_cardname(cardname)
);

create table if not exists subscriptions (
    id          bigint unsigned auto_increment primary key,
    user_id     bigint unsigned not null,
    card_id     bigint unsigned not null,
    state       varchar(255),
    created_at  timestamp not null,

    key         subscription_user_id(user_id),
    key         subscription_card_id(card_id)
);

create table if not exists cards (
    id          bigint unsigned auto_increment primary key,
    user_id     bigint unsigned not null,
    orig_id     bigint unsigned,
    cardname_id bigint unsigned not null,
    longitude   mediumint,
    latitude    mediumint,
    priority    smallint unsigned,
    config      mediumblob not null,
    config_pvt  mediumblob not null, 
    version_at  datetime,
    created_at  timestamp not null,

    key         card_user_id(user_id),
    key         card_cardname_id(cardname_id),
    key         card_version(version_at)
);

create table if not exists card_versions (
    id          bigint unsigned auto_increment primary key,
    card_id     bigint unsigned not null,
    fields      mediumblob,
    fields_pvt  mediumblob,
    is_crypted  char(1),
    created_at  timestamp not null,

    key         card_version_card_id(card_id),
    key         card_version_created(created_at)
);

create table if not exists fields (
    id          smallint unsigned auto_increment primary key,
    name        varchar(255) not null,
    created_at  timestamp not null
);

create table if not exists field_values (
    id          bigint unsigned auto_increment primary key,
    card_id     bigint unsigned not null,
    field_id    smallint unsigned not null,
    value       blob,
    is_private  char(1),
    updated_at  datetime,
    created_at  timestamp not null,

    key         field_value_card(card_id),
    key         field_value_field(field_id)
);

create table if not exists payments (
    id          bigint unsigned auto_increment primary key,
    user_id     bigint unsigned not null,
    created_at  timestamp not null,
    currency    char(3),
    amount      decimal(9,2),
    account     varchar(255),
    reference   varchar(255),
    product     varchar(255),
    period      varchar(255),
    coupon      varchar(255),

    key         payment_user(user_id),
    key         payment_created(created_at)
);
