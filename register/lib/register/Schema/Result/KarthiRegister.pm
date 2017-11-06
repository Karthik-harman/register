package register::Schema::Result::KarthiRegister;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('karthi_register');
__PACKAGE__->add_columns(qw/ firstname lastname email phone gender month1 day1 year1/);
__PACKAGE__->set_primary_key('phone');

1;
