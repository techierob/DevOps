#!/bin/sh
perl -MFile::Path -ne 'chomp;@d=(@{[split(/-/,$_,5)]}[1..3],"$_.mov");mkpath(join("/",@d[0..2]));open(F,">".join("/",@d))' codes.txt
