#!/usr/bin/env perl

# PODNAME: 42.pl
# ABSTRACT: Coded triangle numbers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-06-09

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
Readonly our $WORDS_URL =>
  'https://projecteuler.net/project/resources/p042_words.txt';

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $words = get($WORDS_URL);
my $csv = Text::CSV->new( { binary => 1 } );
$csv->parse($words);
my @words = sort $csv->fields();

my %is_triangle;
my $n        = 1;
my $triangle = 0;
while ( $triangle < 1000 ) {    ## no critic (ProhibitMagicNumbers)
    $triangle = $n * ( $n + 1 ) / 2;
    $is_triangle{$triangle} = 1;
    $n++;
}

my $count = 0;
foreach my $word (@words) {
    my $value = 0;
    foreach my $letter ( split //xms, $word ) {
        $value += ( ord $letter ) - 64;    ## no critic (ProhibitMagicNumbers)
    }
    if ( $is_triangle{$value} ) {
        $count++;
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

42.pl

Coded triangle numbers

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Coded triangle numbers". The
problem is: Using words.txt, a 16K text file containing nearly two-thousand
common English words, how many are triangle words?

=head1 EXAMPLES

    perl 42.pl

=head1 USAGE

    42.pl
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
