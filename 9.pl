#!/usr/bin/env perl

# PODNAME: 9.pl
# ABSTRACT: Special Pythagorean triplet

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-02-12

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $SUM => 1000;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @triplet = get_pythagorean_triplet_by_sum($SUM);

printf "%d\n", $triplet[0] * $triplet[1] * $triplet[2];

sub get_pythagorean_triplet_by_sum {
    my ($target_sum) = @_;

    my $a = 1;
    while ( $a < $target_sum - 2 ) {
        my $b = $a + 1;
        while ( $b < $target_sum - 1 ) {
            my $c = sqrt( $a * $a + $b * $b );

            # Check if we have a Pythagorean triplet
            if ( int $c == $c ) {
                return $a, $b, $c if $a + $b + $c == $target_sum;
            }

            $b++;
        }
        $a++;
    }

    return;
}

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

9.pl

Special Pythagorean triplet

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Special Pythagorean triplet".
The problem is: There exists exactly one Pythagorean triplet for which
a + b + c = 1000. Find the product abc.

=head1 EXAMPLES

    perl 9.pl

=head1 USAGE

    9.pl
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
