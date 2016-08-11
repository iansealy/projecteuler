#!/usr/bin/env perl

# PODNAME: 118.pl
# ABSTRACT: Pandigital prime sets

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-08-11

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Algorithm::Combinatorics qw(variations);

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

# Get all non-duplicated primes
my %primes_for;
## no critic (ProhibitMagicNumbers)
foreach my $digits ( 1 .. 8 ) {    # 9 digit pandigital numbers can't be prime
    my $perms = variations( [ 1 .. 9 ], $digits );
    ## use critic
    while ( my $perm = $perms->next ) {
        my $num = join q{}, @{$perm};
        if ( is_prime($num) ) {
            push @{ $primes_for{$digits} }, $num;
        }
    }
}

printf "%d\n", sets( 9, 0, () );    ## no critic (ProhibitMagicNumbers)

sub sets {
    my ( $max_digits, $length, @primes ) = @_;

    my %digit;
    foreach my $prime (@primes) {
        foreach my $digit ( split //xms, $prime ) {
            return 0 if exists $digit{$digit};
            $digit{$digit} = 1;
        }
    }
    return 1 if $length == 9;       ## no critic (ProhibitMagicNumbers)

    my $count = 0;
    foreach my $num_digits ( reverse 1 .. $max_digits ) {
        next if $length + $num_digits > 9;   ## no critic (ProhibitMagicNumbers)
        foreach my $prime ( @{ $primes_for{$num_digits} } ) {
            last if scalar @primes && $prime >= $primes[-1];
            $count +=
              sets( $num_digits, $length + $num_digits, @primes, $prime );
        }
    }
    return $count;
}

sub is_prime {
    my ($num) = @_;

    return 0 if $num == 1;    # 1 isn't prime
    ## no critic (ProhibitMagicNumbers)
    return 1 if $num < 4;         # 2 and 3 are prime
    return 0 if $num % 2 == 0;    # Even numbers aren't prime
    return 1 if $num < 9;         # 5 and 7 are prime
    return 0 if $num % 3 == 0;    # Numbers divisible by 3 aren't prime
    ## use critic

    my $num_sqrt = int sqrt $num;
    my $factor   = 5;               ## no critic (ProhibitMagicNumbers)
    while ( $factor <= $num_sqrt ) {
        return 0 if $num % $factor == 0;    # Primes greater than three are 6k-1
        return 0 if $num % ( $factor + 2 ) == 0;    # Or 6k+1
        $factor += 6;    ## no critic (ProhibitMagicNumbers)
    }
    return 1;
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

118.pl

Pandigital prime sets

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Pandigital prime sets". The
problem is: How many distinct sets containing each of the digits one through
nine exactly once contain only prime elements?

=head1 EXAMPLES

    perl 118.pl

=head1 USAGE

    118.pl
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

This software is Copyright (c) 2016 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
