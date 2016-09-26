#!/usr/bin/env perl

# PODNAME: 127.pl
# ABSTRACT: abc-hits

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-09-24

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $limit = 120_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @radicals = (1) x ( $limit + 1 );
foreach my $n ( 2 .. $limit ) {
    if ( $radicals[$n] == 1 ) {
        $radicals[$n] = $n;
        my $multiple = $n + $n;
        while ( $multiple <= $limit ) {
            $radicals[$multiple] *= $n;
            $multiple += $n;
        }
    }
}

my @sorted = sort { $radicals[$a] <=> $radicals[$b] } ( 1 .. $limit );

my %pair;
foreach my $c (@sorted) {
    my $rad_a_or_b_limit = int sqrt( $c / $radicals[$c] );
    foreach my $a_or_b (@sorted) {
        last if $radicals[$a_or_b] > $rad_a_or_b_limit;
        next if $a_or_b >= $c;
        my $a = $a_or_b;
        my $b = $c - $a_or_b;
        if ( $a > $b ) {
            ## no critic (RequireLocalizedPunctuationVars)
            ( $a, $b ) = ( $b, $a );
            ## use critic
        }
        next if $radicals[$a] * $radicals[$b] * $radicals[$c] >= $c;
        next if gcd( $a, $b ) > 1;
        $pair{$a}{$b} = 1;
    }
}

my $total = 0;
foreach my $a ( keys %pair ) {
    foreach my $b ( keys %{ $pair{$a} } ) {
        $total += $a + $b;
    }
}

printf "%d\n", $total;

# Get greatest common divisor
sub gcd {
    my ( $int1, $int2 ) = @_;

    if ( $int1 > $int2 ) {
        ( $int1, $int2 ) = ( $int2, $int1 );
    }

    while ($int1) {
        ( $int1, $int2 ) = ( $int2 % $int1, $int1 );
    }

    return $int2;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'limit=i' => \$limit,
        'debug'   => \$debug,
        'help'    => \$help,
        'man'     => \$man,
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

127.pl

abc-hits

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "abc-hits". The problem is: Find ·c
for c < 120000.

=head1 EXAMPLES

    perl 127.pl --limit 1000

=head1 USAGE

    127.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The maximum value of c.

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
