#!/usr/bin/env perl

# PODNAME: 22.pl
# ABSTRACT: Names scores

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-04-04

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use LWP::Simple;
use Text::CSV;

# Constants
Readonly our $NAMES_URL =>
  'https://projecteuler.net/project/resources/p022_names.txt';

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $names = get($NAMES_URL);
my $csv = Text::CSV->new( { binary => 1 } );
$csv->parse($names);
my @names = sort $csv->fields();

my $total = 0;

my $ordinal = 0;
foreach my $name (@names) {
    $ordinal++;
    my $value = 0;
    foreach my $letter ( split //xms, $name ) {
        $value += ( ord $letter ) - 64;    ## no critic (ProhibitMagicNumbers)
    }
    $total += $ordinal * $value;
}

printf "%d\n", $total;

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

22.pl

Names scores

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Names scores". The problem is:
What is the total of all the name scores in the file?

=head1 EXAMPLES

    perl 22.pl

=head1 USAGE

    22.pl
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
