#!/usr/bin/env perl

# PODNAME: 121.pl
# ABSTRACT: Disc game prize fund

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-08-28

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use List::Util qw(sum);

# Default options
my $turns = 15;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @outcomes;
my @prev_outcomes = ( 1, 1 );
my $turn = 1;
while ( $turn < $turns ) {
    $turn++;
    @outcomes = (0) x ( $turn + 1 );
    foreach my $blue ( 0 .. $turn - 1 ) {
        $outcomes[$blue] += $prev_outcomes[$blue];
    }
    foreach my $red ( 1 .. $turn ) {
        $outcomes[$red] += $prev_outcomes[ $red - 1 ] * $turn;
    }
    @prev_outcomes = @outcomes;
}

my $total   = sum(@outcomes);
my $num_win = int( ( $turns + 1 ) / 2 );
my $win     = sum( @outcomes[ 0 .. $num_win - 1 ] );

printf "%d\n", int $total / $win;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'turns=i' => \$turns,
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

121.pl

Disc game prize fund

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Disc game prize fund". The problem
is: Find the maximum prize fund that should be allocated to a single game in
which fifteen turns are played.

=head1 EXAMPLES

    perl 121.pl --ordinal 4

=head1 USAGE

    121.pl
        [--turns INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--turns INT>

The number of turns.

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
