#!/usr/bin/env perl

# PODNAME: 68.pl
# ABSTRACT: Magic 5-gon ring

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-09-02

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Math::Combinatorics;
use List::Util qw(sum min);
use Storable qw(dclone);

# Default options
## no critic (ProhibitMagicNumbers)
my $ring_size     = 5;
my $max_digit     = 10;
my $target_digits = 16;
## use critic
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

# Group combinations by sum
my %comb_by_sum;
## no critic (ProhibitMagicNumbers)
my @combinations = combine( 3, ( 1 .. $max_digit ) );
## use critic
foreach my $combination (@combinations) {
    push @{ $comb_by_sum{ sum( @{$combination} ) } }, $combination;
}

# Group combinations into rings with correct digits
my @combs;
foreach my $sum ( keys %comb_by_sum ) {
    next if scalar @{ $comb_by_sum{$sum} } < $ring_size;
    foreach my $comb ( combine( $ring_size, @{ $comb_by_sum{$sum} } ) ) {
        my %digit_seen;
        foreach my $group ( @{$comb} ) {
            foreach my $digit ( @{$group} ) {
                $digit_seen{$digit}++;
            }
        }
        ## no critic (ProhibitMagicNumbers)
        next
          if scalar keys %digit_seen != $max_digit
          || ( sort { $a <=> $b } values %digit_seen )[-1] != 2;
        ## use critic

        # Reorder so first digit is the one that only appears once
        my @ordered_comb;
        foreach my $group ( @{$comb} ) {
            push @ordered_comb,
              [ sort { $digit_seen{$a} <=> $digit_seen{$b} } @{$group} ];
        }
        push @combs, \@ordered_comb;
    }
}

# Make all combinations of last two digits of each group
my @new_combs;
foreach my $comb (@combs) {
    my @group1      = @{ $comb->[0] };
    my @group2      = ( $group1[0], $group1[2], $group1[1] );
    my @digit_combs = ( [ [@group1] ], [ [@group2] ] );
    foreach my $i ( 1 .. $ring_size - 1 ) {
        @group1 = @{ $comb->[$i] };
        @group2 = ( $group1[0], $group1[2], $group1[1] );
        my @new_digit_combs;
        foreach my $digit_perm (@digit_combs) {
            push @new_digit_combs, [ @{ dclone($digit_perm) }, [@group1] ],
              [ @{ dclone($digit_perm) }, [@group2] ];
        }
        @digit_combs = @new_digit_combs;
    }
    push @new_combs, @digit_combs;
}
@combs = @new_combs;

# Get all permutations of each combination and filter invalid ones
my $max_string = 0 x $target_digits;
foreach my $comb (@combs) {
  PERM: foreach my $perm ( permute( @{$comb} ) ) {
        next PERM if $perm->[0][0] != min( map { $_->[0] } @{$perm} );
        my $string = q{};
        foreach my $i ( 0 .. $ring_size - 1 ) {
            next PERM
              if $perm->[$i][2] != $perm->[ ( $i + 1 ) % $ring_size ][1];
            $string .= join q{}, @{ $perm->[$i] };
        }
        next if length $string != $target_digits;
        if ( $string > $max_string ) {
            $max_string = $string;
        }
    }
}

printf "%s\n", $max_string;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'ring_size=i'     => \$ring_size,
        'max_digit=i'     => \$max_digit,
        'target_digits=i' => \$target_digits,
        'debug'           => \$debug,
        'help'            => \$help,
        'man'             => \$man,
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

68.pl

Magic 5-gon ring

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Magic 5-gon ring". The problem is:
Using the numbers 1 to 10, and depending on arrangements, it is possible to form
16- and 17-digit strings. What is the maximum 16-digit string for a "magic"
5-gon ring?

=head1 EXAMPLES

    perl 68.pl --ring_size 3 --max_digit 6 --target_digits 9

=head1 USAGE

    68.pl
        [--ring_size INT]
        [--max_digit INT]
        [--target_digits INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--ring_size INT>

The number of vertices in the magic ring.

=item B<--max_digit INT>

The number of digits to fill the rings with.

=item B<--target_digits INT>

The number of digits in the solution.

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
