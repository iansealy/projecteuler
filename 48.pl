#!/usr/bin/env perl

# PODNAME: 48.pl
# ABSTRACT: Self powers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-06-27

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $NUM_DIGITS  => 10;
Readonly our $LAST_NUMBER => 1000;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $sum_end = 0;
foreach my $number ( 1 .. $LAST_NUMBER ) {
    my $power_end = $number;
    foreach ( 1 .. $number - 1 ) {
        $power_end *= $number;
        $power_end = substr $power_end, -$NUM_DIGITS, $NUM_DIGITS;
    }
    $sum_end += $power_end;
    $sum_end = substr $sum_end, -$NUM_DIGITS, $NUM_DIGITS;
}

printf "%010d\n", $sum_end;

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

48.pl

Self powers

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Self powers". The problem is: Find
the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.

=head1 EXAMPLES

    perl 48.pl

=head1 USAGE

    48.pl
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
