#!/usr/bin/env perl

# PODNAME: 122.pl
# ABSTRACT: Efficient exponentiation

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-09-01

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use List::Util qw(sum);

# Default options
my $limit = 200;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $multiplications = make_tree( 1, 0, [], [0], $limit );

printf "%d\n", sum( @{$multiplications} );

sub make_tree {
    ## no critic (ProhibitReusedNames)
    my ( $exponent, $depth, $tree, $multiplications, $limit ) = @_;
    ## use critic

    return $multiplications if $exponent > $limit;
    return $multiplications
      if defined $multiplications->[$exponent]
      && $depth > $multiplications->[$exponent];

    $multiplications->[$exponent] = $depth;
    $tree->[$depth]               = $exponent;

    foreach my $prev_depth ( reverse 0 .. $depth ) {
        make_tree( $exponent + $tree->[$prev_depth],
            $depth + 1, $tree, $multiplications, $limit );
    }

    return $multiplications;
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

122.pl

Efficient exponentiation

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Efficient exponentiation". The
problem is: For 1 ² k ² 200, find · m(k).

=head1 EXAMPLES

    perl 122.pl

=head1 USAGE

    122.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The maximum value of k.

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
