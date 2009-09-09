#
# File: OP/Net.pm
#
# Copyright (c) 2009 TiVo Inc.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Common Public License v1.0
# which accompanies this distribution, and is available at
# http://opensource.org/licenses/cpl1.0.txt
#

package OP::Net;

our $VERSION = '0.314';

use strict;
use warnings;

use OP::Domain;
use OP::EmailAddr;
use OP::IPv4Addr;
use OP::Subnet;
use OP::URI;

1;
__END__
=pod

=head1 NAME

OP::Net - Network datatypes for L<OP>

=head1 VERSION

This documentation is for version B<0.314> of OP::Net.

=head1 SYNOPSIS

Load all network datatype packages:

  use OP::Net;

...or load them as needed:

  # use OP::Domain;
  # use OP::EmailAddr;
  # use OP::IPv4Addr;
  # use OP::Subnet;
  # use OP::URI;

=head1 DESCRIPTION

This package provides several assertable network-related datatypes
for L<OP>.

All classes are overloaded.

=head1 TYPES

=over 4

=item * L<OP::Domain> - Domain name

=item * L<OP::EmailAddr> - Email address

=item * L<OP::IPv4Addr> - IPv4 address

=item * L<OP::Subnet> - CIDR-notation subnet string

=item * L<OP::URI> - URI

=back

=head1 AUTHOR

  Alex Ayars <pause@nodekit.org>

=head1 COPYRIGHT

  File: OP.pm
 
  Copyright (c) 2009 TiVo Inc.
 
  All rights reserved. This program and the accompanying materials
  are made available under the terms of the Common Public License v1.0
  which accompanies this distribution, and is available at
  http://opensource.org/licenses/cpl1.0.txt

=cut
