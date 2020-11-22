%Made by Nicolas Testard if there is any question

Motion="slowArm";
Hanavan;
load(Motion+"_q.mat")

%[X,Y,Z] = ellipsoid(xc,yc,zc,xr,yr,zr,n)
%[X,Y,Z] = cylinder(r,n)
R=2;H=1;
hold off
[X,Y,Z] = cylinder(R/H);
X=H*X;Y=H*Y;Z=H*Z;
surf(X,Y,Z)
hold on
X=X+1;Y=Y+1;Z=Z+1;
surf(X,Y,Z)
[X,Y,Z] = ellipsoid(0,0,0,1,1,2);
surf(X,Y,Z)
[X,Y,Z]=trans_rot(X,Y,Z,[1;1;1;pi/4;0;0]);
surf(X,Y,Z)

L=length(motion.time);
dt=motion.time(2)-motion.time(1);

for k=1:L
    hold off
   %head
   [X,Y,Z] = ellipsoid(0,0,0,Head.a,Head.b,Head.c);
   [X,Y,Z]=trans_rot(X,Y,Z,motion.q4(:,k));
   surf(X,Y,Z);
   hold on
   
   %M_Trunk
   [X,Y,Z]=elliptical(M_Trunk.a0,M_Trunk.b0,M_Trunk.a1,M_Trunk.b1,M_Trunk.L); Z=Z-M_Trunk.L/2;
   [X,Y,Z]=trans_rot(X,Y,Z,motion.q8(:,k));
   surf(X,Y,Z);
   
   %L_trunk
   [X,Y,Z]=elliptical(L_Trunk.a0,L_Trunk.b0,L_Trunk.a1,L_Trunk.b1,L_Trunk.L);  Z=Z-L_Trunk.L/2;
   [X,Y,Z]=trans_rot(X,Y,Z,motion.q5(:,k));
   surf(X,Y,Z);
   
   %R upper arm
   [X,Y,Z]=elliptical(Upperarm.a0,Upperarm.b0,Upperarm.a1,Upperarm.b1,Upperarm.L);  Z=Z-Upperarm.L/2;
   [X,Y,Z]=trans_rot(X,Y,Z,motion.q1(:,k));
   surf(X,Y,Z,2*ones(2,21));
   
   %L upper arm
   [X,Y,Z]=elliptical(Upperarm.a0,Upperarm.b0,Upperarm.a1,Upperarm.b1,Upperarm.L);  Z=Z-Upperarm.L/2;
   [X,Y,Z]=trans_rot(X,Y,Z,motion.q3(:,k));
   surf(X,Y,Z,2*ones(2,21));
   
   %R forearm
   [X,Y,Z]=elliptical(Forearm.a0,Forearm.b0,Forearm.a1,Forearm.b1,Forearm.L);  Z=Z-Forearm.L/2;
   [X,Y,Z]=trans_rot(X,Y,Z,motion.q11(:,k));
   surf(X,Y,Z,ones(2,21));
   
   %L forearm
   [X,Y,Z]=elliptical(Forearm.a0,Forearm.b0,Forearm.a1,Forearm.b1,Forearm.L);  Z=Z-Forearm.L/2;
   [X,Y,Z]=trans_rot(X,Y,Z,motion.q7(:,k));
   surf(X,Y,Z,ones(2,21));
   
   axis("equal")
   pause(dt)
end

% for k=L:L
%     hold off
%     plot3(motion.q1(1,k),motion.q1(2,k),motion.q1(3,k),'o-b') % R upper arm
%     hold on
%     plot3(motion.q2(1,k),motion.q2(2,k),motion.q2(3,k),'o-b')% R shank
%     plot3(motion.q3(1,k),motion.q3(2,k),motion.q3(3,k),'o-b')%L upper arm
%     plot3(motion.q4(1,k),motion.q4(2,k),motion.q4(3,k),'o-r') %Head
%     plot3(motion.q5(1,k),motion.q5(2,k),motion.q5(3,k),'o-g') %L_Trunk
%     plot3(motion.q6(1,k),motion.q6(2,k),motion.q6(3,k),'o-b') %L shank
%     plot3(motion.q7(1,k),motion.q7(2,k),motion.q7(3,k),'o-b') %L forearm
%     plot3(motion.q8(1,k),motion.q8(2,k),motion.q8(3,k),'o-c') %M_Trunk
%     plot3(motion.q9(1,k),motion.q9(2,k),motion.q9(3,k),'o-b') % R shoulder
%     plot3(motion.q10(1,k),motion.q10(2,k),motion.q10(3,k),'o-b') %L shoulder
%     plot3(motion.q11(1,k),motion.q11(2,k),motion.q11(3,k),'o-b') %R forearm
%     plot3(motion.q12(1,k),motion.q12(2,k),motion.q12(3,k),'o-b') %R thigh
%     plot3(motion.q13(1,k),motion.q13(2,k),motion.q13(3,k),'o-b') %R foot
%     plot3(motion.q14(1,k),motion.q14(2,k),motion.q14(3,k),'o-b') %L thight
%     plot3(motion.q15(1,k),motion.q15(2,k),motion.q15(3,k),'o-b') %R hand
%     plot3(motion.q16(1,k),motion.q16(2,k),motion.q16(3,k),'o-b') %L foot
%     plot3(motion.q17(1,k),motion.q17(2,k),motion.q17(3,k),'o-b') %L hand
%     axis("equal")
%     pause(dt)
% end
