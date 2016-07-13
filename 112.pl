#!/usr/bin/env perl

# PODNAME: 112.pl
# ABSTRACT: Bouncy numbers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-07-13

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $proportion = 99;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $total  = 100;       ## no critic (ProhibitMagicNumbers)
my $bouncy = 0;
## no critic (ProhibitMagicNumbers)
while ( $bouncy / $total * 100 != $proportion ) {
    ## use critic
    $total++;
    if ( is_bouncy($total) ) {
        $bouncy++;
    }
}

printf "%d\n", $total;

sub is_bouncy {
    my ($num) = @_;

    my (@digits) = split //xms, $num;
    my $seen_up = 0;
    my $seen_down = 0;
    foreach my $i ( 1 .. scalar @digits - 1 ) {
        if ( $digits[$i] > $digits[ $i - 1 ] ) {
            $seen_up = 1;
        }
        elsif ( $digits[$i] < $digits[ $i - 1 ] ) {
            $seen_down = 1;
        }
        if ( $seen_up && $seen_down ) {
            return 1;
        }
    }

    return 0;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'proportion=i' => \$proportion,
        'debug'        => \$debug,
        'help'         => \$help,
        'man'          => \$man,
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

112.pl

Primes with runs

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Bouncy numbers". The problem is:
Find the least number for which the proportion of bouncy numbers is exactly 99%.

=head1 EXAMPLES

    perl 112.pl

=head1 USAGE

    112.pl
        [--proportion INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--proportion INT>

Target proportion of bouncy numbers.

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
