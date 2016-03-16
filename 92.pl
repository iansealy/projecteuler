#!/usr/bin/env perl

# PODNAME: 92.pl
# ABSTRACT: Square digit chains

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-03-15

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $MAX    => 10_000_000;
Readonly our $TARGET => 89;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $count = 0;

my %cache = (
    1       => 1,
    $TARGET => $TARGET,
);

foreach my $num ( 2 .. $MAX - 1 ) {
    my @chain;
    my $final;
    my $n = join q{}, sort split //xms, $num;
    while (1) {
        if ( defined $cache{$n} ) {
            $final = $cache{$n};
            last;
        }
        push @chain, $n;
        my $sum = 0;
        foreach my $digit ( split //xms, $n ) {
            $sum += $digit * $digit;
        }
        $n = $sum;
    }
    if ( $final == $TARGET ) {
        $count++;
    }
    foreach my $n (@chain) {
        $cache{$n} = $final;
    }
}

printf "%d\n", $count;

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

92.pl

Square digit chains

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Square digit chains". The problem
is: How many starting numbers below ten million will arrive at 89?

=head1 EXAMPLES

    perl 92.pl

=head1 USAGE

    92.pl
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
