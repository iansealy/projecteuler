#!/usr/bin/env perl

# PODNAME: 106.pl
# ABSTRACT: Special subset sums: meta-testing

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-06-16

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use List::Util qw(notall any);
use Algorithm::Combinatorics qw(variations_with_repetition);

# Default options
my $set_size = 12;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @set = ( 1 .. $set_size );    ## no critic (ProhibitAmbiguousNames)

# Make indices for subsets
my @subset_idxs = variations_with_repetition( [ 0, 1 ], $set_size );
@subset_idxs = grep {
    notall { $_ == 1 }
    @{$_}
} @subset_idxs;
@subset_idxs = grep {
    notall { $_ == 0 }
    @{$_}
} @subset_idxs;

# Get all subsets
my @subsets;
foreach my $subset_idx (@subset_idxs) {
    ## no critic (ProhibitAmbiguousNames)
    my @subset =
      @set[ grep { $subset_idx->[$_] == 1 } ( 0 .. $set_size - 1 ) ];
    ## use critic
    push @subsets, \@subset;
}

my $count = 0;
foreach my $i ( 0 .. scalar @subsets - 2 ) {
    my @subset1 = @{ $subsets[$i] };
    my %count1 = map { $_ => 1 } @subset1;
    foreach my $j ( $i + 1 .. scalar @subsets - 1 ) {
        my @subset2 = @{ $subsets[$j] };
        next if scalar @subset1 != scalar @subset2;
        next if scalar @subset1 == 1 && scalar @subset2 == 1;
        next if any { $count1{$_} } @subset2;
        my @diff =
          map { $subset1[$_] - $subset2[$_] } ( 0 .. scalar @subset1 - 1 );
        my @diff_positive = grep { $_ > 0 } @diff;
        next if !scalar @diff_positive || scalar @diff_positive == scalar @diff;
        $count++;
    }
}

printf "%d\n", $count;

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

106.pl

Special subset sums: meta-testing

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Special subset sums:
meta-testing". The problem is: For n = 12, how many of the 261625 subset pairs
that can be obtained need to be tested for equality?

=head1 EXAMPLES

    perl 106.pl --set_size 7

=head1 USAGE

    106.pl
        [--set_size INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--set_size INT>

The set size.

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
