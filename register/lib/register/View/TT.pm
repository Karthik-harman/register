package register::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

register::View::TT - TT View for register

=head1 DESCRIPTION

TT View for register.

=head1 SEE ALSO

L<register>

=head1 AUTHOR

Sumesh Sugunanadan

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
