create table if not exists servers (
    id          bigint unsigned auto_increment primary key,
    user_id     bigint unsigned not null,
    hostname    varchar(255) not null,
    description varchar(255),
    config      mediumtext not null, 
    created_at  timestamp not null
);

create table if not exists users (
    id          bigint unsigned auto_increment primary key,
    server_id   bigint unsigned not null,
    card_id     bigint unsigned not null,
    country     char(2) not null,
    config      mediumtext not null, 
    password    varchar(255) not null,
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
    cardname    varchar(255),
    created_at  timestamp not null
);

create table if not exists subscriptions (
    id          bigint unsigned auto_increment primary key,
    user_id     bigint unsigned not null,
    card_id     bigint unsigned not null,
    state       varchar(255),
    created_at  timestamp not null
);

create table if not exists cards (
    id          bigint unsigned auto_increment primary key,
    user_id     bigint unsigned not null,
    orig_id     bigint unsigned,
    cardname_id bigint unsigned not null,
    longitude   mediumint,
    latitude    mediumint,
    version_at  datetime,
    created_at  timestamp not null
);

create table if not exists card_versions {
    id          bigint unsigned auto_increment primary key,
    card_id     bigint unsigned not null,
    field_cache mediumblob,
    field_delta mediumblob,
    created_at  timestamp not null
}

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
    created_at  timestamp not null
);
