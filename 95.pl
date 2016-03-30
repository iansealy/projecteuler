#!/usr/bin/env perl

# PODNAME: 95.pl
# ABSTRACT: Amicable chains

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-03-30

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $MAX => 1_000_000;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my %is_chain = ( 0 => 0, );

my %sum_proper_divisors_for;

foreach my $num ( 1 .. $MAX - 1 ) {
    my $sum = sum_proper_divisors($num);
    $sum_proper_divisors_for{$num} = $sum;
    if ( $sum >= $MAX ) {
        $sum_proper_divisors_for{$num} = undef;
        $is_chain{$num}                = 0;
    }
}

my $max_chain_length  = 0;
my $max_chain_min_num = 0;
NUM: foreach my $num ( 1 .. $MAX - 1 ) {
    next if defined $is_chain{$num} && !$is_chain{$num};
    my @chain = ($num);
    my %seen = ( $num => 1, );
    while (1) {
        push @chain, $sum_proper_divisors_for{ $chain[-1] };
        next NUM if !defined $chain[-1];
        last     if $chain[0] == $chain[-1];
        next NUM if exists $seen{ $chain[-1] };
        $seen{ $chain[-1] } = 1;
        next NUM if defined $is_chain{ $chain[-1] } && $is_chain{ $chain[-1] };
    }
    $is_chain{$num} = 1;
    if ( scalar @chain - 1 > $max_chain_length ) {
        $max_chain_length  = scalar @chain - 1;
        $max_chain_min_num = $num;
    }
}

printf "%d\n", $max_chain_min_num;

sub sum_proper_divisors {
    my ($number) = @_;

    return sum_divisors($number) - $number;
}

sub sum_divisors {
    my ($number) = @_;

    my $divisor_sum = 1;
    my $prime       = 2;

    while ( $prime * $prime <= $number && $number > 1 ) {
        if ( $number % $prime == 0 ) {
            my $j = $prime * $prime;
            $number /= $prime;
            while ( $number % $prime == 0 ) {
                $j *= $prime;
                $number /= $prime;
            }
            $divisor_sum *= ( $j - 1 );
            $divisor_sum /= ( $prime - 1 );
        }
        if ( $prime == 2 ) {
            $prime = 3;    ## no critic (ProhibitMagicNumbers)
        }
        else {
            $prime += 2;
        }
    }
    if ( $number > 1 ) {
        $divisor_sum *= ( $number + 1 );
    }

    return $divisor_sum;
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

95.pl

Amicable chains

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Amicable chains". The problem is:
Find the smallest member of the longest amicable chain with no element exceeding
one million.

=head1 EXAMPLES

    perl 95.pl

=head1 USAGE

    95.pl
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
