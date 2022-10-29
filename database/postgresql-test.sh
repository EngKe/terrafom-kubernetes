#!/bin/sh

postgresql_test(){

    pg_isready -d postgres -h 127.0.0.1 -p 5432 -U postgres
}

postgresql_test