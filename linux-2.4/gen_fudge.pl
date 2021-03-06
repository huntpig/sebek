#!/usr/bin/perl

#
# * Copyright (C) 2001/2002 The Honeynet Project.
# * All rights reserved.
# *
# * Redistribution and use in source and binary forms, with or without
# * modification, are permitted provided that the following conditions
# * are met:
# * 1. Redistributions of source code must retain the above copyright
# *    notice, this list of conditions and the following disclaimer.
# * 2. Redistributions in binary form must reproduce the above copyright
# *    notice, this list of conditions and the following disclaimer in the
# *    documentation and/or other materials provided with the distribution.
# * 3. All advertising materials mentioning features or use of this software
# *    must display the following acknowledgement:
# *      This product includes software developed by The Honeynet Project.
# * 4. The name "The Honeynet Project" may not be used to endorse or promote
# *    products derived from this software without specific prior written
# *    permission.
# *
# * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY
# * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE
# * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# * SUCH DAMAGE.
#

#---- perl script to generate a bunch of random values to
#---- feed the build process
#---- Edward Balas
use strict;


sub main{

    my $bs;

    my $dip;
    my $dport;
    my $sip;
    my $sport;
    my $kso;
    my $st;
    my $magic;
    my $testing;
    my $wt;   
 
    my $smac0;
    my $smac1;
    my $smac2;
    my $smac3;
    my $smac4;
    my $smac5;

    
    my $dmac0;
    my $dmac1;
    my $dmac2;
    my $dmac3;
    my $dmac4;
    my $dmac5;

    my $dummy1;
    my $dummy2;

    my $m_if;
    my $m_dip;
    my $m_dmac;
    my $m_dport;
    my $m_sport;
    my $m_kso;
    my $m_st;
    my $m_wt;
    my $m_testing;

    my $m_filter;

    my $m_magic;
    my $m_block;

    my $mod_name;

    my %values;

    my @fun;
    

    my $x;
    my $tmp;

    srand(time() ^ ($$ + ($$ << 15)));

    $bs =  128 + int(rand(128));


    for($x=0;$x<48;$x++){
	$tmp = int(rand() * $bs);

	if(!defined($values{$tmp})){
	    $values{$tmp} = $x;
	    push(@fun,$tmp);
	}else{
	    $x--;
	}
    }

    ($dip,
     $dport,
     $sip,
     $sport,
     $kso,
     $st,
     $magic,
     $wt,
     $testing,
     $smac0,
     $smac1,
     $smac2,
     $smac3,
     $smac4,
     $smac5,
     $dmac0,
     $dmac1,
     $dmac2,
     $dmac3,
     $dmac4,
     $dmac5,
     $m_if,
     $m_dip,
     $m_dmac,
     $m_dport,
     $m_sport,
     $m_kso,
     $m_st,
     $m_wt,
     $m_filter,
     $m_magic,
     $m_block,
     $m_testing) = @fun;

    $m_block = int(rand(1000000000));
    $mod_name = int(rand(1000000000));


    printf"//----- autogenerated fudge.h file\n\n\n";
    printf"#ifndef _FUDGE_H_\n";
    printf"#define _FUDGE_H_\n";


    print "#define BS               $bs\n";
    print "#define DIP_OFFSET       $dip\n";
    print "#define DPORT_OFFSET     $dport\n";
    print "#define SIP_OFFSET       $sip\n";
    print "#define SPORT_OFFSET     $sport\n";

    print "#define KSO_OFFSET       $kso\n";
    print "#define ST_OFFSET        $st\n";
    print "#define MAGIC_OFFSET     $magic\n";
    print "#define TESTING_OFFSET   $testing\n";
    print "#define WT_OFFSET        $wt\n";

    print "#define SMAC_0_OFFSET    $smac0\n";
    print "#define SMAC_1_OFFSET    $smac1\n";
    print "#define SMAC_2_OFFSET    $smac2\n";
    print "#define SMAC_3_OFFSET    $smac3\n";
    print "#define SMAC_4_OFFSET    $smac4\n";
    print "#define SMAC_5_OFFSET    $smac5\n";

    print "#define DMAC_0_OFFSET    $dmac0\n";
    print "#define DMAC_1_OFFSET    $dmac1\n";
    print "#define DMAC_2_OFFSET    $dmac2\n";
    print "#define DMAC_3_OFFSET    $dmac3\n";
    print "#define DMAC_4_OFFSET    $dmac4\n";
    print "#define DMAC_5_OFFSET    $dmac5\n";


    print "#define INTERFACE         a$m_if\n";
    print "#define DESTINATION_IP    a$m_dip\n";
    print "#define DESTINATION_MAC   a$m_dmac\n";
    print "#define DESTINATION_PORT  a$m_dport\n";
    print "#define SOURCE_PORT       a$m_sport\n";
    print "#define KEYSTROKES_ONLY   a$m_kso\n";
    print "#define SOCKET_TRACKING   a$m_st\n";
    print "#define WRITE_TRACKING    a$m_wt\n";
    print "#define MAGIC_VALUE       a$m_magic\n";
    print "#define TESTING           a$m_testing\n";
    print "#define BLOCK             a$m_block\n";
 
    print "#define FILTER_FILE       a$m_filter\n";


    printf"#endif\n";


#======================================================================

    open(SH,">./parameters.sh") or die "Unable to open ./parameters.sh\n";

    print SH "DIP_PARM=a$m_dip\n";
    print SH "DMAC_PARM=a$m_dmac\n";
    print SH "DPORT_PARM=a$m_dport\n";
    print SH "SPORT_PARM=a$m_sport\n";
    print SH "INT_PARM=a$m_if\n";
    print SH "KSO_PARM=a$m_kso\n";
    print SH "WT_PARM=a$m_wt\n";
    print SH "ST_PARM=a$m_st\n";
    print SH "MAGIC_PARM=a$m_magic\n";
    print SH "TESTING_PARM=a$m_testing\n";
    print SH "FILTER_PARM=a$m_filter\n";
    print SH "RAND_MOD_NAME=$mod_name".".o\n";

    close(SH);
  


}


main();
