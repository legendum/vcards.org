create table if not exists servers (
    id          bigint unsigned auto_increment primary key,
    user_id     bigint unsigned not null,
    hostname    smalltext not null,
    created_at  timestamp not null
);

create table if not exists users (
    id          bigint unsigned auto_increment primary key,
    server_id   bigint unsigned not null,
    card_id     bigint unsigned not null,
    country     char(2) not null,
    config      mediumtext not null, 
    password    smalltext not null,
    public_key  mediumtext not null,
    private_key mediumtext not null,
    updated_at  datetime,
    created_at  timestamp not null
);

create table if not exists cardnames (
    id          bigint unsigned auto_increment primary key,
    server_id   bigint unsigned not null,
    user_id     bigint unsigned not null,
    card_id     bigint unsigned not null,
    cardname    smalltext,
    created_at  timestamp not null
);

create table if not exists subscriptions (
    id          bigint unsigned auto_increment primary key,
    user_id     bigint unsigned not null,
    card_id     bigint unsigned not null,
    state       smalltext,
    created_at  timestamp not null
);

create table if not exists cards (
    id          bigint unsigned auto_increment primary key,
    user_id     bigint unsigned not null,
    orig_id     bigint unsigned,
    cardname_id bigint unsigned not null,
    field_cache mediumblob,
    field_delta mediumblob,
    longitude   mediumint,
    latitude    mediumint,
    updated_at  datetime,
    created_at  timestamp not null
);

create table if not exists fields (
    id          bigint unsigned auto_increment primary key,
    name        varchar(255) not null,
    created_at  timestamp not null
);

create table if not exists field_values (
    id          bigint unsigned auto_increment primary key,
    card_id     bigint unsigned not null,
    field_id    bigint unsigned not null,
    value       blob,
    is_crypted  char(1),
    updated_at  datetime,
    created_at  timestamp not null
);
