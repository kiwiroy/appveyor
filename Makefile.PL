use strict;
use warnings;
use constant _win => $^O eq 'MSWin32';
use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  ABSTRACT => 'This is just a test abstract',
  DISTNAME => 'Test-Something',
  NAME     => 'Test::Something',
  VERSION  => '0.1',
);

$WriteMakefileArgs{BUILD_REQUIRES}{'Alien::MSYS'} = 0 if _win;

if (eval "use Alien::Build::MM; 1;") {
  my $abmm = Alien::Build::MM->new;
  %WriteMakefileArgs = $abmm->mm_args(%WriteMakefileArgs);

  no strict 'refs';
  *{"MY::postamble"} = sub { $abmm->mm_postamble; };
}

WriteMakefile(%WriteMakefileArgs);
