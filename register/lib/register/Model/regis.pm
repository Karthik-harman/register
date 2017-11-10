package register::Model::regis;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';

=head1 NAME

register::Model::regis - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.


=encoding utf8

=head1 AUTHOR

Sumesh Sugunanadan

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

#__PACKAGE__->meta->make_immutable;

use Text::CSV;
use Data::Dumper;
use register::Schema;
my $schema = register::Schema->connect('dbi:ODBC:phab_karthik', 'phab', 'phab');

has 'csv' => (
    is=>'ro',
    default =>sub{
                return Text::CSV->new({binary=>1});
             }
);

sub save
{
    my ($self, $register_params) = @_;
    $self->getcol();
    open (my $fh, ">>:encoding(utf8)", '/home/ssugunanadan/Karthik/register/lib/register/Controller/detail.txt') or die "Could not open file";
    $self->csv->print_hr($fh,$register_params);
    $self->csv->eol("\r\n");
    close($fh);
    my $insert = $schema->resultset('KarthiRegister')->create({
        firstname=>$register_params->{firstname},
        lastname=>$register_params->{lastname},
        email=>$register_params->{email},
        phone=>$register_params->{phone},
        gender=>$register_params->{gender},
        month1=>$register_params->{month},
        day1=>$register_params->{day},
        year1=>$register_params->{year},
        },);
}

sub getcol
{
    my ($self) = @_;
    open (my $fh, "<:encoding(utf8)", '/home/ssugunanadan/Karthik/register/lib/register/Controller/title.txt') or die "Could not open file";
    my @cols = @{$self->csv->getline($fh)};
    $self->csv->column_names(@cols);
}

sub searchwithmail
{
    my ($self, $phone) = @_;
    my $result = $schema->resultset('KarthiRegister')->search({phone=>$phone});
    return $result;
}

1;
