#!/usr/bin/env perl

# PODNAME: 1.pl
# ABSTRACT: Multiples of 3 and 5

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-01-03

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $MAX_NUM => 1000;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

## no critic (ProhibitMagicNumbers)
printf "%d\n", sum_sequence(3) + sum_sequence(5) - sum_sequence(15);
## use critic

# Sum sequence n + 2n + 3n + ... + int(($MAX_NUM-1)/n)
# e.g. 3 + 6 + 9 + ... + 999
# e.g. 5 + 10 + 15 + ... + 995
sub sum_sequence {
    my ($step) = @_;

    my $last_int = int( ( $MAX_NUM - 1 ) / $step );

    return $step * $last_int * ( $last_int + 1 ) / 2;
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

1.pl

Multiples of 3 and 5

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Multiples of 3 and 5". The problem
is: Find the sum of all the multiples of 3 or 5 below 1000.

=head1 EXAMPLES

    perl 1.pl

=head1 USAGE

    1.pl
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
