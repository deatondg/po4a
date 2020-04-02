#! /usr/bin/perl
# Character sets tester.

#########################

use strict;
use warnings;

use lib q(t);
use Testhelper;

my @tests;

push @tests,
  {
    'run'  => 'PATH/po4a-gettextize -f pod -m t-04-charsets/text-ascii.pod -M iso-8859-1 -p tmp/ascii.po',
    'test' => 'perl compare-po.pl t-04-charsets/ascii.po-ok tmp/ascii.po',
    'doc'  => 'using ascii when it\'s enough'
  },
  {
    'run'  => 'PATH/po4a-gettextize -f pod -m t-04-charsets/text-iso8859.pod -M iso-8859-1 -p tmp/iso8859.po',
    'test' => 'diff -u -I^\"POT-Creation-Date: -I^\"PO-Revision-Date: t-04-charsets/iso8859.po-ok tmp/iso8859.po 1>&2',
    'doc'  => 'use utf-8 when master file is non-ascii'
  },
  {
    'run'  => 'PATH/po4a-gettextize -f pod -m t-04-charsets/text-ascii.pod -l t-04-charsets/text-iso8859.pod -L iso-8859-1 -p tmp/ascii-iso8859.po',
    'test' => 'diff -u -I^\"POT-Creation-Date: -I^\"PO-Revision-Date:  t-04-charsets/ascii-iso8859.po-ok tmp/ascii-iso8859.po 1>&2',
    'doc'  => 'using translation\'s encoding when master is ascii'
  },
  {
    'run'  => 'PATH/po4a-translate -f pod -m t-04-charsets/text-ascii.pod -p t-04-charsets/trans.po -l tmp/text-iso8859.pod',
    'test' => 'diff -u -I^\"POT-Creation-Date: -I^\"PO-Revision-Date: t-04-charsets/text-iso8859.pod-ok tmp/text-iso8859.pod 1>&2',
    'doc' => 'translation without recoding output'
  },
  {
    'run'  => 'PATH/po4a-gettextize -f pod -m t-04-charsets/text-iso8859_.pod -M iso-8859-1 -l t-04-charsets/text-iso8859.pod -L iso-8859-1 -p tmp/utf.po',
    'test' => 'diff -u -I^\"POT-Creation-Date: -I^\"PO-Revision-Date: t-04-charsets/utf.po-ok tmp/utf.po 1>&2',
    'doc'  => 'convert msgstrs to utf-8 when master file is non-ascii'
  },
  {
    'run'  => 'PATH/po4a-translate -f pod -m t-04-charsets/text-ascii.pod -p t-04-charsets/utf.po -l tmp/utf.pod',
    'test' => 'diff -u -I^\"POT-Creation-Date: -I^\"PO-Revision-Date: t-04-charsets/utf.pod-ok tmp/utf.pod 1>&2',
    'doc'  => 'use input po\'s charset'
  };

run_all_tests(@tests);
0;
