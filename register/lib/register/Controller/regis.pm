package register::Controller::regis;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

register::Controller::regis - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

use Data::Dumper;
use register::Model::regis;
has "register_model"=>(is=>'ro', default=>sub {return register::Model::regis->new()});
sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched register::Controller::regis in regis.');
}

sub register :Local 
{
    my ( $self, $c ) = @_;
    $c->stash(template => 'regis/register.tt');
}

sub subn :Local 
{
    my ( $self, $c ) = @_;
    my $register_params = $c->request->params;
    my $model = $self->register_model; 
    print STDERR Dumper $c;
    my %params = (
        firstname => "$register_params->{firstname}",
        lastname => "$register_params->{lastname}",
        email => "$register_params->{email}",
        phone => "$register_params->{phone}",
        gender => "$register_params->{gender}",
        month => "$register_params->{month}",
        day => "$register_params->{day}",
        year => "$register_params->{year}"
    );
    $c->stash->{params} = \%params;
    $c->stash->{template} =  'submit/display.tt';
    $model->save(\%params);
}

sub search :Local
{
    my ( $self, $c ) = @_;
    my $schema = register::Schema->connect('dbi:ODBC:phab_karthik', 'phab', 'phab');
    my $get_records = $schema->resultset('KarthiRegister')->search;
    my $get_count = $schema->resultset('KarthiRegister')->search({})->count;
    $c->stash->{RecordRef} = $get_records;
    $c->stash->{RecordCount} = $get_count;
    $c->stash->{template} =  'submit/result.tt';
}

sub SearchSingle :Local
{
    my ( $self, $c ) = @_;
    my $phone = $c->request->param('search');
    my $record_ref = $self->register_model->searchwithmail($phone);
    my @rec = $record_ref->all();
    print STDERR Dumper $rec[0];
    print STDERR Dumper $record_ref->next;
    $c->stash->{RecordRef} = $record_ref;
    $c->stash->{template} =  'submit/result.tt';
}
=encoding utf8

=head1 AUTHOR

Sumesh Sugunanadan

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
