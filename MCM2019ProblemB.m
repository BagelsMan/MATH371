% Structs for params given in problem statement

close all;
clear all;
clc;

A = [45, 45, 25];
B = [30, 30, 22];
%% Cargo Container structs
container.len=231;
container.wid=92;
container.hei=25;

%% Carbo Bay structs
cargo1.len=8;
cargo1.wid=10;
cargo1.hei=14;

cargo2.len=24;
cargo2.wid=20;
cargo2.hei=20;

%% Package type structs
med1.weight=2;
med1.len=14;
med1.wid=7;
med1.hei=5;
med2.weight=2;
med2.len=5;
med2.wid=8;
med2.hei=5;
med3.weight=3;
med3.len=12;
med3.wid=7;
med3.hei=4;

%% Drone type structs

% drone A
drone.A.len=45;
drone.A.wid=45;
drone.A.hei=25;
drone.A.pay=3.5;
drone.A.speed=40;
drone.A.ft=35;
drone.A.vc=1;
drone.A.mpc=1;
drone.A.cbt=1;

% drone B
drone.B.len=30;
drone.B.wid=30;
drone.B.hei=22;
drone.B.pay=8;
drone.B.speed=79;
drone.B.ft=40;
drone.B.vc=1;
drone.B.mpc=1;
drone.B.cbt=1;

% drone C
drone.C.len=60;
drone.C.wid=50;
drone.C.hei=30;
drone.C.pay=14;
drone.C.speed=64;
drone.C.ft=35;
drone.C.vc=1;
drone.C.mpc=1;
drone.C.cbt=2;

% drone D
drone.D.len=25;
drone.D.wid=20;
drone.D.hei=25;
drone.D.pay=11;
drone.D.speed=60;
drone.D.ft=18;
drone.D.vc=1;
drone.D.mpc=1;
drone.D.cbt=1;

% drone E
drone.E.len=25;
drone.E.wid=20;
drone.E.hei=27;
drone.E.pay=15;
drone.E.speed=60;
drone.E.ft=15;
drone.E.vc=1;
drone.E.mpc=1;
drone.E.cbt=2;

% drone F
drone.F.len=40;
drone.F.wid=40;
drone.F.hei=25;
drone.F.pay=22;
drone.F.speed=79;
drone.F.ft=24;
drone.F.vc=0;
drone.F.mpc=1;
drone.F.cbt=2;

% drone G
drone.G.len=32;
drone.G.wid=32;
drone.G.hei=17;
drone.G.pay=20;
drone.G.speed=64;
drone.G.ft=16;
drone.G.vc=1;
drone.G.mpc=1;
drone.G.cbt=2;

% drone H  this is the tethered one
drone.H.len=65;
drone.H.wid=75;
drone.H.hei=41;
drone.H.pay=0; %fix
drone.H.speed=0; %fix
drone.H.ft=0; %fix
drone.H.vc=0;
drone.H.mpc=0;
drone.H.cbt=3;

%% Sizes
CC=[container.len,container.wid,container.hei];
CB1=[cargo1.len,cargo1.wid,cargo1.hei]
CB2=[cargo2.len,cargo2.wid,cargo2.hei]
A=[drone.A.len,drone.A.wid,drone.A.hei];
B=[drone.B.len,drone.B.wid,drone.B.hei];
C=[drone.C.len,drone.C.wid,drone.C.hei];
D=[drone.D.len,drone.D.wid,drone.D.hei];
E=[drone.E.len,drone.E.wid,drone.E.hei];
F=[drone.F.len,drone.F.wid,drone.F.hei];
G=[drone.G.len,drone.G.wid,drone.G.hei];
H=[drone.H.len,drone.H.wid,drone.H.hei];
M1=[med1.len,med1.wid,med1.hei]
M2=[med2.len,med2.wid,med2.hei]
M3=[med3.len,med3.wid,med3.hei]

%% Call Packing Function
req=[1,0,1]; %[number of med1 packs, number of med2 packs, number of med3 packs]
cargo=1;
[m1,m2,m3]=medpacking(req,cargo,M1,M2,M3,CB1,CB2)


