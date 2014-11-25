package Pxe::Boot::DB;
use utf8;
use warnings;
use 5.20.0;
use experimental 'signatures', 'postderef';
use parent qw(Teng);

__PACKAGE__->load_plugin('Count');
__PACKAGE__->load_plugin('Replace');
__PACKAGE__->load_plugin('Pager');

1;
