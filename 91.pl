#!/usr/bin/env perl

# PODNAME: 91.pl
# ABSTRACT: Right triangles with integer coordinates

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-03-12

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $max = 50;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $count = 0;

foreach my $x1 ( 0 .. $max ) {
    foreach my $y1 ( 0 .. $max ) {
        next if $x1 == 0 && $y1 == 0;
        my @op = ( $x1, $y1 );
        foreach my $x2 ( 0 .. $max ) {
            foreach my $y2 ( 0 .. $max ) {
                next if $x2 == 0   && $y2 == 0;
                next if $x1 == $x2 && $y1 == $y2;
                my @oq = ( $x2, $y2 );
                my @pq = ( $x2 - $x1, $y2 - $y1 );
                if (   !dot_product( @op, @oq )
                    || !dot_product( @op, @pq )
                    || !dot_product( @oq, @pq ) )
                {
                    $count++;
                }
            }
        }
    }
}

printf "%d\n", $count / 2;

sub dot_product {
    my @vectors = @_;
    ## no critic (ProhibitMagicNumbers)
    return $vectors[0] * $vectors[2] + $vectors[1] * $vectors[3];
    ## use critic
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'max=i' => \$max,
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

91.pl

Right triangles with integer coordinates

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Right triangles with integer
coordinates". The problem is: Given that 0 ≤ x1, y1, x2, y2 ≤ 50, how many right
triangles can be formed?

=head1 EXAMPLES

    perl 91.pl --max 2

=head1 USAGE

    91.pl
        [--max INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--max INT>

The maximum x or y coordinate.

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
