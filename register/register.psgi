use strict;
use warnings;

use register;

my $app = register->apply_default_middlewares(register->psgi_app);
$app;

