#!/usr/bin/env perl

# PODNAME: 53.pl
# ABSTRACT: Combinatoric selections

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-07-15

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $N => 100;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $greater_count = 0;
my $r             = 0;
my $n             = $N;
my $combs         = 1;
while ( $r < $n / 2 ) {
    my $c_right = $combs * ( $n - $r ) / ( $r + 1 );
    if ( $c_right <= 1_000_000 ) {    ## no critic (ProhibitMagicNumbers)
        $r++;
        $combs = $c_right;
    }
    else {
        my $c_up_right = $combs * ( $n - $r ) / $n;
        $greater_count += $n - 2 * $r - 1;
        $n--;
        $combs = $c_up_right;
    }
}

printf "%d\n", $greater_count;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'debug' => \$debug,
        'help'  => \$help,
        'man'   => \$man,
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

53.pl

Combinatoric selections

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Combinatoric selections". The
problem is: How many, not necessarily distinct, values of  nCr, for 1 ≤ n ≤ 100,
are greater than one-million?

=head1 EXAMPLES

    perl 53.pl

=head1 USAGE

    53.pl
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

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

This software is Copyright (c) 2015 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
