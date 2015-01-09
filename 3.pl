#!/usr/bin/env perl

# PODNAME: 3.pl
# ABSTRACT: Largest prime factor

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-01-09

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $number = 600_851_475_143;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $div = 2;
while ( $div <= int sqrt $number ) {
    while ( $number % $div == 0 ) {
        $number = $number / $div;
    }

    # Don't bother testing even numbers (except two)
    if ( $div > 2 ) {
        $div += 2;
    }
    else {
        $div++;
    }
}
printf "%d\n", $number;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'number=i' => \$number,
        'debug'    => \$debug,
        'help'     => \$help,
        'man'      => \$man,
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

3.pl

Largest prime factor

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Largest prime factor". The problem
is: What is the largest prime factor of the number 600851475143 ?

=head1 EXAMPLES

    perl 3.pl --number 13195

=head1 USAGE

    3.pl
        [--number INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--number INT>

The number to find the largest prime factor of.

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
