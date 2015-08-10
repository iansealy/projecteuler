#!/usr/bin/env perl

# PODNAME: 61.pl
# ABSTRACT: Cyclical figurate numbers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-08-10

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $set_size = 6;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @functions = (
    sub { my $n = shift; return $n * ( $n + 1 ) / 2 },
    sub { my $n = shift; return $n * $n },
    ## no critic (ProhibitMagicNumbers)
    sub { my $n = shift; return $n * ( 3 * $n - 1 ) / 2 },
    ## use critic
    sub { my $n = shift; return $n * ( 2 * $n - 1 ) },
    ## no critic (ProhibitMagicNumbers)
    sub { my $n = shift; return $n * ( 5 * $n - 3 ) / 2 },
    sub { my $n = shift; return $n * ( 3 * $n - 2 ) },
    ## use critic
);

my %polygonal;
my %polygonal_type;
my %prefix;
foreach my $type ( 0 .. $set_size - 1 ) {
    my $n = 1;
    my $p = 1;
    while ( $p < 10_000 ) {    ## no critic (ProhibitMagicNumbers)
        $p = $functions[$type]->($n);
        if ( $p >= 1000 && $p < 10_000 ) {   ## no critic (ProhibitMagicNumbers)
            $polygonal{$p} = 1;
            push @{ $polygonal_type{$p} }, $type;
            my $prefix = substr $p, 0, 2;
            $prefix{$prefix}{$p} = 1;
        }
        $n++;
    }
}

my $set_sum;
foreach my $num ( keys %polygonal ) {
    $set_sum = get_cycle( [$num], \%prefix, \%polygonal_type, $set_size );
    last if defined $set_sum;
}

printf "%d\n", $set_sum;

sub get_cycle {
    ## no critic (ProhibitReusedNames)
    my ( $cycle, $prefix, $polygonal_type, $set_size ) = @_;

    my $set_sum;
    ## use critic

    if ( scalar @{$cycle} == $set_size ) {
        if ( ( substr $cycle->[0], 0, 2 ) ne ( substr $cycle->[-1], 2, 2 ) ) {
            return;
        }
        if ( all_represented( $cycle, $polygonal_type, $set_size ) ) {
            foreach my $num ( @{$cycle} ) {
                $set_sum += $num;
            }
            return $set_sum;
        }
        else {
            return;
        }
    }

    my %in_cycle = map { $_ => 1 } @{$cycle};
    my $suffix = substr $cycle->[-1], 2, 2;
    foreach my $next_num ( keys %{ $prefix->{$suffix} } ) {
        next if exists $in_cycle{$next_num};
        $set_sum = get_cycle( [ @{$cycle}, $next_num ],
            $prefix, $polygonal_type, $set_size );
        last if defined $set_sum;
    }

    return $set_sum;
}

sub all_represented {
    ## no critic (ProhibitReusedNames)
    my ( $cycle, $polygonal_type, $set_size ) = @_;
    ## use critic

    my @paths = (q{});

    foreach my $num ( @{$cycle} ) {
        my @types = @{ $polygonal_type->{$num} };
        return 0 if !@types;
        my @new_paths;
        foreach my $type (@types) {
            foreach my $path (@paths) {
                push @new_paths, $path . $type;
            }
        }
        @paths = @new_paths;
    }

    foreach my $path (@paths) {
        my %seen = map { $_ => 1 } split //xms, $path;
        if ( scalar keys %seen == $set_size ) {
            return 1;
        }
    }

    return 0;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'set_size=i' => \$set_size,
        'debug'      => \$debug,
        'help'       => \$help,
        'man'        => \$man,
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

61.pl

Cyclical figurate numbers

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Cyclical figurate numbers". The
problem is: Find the sum of the only ordered set of six cyclic 4-digit numbers
for which each polygonal type: triangle, square, pentagonal, hexagonal,
heptagonal, and octagonal, is represented by a different number in the set.

=head1 EXAMPLES

    perl 61.pl

=head1 USAGE

    61.pl
        [--set_size INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--set_size INT>

The number of 4-digit integers in the cyclic set.

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
