package Pxe::Boot::Web;
use utf8;
use warnings;
use 5.20.0;
use experimental 'signatures', 'postderef';
use parent qw(Pxe::Boot Amon2::Web);
use File::Spec;

# dispatcher
use Pxe::Boot::Web::Dispatcher;
sub dispatch {
    return (Pxe::Boot::Web::Dispatcher->dispatch($_[0]) or die "response is not generated");
}

# load plugins
__PACKAGE__->load_plugins(
    'Web::FillInFormLite',
    'Web::JSON',
    '+Pxe::Boot::Web::Plugin::Session',
);

# setup view
use Pxe::Boot::Web::View;
{
    sub create_view {
        my $view = Pxe::Boot::Web::View->make_instance(__PACKAGE__);
        no warnings 'redefine';
        *Pxe::Boot::Web::create_view = sub { $view }; # Class cache.
        $view
    }
}

# for your security
__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub ($c, $res) {
        # http://blogs.msdn.com/b/ie/archive/2008/07/02/ie8-security-part-v-comprehensive-protection.aspx
        $res->header( 'X-Content-Type-Options' => 'nosniff' );
        # http://blog.mozilla.com/security/2010/09/08/x-frame-options/
        $res->header( 'X-Frame-Options' => 'DENY' );
        # Cache control.
        $res->header( 'Cache-Control' => 'private' );
    },
);

1;
