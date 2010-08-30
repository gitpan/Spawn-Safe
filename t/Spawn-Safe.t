# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Spawn-Safe.t'

#########################

use Test::More qw/ no_plan /;
use Spawn::Safe;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $r;

$r = spawn_safe( { argv => [ '/bin/ls', '/' ], timeout => 100 } );
ok( $r, 'test1' );
ok( $r->{'stdout'}, 'test1 stdout' );
ok( !$r->{'stderr'}, 'test1 stderr' );
ok( !$r->{'error'}, 'test1 error' );
ok( $r->{'exit_code'} == 0, 'test1 exit code' );

$r = spawn_safe( { argv => [ '/bin/thisdoesntexist/no/no/no' ], timeout => 100 } );
ok( $r, 'test2' );
ok( !$r->{'stdout'}, 'test2 stdout' );
ok( !$r->{'stderr'}, 'test2 stderr' );
ok( $r->{'error'}, 'test2 error' );
ok( !$r->{'exit_code'}, 'test2 exit code' );

$r = spawn_safe( { argv => [ '/bin/sleep', 20 ], timeout => 1 } );
ok( $r, 'test3' );
ok( !$r->{'stdout'}, 'test3 stdout' );
ok( !$r->{'stderr'}, 'test3 stderr' );
ok( $r->{'error'}, 'test3 error' );
ok( !$r->{'exit_code'}, 'test3 exit code' );

