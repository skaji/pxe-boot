use strict;
use warnings;
use Test::More;


use Pxe::Boot;
use Pxe::Boot::Web;
use Pxe::Boot::Web::View;
use Pxe::Boot::Web::ViewFunctions;

use Pxe::Boot::DB::Schema;
use Pxe::Boot::Web::Dispatcher;


pass "All modules can load.";

done_testing;
