#!/usr/bin/env perl

# PODNAME: 125.pl
# ABSTRACT: Palindromic sums

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-09-14

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use List::Util qw(sum);

# Default options
my $limit = 100_000_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @squares = (1);
my $n       = 1;
while ( $squares[-1] < $limit ) {
    $n++;
    push @squares, $n * $n;
}

my %palindrome;

foreach my $start ( 1 .. scalar @squares - 1 ) {
    my $sum  = $squares[ $start - 1 ];
    my $next = $start + 1;
    while ( $next < scalar @squares ) {
        $sum += $squares[ $next - 1 ];
        last if $sum > $limit;
        if ( is_palindrome($sum) ) {
            $palindrome{$sum} = 1;
        }
        $next++;
    }
}

printf "%d\n", sum( keys %palindrome );

sub is_palindrome {
    my ($number) = @_;

    return $number == reverse $number;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'limit=i' => \$limit,
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

125.pl

Palindromic sums

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Palindromic sums". The problem is:
Find the sum of all the numbers less than 10^8 that are both palindromic and can
be written as the sum of consecutive squares.

=head1 EXAMPLES

    perl 125.pl --limit 1000

=head1 USAGE

    125.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The maximum number.

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
