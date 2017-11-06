use strict;
use warnings;
use Test::More;


use Catalyst::Test 'register';
use register::Controller::regis;

ok( request('/regis')->is_success, 'Request should succeed' );
done_testing();
