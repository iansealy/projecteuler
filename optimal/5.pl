#!/usr/bin/env perl

# PODNAME: 5.pl
# ABSTRACT: Smallest multiple

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-01-22

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $max_num = 20;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $multiple = 1;

my @all_primes = get_primes($max_num);

my $power_limit = int sqrt $max_num;

foreach my $prime (@all_primes) {
    my $power = 1;
    if ( $prime <= $power_limit ) {
        $power = int( log($max_num) / log $prime );
    }
    $multiple = $multiple * $prime**$power;
}

printf "%d\n", $multiple;

# Get prime numbers
sub get_primes {
    my ($limit) = @_;

    ## no critic (ProhibitMagicNumbers)
    my %is_prime = ( 2 => 1, 3 => 1 );
    my $num = 5;
    ## use critic

    while ( $num <= $limit ) {
        my $is_prime = 1;
        my $num_sqrt = int sqrt $num;
        foreach my $prime ( sort { $a <=> $b } keys %is_prime ) {
            last if $prime > $num_sqrt;
            if ( $num % $prime == 0 ) {
                $is_prime = 0;
                last;
            }
        }
        if ($is_prime) {
            $is_prime{$num} = 1;
        }
        $num += 2;
    }

    my @primes = sort { $a <=> $b } keys %is_prime;

    return @primes;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'max_num=i' => \$max_num,
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

5.pl

Smallest multiple

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Smallest multiple". The problem
is: What is the smallest positive number that is evenly divisible by all of the
numbers from 1 to 20?

=head1 EXAMPLES

    perl 5.pl --max_num 10

=head1 USAGE

    5.pl
        [--max_num INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--max_num INT>

The number ending the sequence to find the smallest multiple of.

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
