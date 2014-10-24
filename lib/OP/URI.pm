#
# File: OP/URI.pm
#
# Copyright (c) 2009 TiVo Inc.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Common Public License v1.0
# which accompanies this distribution, and is available at
# http://opensource.org/licenses/cpl1.0.txt
#
package OP::URI;

use strict;
use warnings;

use OP::Class qw| true false |;

use Data::Validate::URI;

use base qw| OP::Str |;

use constant AssertFailureMessage => "Received value is not a URI";

sub assert {
  my $class = shift;
  my @rules = @_;

  my %parsed = OP::Type::__parseTypeArgs(
    sub {
       Data::Validate::URI::is_uri("$_[0]")
         || throw OP::AssertFailed(AssertFailureMessage);
    }, @rules
  );

  $parsed{columnType} ||= 'VARCHAR(256)';

  return $class->__assertClass()->new(%parsed);
};

sub new {
  my $class = shift;
  my $string = shift;

  Data::Validate::URI::is_uri($string)
    || throw OP::AssertFailed(AssertFailureMessage);

  my $self = $class->SUPER::new($string);

  return bless $self, $class;
};

true;

__END__

=pod

=head1 NAME

OP::URI - Overloaded URI object class

=head1 SYNOPSIS

  use OP::URI;

  my $addr = OP::URI->new("http://www.example.com/");

=head1 DESCRIPTION

Extends L<OP::Str>. Uses L<Data::Validate::URI> to verify input.

=head1 PUBLIC CLASS METHODS

=over 4

=item * C<assert(OP::Class $class: *@rules)>

Returns a new OP::Type::URI instance which encapsulates the received
L<OP::Subtype> rules.

  create "OP::Example" => {
    someAddr  => OP::URI->assert(...),

    # ...
  };

=item * C<new(OP::Class $class: Str $addr)>

Returns a new OP::URI instance which encapsulates the received value.

  my $object = OP::URI->new($addr);

=back

=head1 SEE ALSO

L<URI>, L<OP::Str>, L<Data::Validate::URI>

This file is part of L<OP::Net>.

=cut
