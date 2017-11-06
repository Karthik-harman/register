use strict;
use warnings;
use Test::More;


use Catalyst::Test 'register';
use register::Controller::submit;

ok( request('/submit')->is_success, 'Request should succeed' );
done_testing();
