#!/usr/bin/env perl

# PODNAME: 63.pl
# ABSTRACT: Spiral primes

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-08-16

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Math::BigInt;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $count      = 0;
my $n          = 0;
my $match_seen = 1;
while ($match_seen) {
    $n++;
    $match_seen = 0;
    my $num   = Math::BigInt->new(0);
    my $power = 0;
    while ( length $power <= $n ) {
        $num++;
        $power = $num**$n;
        if ( length $power == $n ) {
            $count++;
            $match_seen = 1;
        }
    }
}

printf "%d\n", $count;

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

63.pl

Powerful digit counts

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Powerful digit counts". The
problem is: How many n-digit positive integers exist which are also an nth
power?

=head1 EXAMPLES

    perl 63.pl

=head1 USAGE

    63.pl
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
