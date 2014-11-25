package Pxe::Boot::Web::Plugin::Session;
use utf8;
use warnings;
use 5.20.0;
use experimental 'signatures', 'postderef';
use Amon2::Util;
use HTTP::Session2::ClientStore2;
use Crypt::CBC;

sub init ($class, $c, @) {
    # Validate XSRF Token.
    $c->add_trigger(
        BEFORE_DISPATCH => sub {
            my ( $c ) = @_;
            if ($c->req->method ne 'GET' && $c->req->method ne 'HEAD') {
                my $token = $c->req->header('X-XSRF-TOKEN') || $c->req->param('XSRF-TOKEN');
                unless ($c->session->validate_xsrf_token($token)) {
                    return $c->create_simple_status_page(
                        403, 'XSRF detected.'
                    );
                }
            }
            return;
        },
    );

    Amon2::Util::add_method($c, 'session', \&_session);

    # Inject cookie header after dispatching.
    $c->add_trigger(
        AFTER_DISPATCH => sub {
            my ( $c, $res ) = @_;
            if ($c->{session} && $res->can('cookies')) {
                $c->{session}->finalize_plack_response($res);
            }
            return;
        },
    );
}

# $c->session() accessor.
my $cipher = Crypt::CBC->new({
    key => 'UPw00QyM9bf9_VUHNLjDT-mAK_Wsg94U',
    cipher => 'Rijndael',
});
sub _session ($self) {
    if (!exists $self->{session}) {
        $self->{session} = HTTP::Session2::ClientStore2->new(
            env => $self->req->env,
            secret => 'h_AEpuGEhwvI-jHv2_gw1zV-UdD7NQic',
            cipher => $cipher,
        );
    }
    $self->{session};
}

1;
__END__

=head1 DESCRIPTION

This module manages session for Pxe::Boot.

