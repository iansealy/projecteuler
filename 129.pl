#!/usr/bin/env perl

# PODNAME: 129.pl
# ABSTRACT: Repunit divisibility

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-10-04

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $minimum = 1_000_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $n = $minimum;
while (1) {
    $n++;
    next if $n % 2 == 0 || $n % 5 == 0;    ## no critic (ProhibitMagicNumbers)
    my $rkmodn = 1;
    my $k      = 1;
    while ( $rkmodn % $n != 0 ) {
        $k++;
        $rkmodn = ( $rkmodn * 10 + 1 ) % $n; ## no critic (ProhibitMagicNumbers)
    }
    last if $k > $minimum;
}

printf "%d\n", $n;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'minimum=i' => \$minimum,
        'debug'     => \$debug,
        'help'      => \$help,
        'man'       => \$man,
    ) or pod2usage(2);

    # Documentation
    if ($help) {
        pod2usage(1);
    }
    elsif ($man) {
        pod2usage( -verbose => 2 );
    }

    return;
}

__END__
=pod

=encoding UTF-8

=head1 NAME

129.pl

Repunit divisibility

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Repunit divisibility". The problem
is: Find the least value of n for which A(n) first exceeds one-million.

=head1 EXAMPLES

    perl 129.pl --minimum 10

=head1 USAGE

    129.pl
        [--minimum INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--minimum INT>

The minimum value of A(n).

=item B<--debug>

Print debugging information.

=item B<--help>

Print a brief help message and exit.

=item B<--man>

Print this script's manual page and exit.

=back

=head1 DEPENDENCIES

None

=head1 AUTHOR

=over 4

=item *

Ian Sealy <ian.sealy@sanger.ac.uk>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2016 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
