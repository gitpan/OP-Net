use ExtUtils::MakeMaker;

my $prereqs = {
                       OP => 0.317,
   Data::Validate::Domain => 0.09,
    Data::Validate::Email => 0.04,
       Data::Validate::IP => 0.08,
      Data::Validate::URI => 0.05,
           Email::Address => 1.889,
             Net::Subnets => 0.21,
};

WriteMakefile(
  VERSION_FROM  => 'lib/OP/Net.pm',
  NAME          => 'OP::Net',
  PREREQ_PM     => $prereqs,
  LICENSE       => 'open_source',
  AUTHOR        => 'Alex Ayars <pause@nodekit.org>',
);
