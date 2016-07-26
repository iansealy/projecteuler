#!/usr/bin/env perl

# PODNAME: 114.pl
# ABSTRACT: Counting block combinations I

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-07-25

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
Readonly our $MIN_BLOCK => 3;

# Default options
my $units = 50;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

memoize('ways');

printf "%d\n", ways($units);

# Count ways
sub ways {
    my ($total_length) = @_;

    my $count = 1;    # All empty

    if ( $total_length < $MIN_BLOCK ) {
        return $count;
    }

    foreach my $start ( 0 .. $total_length - $MIN_BLOCK ) {
        foreach my $block_length ( $MIN_BLOCK .. $total_length - $start ) {
            $count += ways( $total_length - $start - $block_length - 1 );
        }
    }

    return $count;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'units=i' => \$units,
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

114.pl

Counting block combinations I

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Counting block combinations I".
The problem is: How many ways can a row measuring fifty units in length be
filled?

=head1 EXAMPLES

    perl 114.pl

=head1 USAGE

    114.pl
        [--units INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--units INT>

The length of the row.

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
