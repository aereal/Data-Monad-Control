package Data::Monad::Control;
use 5.008001;
use strict;
use warnings;

use Data::Monad::Either qw( left right );
use Exporter qw( import );

our $VERSION = "0.01";
our @EXPORT = qw( try );

sub try (&) {
  my ($try_clause) = @_;
  my $wantarray = wantarray;
  local $@;
  my @ret = eval {
    my @ret;
    if ($wantarray) {
      @ret = $try_clause->();
    } elsif (defined $wantarray) {
      $ret[0] = $try_clause->();
    } else {
      $try_clause->();
    }
  };
  return $@ ? left($@) : right(@ret);
}

1;
__END__

=encoding utf-8

=head1 NAME

Data::Monad::Control - It's new $module

=head1 SYNOPSIS

    use Data::Monad::Control;

=head1 DESCRIPTION

Data::Monad::Control is ...

=head1 LICENSE

Copyright (C) aereal.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

aereal E<lt>aereal@aereal.orgE<gt>

=cut

