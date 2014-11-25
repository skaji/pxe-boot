package Pxe::Boot;
use utf8;
use warnings;
use 5.20.0;
use experimental 'signatures', 'postderef';
use Pxe::Boot::DB::Schema;
use Pxe::Boot::DB;

use parent 'Amon2';
__PACKAGE__->make_local_context;

my $schema = Pxe::Boot::DB::Schema->instance;

sub db ($c) {
    unless (exists $c->{db}) {
        my $conf = $c->config->{DBI}
            or die "Missing configuration about DBI";
        $c->{db} = Pxe::Boot::DB->new(
            schema       => $schema,
            connect_info => $conf,
            # I suggest to enable following lines if you are using mysql.
            # on_connect_do => [
            #     'SET SESSION sql_mode=STRICT_TRANS_TABLES;',
            # ],
        );
    }
    $c->{db};
}

1;
