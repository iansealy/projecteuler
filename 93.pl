#!/usr/bin/env perl

# PODNAME: 93.pl
# ABSTRACT: Arithmetic expressions

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-03-22

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Math::Combinatorics;

# Default options
my $max_digit = 9;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @operators = (
    sub { my ( $n1, $n2 ) = @_; return $n1 + $n2 },
    sub { my ( $n1, $n2 ) = @_; return $n1 - $n2 },
    sub { my ( $n1, $n2 ) = @_; return $n1 * $n2 },
    sub { my ( $n1, $n2 ) = @_; return 0 if !$n2; return $n1 / $n2 },
);

my @op_perms;
## no critic (ProhibitMagicNumbers)
foreach my $i ( 0 .. 3 ) {
    foreach my $j ( 0 .. 3 ) {
        foreach my $k ( 0 .. 3 ) {
            ## use critic
            push @op_perms, [ $i, $j, $k ];
        }
    }
}
my @order_perms = permute( ( 1 .. 3 ) );

my $max_digits;
my $max_consec = 0;
## no critic (ProhibitMagicNumbers)
foreach my $digit_comb ( combine( 4, ( 1 .. $max_digit ) ) ) {
    ## use critic
    my @seen;
    foreach my $digit_perm ( permute( @{$digit_comb} ) ) {
        foreach my $op_perm (@op_perms) {
            foreach my $order_perm (@order_perms) {
                my @nums  = @{$digit_perm};
                my @ops   = @{$op_perm};
                my @order = @{$order_perm};
                while (@order) {
                    my $ordinal = shift @order;
                    my ( $num1, $num2 ) = splice @nums, $ordinal - 1, 2;
                    my ($op) = splice @ops, $ordinal - 1, 1;
                    splice @nums, $ordinal - 1, 0,
                      $operators[$op]->( $num1, $num2 );
                    @order = map { $_ > $ordinal ? $_ - 1 : $_ } @order;
                }
                my $num = shift @nums;
                next if int $num != $num;
                next if $num < 1;
                $seen[$num] = 1;
            }
        }
    }
    my $consec = 0;
    while ( $seen[ $consec + 1 ] ) {
        $consec++;
    }
    if ( $consec > $max_consec ) {
        $max_consec = $consec;
        $max_digits = join q{}, sort { $a <=> $b } @{$digit_comb};
    }
}

printf "%s\n", $max_digits;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'max_digit=i' => \$max_digit,
        'debug'       => \$debug,
        'help'        => \$help,
        'man'         => \$man,
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

93.pl

Arithmetic expressions

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Arithmetic expressions". The
problem is: Find the set of four distinct digits, a < b < c < d, for which the
longest set of consecutive positive integers, 1 to n, can be obtained, giving
your answer as a string: abcd.

=head1 EXAMPLES

    perl 93.pl --max_digit 4

=head1 USAGE

    93.pl
        [--max_digit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--max_digit INT>

The highest digit.

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
