#!/usr/bin/env perl

# PODNAME: 136.pl
# ABSTRACT: Singleton difference

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-10-28

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $limit = 50_000_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

# x = y + d
# z = y - d
# x^2 - y^2 - z^2 = n
# (y + d)^2 -y^2 - (y - d)^2 = n
# 4dy - y^2 = n
# y(4d - y) = n
my %count;
foreach my $y ( 1 .. $limit ) {
    foreach my $d ( $y / 4 + 1 .. $limit ) { ## no critic (ProhibitMagicNumbers)
        last if $y - $d < 1;
        my $n = $y * ( 4 * $d - $y );        ## no critic (ProhibitMagicNumbers)
        last if $n > $limit;

        $count{$n}++;
    }
}

printf "%d\n",
  scalar grep { defined $count{$_} && $count{$_} == 1 } ( keys %count );

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

136.pl

Singleton difference

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Singleton difference". The problem
is: How many values of n less than fifty million have exactly one solution?

=head1 EXAMPLES

    perl 136.pl --limit 100

=head1 USAGE

    136.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The maximum value of n.

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
