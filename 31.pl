#!/usr/bin/env perl

# PODNAME: 31.pl
# ABSTRACT: Coin sums

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-05-01

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use Memoize qw( memoize );

# Constants
Readonly our @COINS => ( 200, 100, 50, 20, 10, 5, 2, 1 );

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

memoize('change');

printf "%d\n", change( 200, @COINS );    ## no critic (ProhibitMagicNumbers)

sub change {
    my ( $money, @coins ) = @_;

    return 0 if $money < 0;
    return 1 if $money == 0;

    my $count = 0;
    while ( my $coin = shift @coins ) {
        $count += change( $money - $coin, $coin, @coins );
    }

    return $count;
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

31.pl

Coin sums

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Coin sums". The problem is: How
many different ways can £2 be made using any number of coins?

=head1 EXAMPLES

    perl 31.pl

=head1 USAGE

    31.pl
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

This software is Copyright (c) 2015 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
