#!/usr/bin/env perl

# PODNAME: 99.pl
# ABSTRACT: Largest exponential

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-05-01

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use LWP::Simple;

# Constants
Readonly our $EXP_URL =>
  'https://projecteuler.net/project/resources/p099_base_exp.txt';

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $max = 0;
my $max_line;
my $numbers = get($EXP_URL);
my @numbers = split /\s+/xms, $numbers;
my $line    = 0;
foreach my $pair (@numbers) {
    $line++;
    my ( $base, $exp ) = split /,/xms, $pair;
    my $num = $exp * log $base;
    if ( $num > $max ) {
        $max      = $num;
        $max_line = $line;
    }
}

printf "%d\n", $max_line;

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

99.pl

Largest exponential

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Largest exponential". The problem
is: Using base_exp.txt, a 22K text file containing one thousand lines with a
base/exponent pair on each line, determine which line number has the greatest
numerical value.

=head1 EXAMPLES

    perl 99.pl

=head1 USAGE

    99.pl
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
