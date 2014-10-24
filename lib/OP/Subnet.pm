#
# File: OP/Subnet.pm
#
# Copyright (c) 2009 TiVo Inc.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Common Public License v1.0
# which accompanies this distribution, and is available at
# http://opensource.org/licenses/cpl1.0.txt
#
package OP::Subnet;

use strict;
use warnings;

use OP::Class qw| true false |;

use Net::Subnets;

use base qw| OP::Str |;

use constant AssertFailureMessage => "Received arg isn't in CIDR notation";

sub isSubnet {
  my $arg = shift;

  if ( $arg =~ /^(\d+)\.(\d+)\.(\d+)\.(\d+)\/(\d+)$/  ) {
    my @subnet = ( $1, $2, $3, $4, $5 );

    for my $i ( 0..3 ) {
      return false if $subnet[$i] < 0;
      return false if $subnet[$i] > 255;
    }

    return false if $subnet[4] < 0;
    return false if $subnet[4] > 32;

    return true;
  } else {
    return false;
  }
}

sub assert {
  my $class = shift;
  my @rules = @_;

  my %parsed = OP::Type::__parseTypeArgs(
    sub {
       isSubnet($_[0])
         || throw OP::AssertFailed(AssertFailureMessage);
    }, @rules
  );

  $parsed{columnType} ||= 'VARCHAR(18)';

  return $class->__assertClass()->new(%parsed);
};

sub new {
  my $class = shift;
  my $string = shift;

  isSubnet($string)
    || throw OP::AssertFailed(AssertFailureMessage);

  my $self = $class->SUPER::new($string);

  return bless $self, $class;
};

sub list {
  my $self = shift;

  my $sn = Net::Subnets->new;

  my $value = "$self";

  my @range = $sn->range(\$value);

  return OP::Array->new( $sn->list(@range) );
};

true;
__END__

=pod

=head1 NAME

OP::Subnet - Overloaded Subnet object

=head1 SYNOPSIS

  use OP::Subnet;

  my $addr = OP::Subnet->new("10.0.0.0/24");

=head1 DESCRIPTION

Simple class to represent subnets as strings.

Extends L<OP::Str>. Uses L<Net::Subnets> to expand ranges.

=head1 PUBLIC CLASS METHODS

=over 4

=item * $class->assert(@rules)

Returns a new OP::Type::Subnet instance which encapsulates the received
L<OP::Subtype> rules.

  create "OP::Example" => {
    someAddr  => OP::Subnet->assert( subtype(...) ),

    # ...
  };

=item * $class->new($addr);

Returns a new OP::Subnet instance which encapsulates the received value.

  my $subnet = OP::Subnet->new("10.0.0.0/24");

=back

=head1 PUBLIC INSTANCE METHODS

=over 4

=item * $self->list

Return a new L<OP::Array> containing each IP in self's range.

  $subnet->list->each( sub {
    my $ip = shift;

    print "Have IP address: $ip\n";
  } );

=back

=head1 SEE ALSO

L<OP::Str>, L<OP::Array>, L<Net::Subnets>

This file is part of L<OP::Net>.

=cut
