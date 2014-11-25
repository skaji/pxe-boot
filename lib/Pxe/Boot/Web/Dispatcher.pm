package Pxe::Boot::Web::Dispatcher;
use utf8;
use warnings;
use 5.20.0;
use experimental 'signatures', 'postderef';
use Amon2::Web::Dispatcher::RouterBoom;

any '/' => sub ($c, @) {
    my $counter = $c->session->get('counter') || 0;
    $counter++;
    $c->session->set('counter' => $counter);
    return $c->render('index.tx', {
        counter => $counter,
    });
};

post '/reset_counter' => sub ($c, @) {
    $c->session->remove('counter');
    return $c->redirect('/');
};

post '/account/logout' => sub ($c, @) {
    $c->session->expire();
    return $c->redirect('/');
};

1;
