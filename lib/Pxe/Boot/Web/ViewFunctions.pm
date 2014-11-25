package Pxe::Boot::Web::ViewFunctions;
use utf8;
use warnings;
use 5.20.0;
use experimental 'signatures', 'postderef';
use Exporter 'import';
use Module::Functions;
use File::Spec;

our @EXPORT = get_public_functions();

sub commify {
    local $_  = shift;
    1 while s/((?:\A|[^.0-9])[-+]?\d+)(\d{3})/$1,$2/s;
    return $_;
}

sub c { Pxe::Boot->context() }
sub uri_with { Pxe::Boot->context()->req->uri_with(@_) }
sub uri_for { Pxe::Boot->context()->uri_for(@_) }

sub static_file ($fname) {
    my $c = Pxe::Boot->context;
    state %static_file_cache;
    if (not exists $static_file_cache{$fname}) {
        my $fullpath = File::Spec->catfile($c->base_dir(), $fname);
        $static_file_cache{$fname} = (stat $fullpath)[9];
    }
    return $c->uri_for(
        $fname, {
            't' => $static_file_cache{$fname} || 0
        }
    );
}

1;
