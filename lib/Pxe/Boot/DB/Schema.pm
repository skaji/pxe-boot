package Pxe::Boot::DB::Schema;
use utf8;
use warnings;
use 5.20.0;
use experimental 'signatures', 'postderef';
use Teng::Schema::Declare;

base_row_class 'Pxe::Boot::DB::Row';

table {
    name 'member';
    pk 'id';
    columns qw(id name);
};

1;
