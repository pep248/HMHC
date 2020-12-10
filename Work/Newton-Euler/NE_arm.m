%Made by Nicolas Testard if there is any question
clear; %close all;
%Only forces for now

%This seems to be the MAIN program
%The variable "Motion" descrives the motion that we want to perform with
%the simulator
%We currently have 3 possible motions:
%"slowArm", "mediumKick" and "maxJump"
Motion="slowArm";
%We execute the "Hanavan" function that loads the body parameters
Hanavan;
%we load the motion file associated to the filename choosen before
%It contains "qi" vectors which are unused, "Ji" vectors, and the "time" 
%array
load(Motion+"_q.mat")
motion.time=adapt_time(Motion,motion.time);

% Data from ground
load(Motion+"_ground.mat")


% Each Ji is a combination of vectors of dimension 6. We have as many Ji
% vectors as values inside the time array.

%Expressing body position at their CoM
%we convert the first 3 values of each J vector from mm to m
%and we convert the last 3 values of each J vector from � to rad
nb_step=length(motion.time);

[Head.pos,Head.vel,Head.acc]=kinematic(Head,motion.time,motion.J4);
[U_Trunk.pos,U_Trunk.vel,U_Trunk.acc]=kinematic(U_Trunk,motion.time,motion.J3);
[M_Trunk.pos,M_Trunk.vel,M_Trunk.acc]=kinematic(M_Trunk,motion.time,motion.J2);
[L_Trunk.pos,L_Trunk.vel,L_Trunk.acc]=kinematic(L_Trunk,motion.time,motion.J2);
[Upperarm.pos.R,Upperarm.vel.R,Upperarm.acc.R]=kinematic(Upperarm,motion.time,motion.J8);
[Upperarm.pos.L,Upperarm.vel.L,Upperarm.acc.L]=kinematic(Upperarm,motion.time,motion.J7);
[Forearm.pos.R,Forearm.vel.R,Forearm.acc.R]=kinematic(Forearm,motion.time,motion.J10);
[Forearm.pos.L,Forearm.vel.L,Forearm.acc.L]=kinematic(Forearm,motion.time,motion.J9);
[Hand.pos.R,Hand.vel.R,Hand.acc.R]=kinematic(Hand,motion.time,motion.J12);
[Hand.pos.L,Hand.vel.L,Hand.acc.L]=kinematic(Hand,motion.time,motion.J11);
[Thigh.pos.R,Thigh.vel.R,Thigh.acc.R]=kinematic(Thigh,motion.time,motion.J16);
[Thigh.pos.L,Thigh.vel.L,Thigh.acc.L]=kinematic(Thigh,motion.time,motion.J15);
[Shank.pos.R,Shank.vel.R,Shank.acc.R]=kinematic(Shank,motion.time,motion.J18);
[Shank.pos.L,Shank.vel.L,Shank.acc.L]=kinematic(Shank,motion.time,motion.J17);
[Foot.pos.R,Foot.vel.R,Foot.acc.R]=kinematic(Foot,motion.time,motion.J20);
[Foot.pos.L,Foot.vel.L,Foot.acc.L]=kinematic(Foot,motion.time,motion.J19);


F=zeros(3,nb_step);
T=F;
E=zeros(1,nb_step); U=E;
%Here we compute the reactions of each body part using the Newton-Euler
%equations
for k=1:nb_step
   
   %R Hand
   Wrist=motion.J10(1:3,k)*1e-3;% wrist position
   [F_Wrist(:,k), T_Wrist(:,k),Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Hand,Hand.pos.R(:,k),Hand.vel.R(:,k),Hand.acc.R(:,k),Wrist);
   %E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Forearm
   Elbow=motion.J8(1:3,k)*1e-3;% elbow position
   Fi=F_Wrist(:,k);
   Ti=T_Wrist(:,k)+cross(Wrist-Elbow,Fi); %expressing previous torques at the elbow point
   
   [F_Elbow(:,k),T_Elbow(:,k),Ec,Ep]=NE_one_body(Fi,Ti,Forearm,Forearm.pos.R(:,k),Forearm.vel.R(:,k),Forearm.acc.R(:,k),Elbow);
   %E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   
   %R Upperarm
   Shoulder=motion.J6(1:3,k)*1e-3;% shoulder position
   Fi=F_Elbow(:,k);
   Ti=T_Elbow(:,k)+cross(Elbow-Shoulder,Fi); %expressing previous torques at the shoulder point
   
   [F_Shoulder(:,k),T_Shoulder(:,k),Ec,Ep]=NE_one_body(Fi,Ti,Upperarm,Upperarm.pos.R(:,k),Upperarm.vel.R(:,k),Upperarm.acc.R(:,k),Shoulder);
   %E(k)=E(k)+Ec; U(k)=U(k)+Ep;

 
end
% 
% %% Changing the frame: euler angle expressed in the world frame
% x=[1;0;0] ; y=[0;1;0] ; z=[0;0;1];
% for k=1:nb_step
%     %Wrist
%     Rx=rot_x(motion.J10(4,k)*pi/180);
%     Ry=rot_x(motion.J10(4,k)*pi/180)*rot_y(motion.J10(5,k)*pi/180);
%     Rz=rot_x(motion.J10(4,k)*pi/180)*rot_y(motion.J10(5,k)*pi/180)*rot_z(motion.J10(6,k)*pi/180);
%     
%     T1_Wrist=T_Wrist'*(Rx*x);
%     T2_Wrist=T_Wrist'*(Ry*y);
%     T3_Wrist=T_Wrist'*(Rz*z);
%     
%     %Elbow
%     Rx=rot_x(motion.J8(4,k)*pi/180);
%     Ry=rot_x(motion.J8(4,k)*pi/180)*rot_y(motion.J8(5,k)*pi/180);
%     Rz=rot_x(motion.J8(4,k)*pi/180)*rot_y(motion.J8(5,k)*pi/180)*rot_z(motion.J8(6,k)*pi/180);
%     
%     T1_Elbow=T_Elbow'*(Rx*x);
%     T2_Elbow=T_Elbow'*(Ry*y);
%     T3_Elbow=T_Elbow'*(Rz*z);
%     
%     %Shoulder
%     Rx=rot_x(motion.J3(4,k)*pi/180);
%     Ry=rot_x(motion.J3(4,k)*pi/180)*rot_y(motion.J3(5,k)*pi/180);
%     Rz=rot_x(motion.J3(4,k)*pi/180)*rot_y(motion.J3(5,k)*pi/180)*rot_z(motion.J3(6,k)*pi/180);
%     
%     T1_Shoulder=T_Shoulder'*(Rx*x);
%     T2_Shoulder=T_Shoulder'*(Ry*y);
%     T3_Shoulder=T_Shoulder'*(Rz*z);
% end
% 
% %% ploting 1
% subplot(3,3,1)
% yyaxis right
% plot(motion.time,T1_Shoulder,'displayname',"Torque")
% yyaxis left
% plot(motion.time,motion.J8(4,:),'displayname',"Angle")
% title("x1 Shoulder")
% legend show
% 
% subplot(3,3,2)
% yyaxis right
% plot(motion.time,T2_Shoulder,'displayname',"Torque")
% yyaxis left
% plot(motion.time,motion.J8(5,:),'displayname',"Angle")
% title("y2 Shoulder")
% legend show
% 
% subplot(3,3,3)
% yyaxis right
% plot(motion.time,T3_Shoulder,'displayname',"Torque")
% yyaxis left
% plot(motion.time,motion.J8(6,:),'displayname',"Angle")
% title("z3 Shoulder")
% legend show
% 
% 
% 
% subplot(3,3,4)
% yyaxis right
% plot(motion.time,T1_Elbow,'displayname',"Torque")
% yyaxis left
% plot(motion.time,motion.J10(4,:),'displayname',"Angle")
% title("x1 Elbow")
% legend show
% 
% subplot(3,3,5)
% yyaxis right
% plot(motion.time,T2_Elbow,'displayname',"Torque")
% yyaxis left
% plot(motion.time,motion.J10(5,:),'displayname',"Angle")
% title("y2 Elbow")
% legend show
% 
% subplot(3,3,6)
% yyaxis right
% plot(motion.time,T3_Elbow,'displayname',"Torque")
% yyaxis left
% plot(motion.time,motion.J10(6,:),'displayname',"Angle")
% title("z3 Elbow")
% legend show
% 
% 
% 
% subplot(3,3,7)
% yyaxis right
% plot(motion.time,T1_Wrist,'displayname',"Torque")
% yyaxis left
% plot(motion.time,motion.J12(4,:),'displayname',"Angle")
% title("x1 Wrist")
% legend show
% 
% subplot(3,3,8)
% yyaxis right
% plot(motion.time,T2_Wrist,'displayname',"Torque")
% yyaxis left
% plot(motion.time,motion.J12(5,:),'displayname',"Angle")
% title("y2 Wrist")
% legend show
% 
% subplot(3,3,9)
% yyaxis right
% plot(motion.time,T3_Wrist,'displayname',"Torque")
% yyaxis left
% plot(motion.time,motion.J12(6,:),'displayname',"Angle")
% title("z3 Wrist")
% legend show

%% Changing the frame: euler angle expressed in the parent body frame
x=[1;0;0] ; y=[0;1;0] ; z=[0;0;1];
for k=1:nb_step

    Rx_hand=rot_x(motion.J12(4,k)*pi/180);
    Ry_hand=rot_x(motion.J12(4,k)*pi/180)*rot_y(motion.J12(5,k)*pi/180);
    Rz_hand=rot_x(motion.J12(4,k)*pi/180)*rot_y(motion.J12(5,k)*pi/180)*rot_z(motion.J12(6,k)*pi/180);
    
    Rx_forearm=rot_x(motion.J10(4,k)*pi/180);
    Ry_forearm=rot_x(motion.J10(4,k)*pi/180)*rot_y(motion.J10(5,k)*pi/180);
    Rz_forearm=rot_x(motion.J10(4,k)*pi/180)*rot_y(motion.J10(5,k)*pi/180)*rot_z(motion.J10(6,k)*pi/180);
    
    Rx_upperam=rot_x(motion.J8(4,k)*pi/180);
    Ry_upperam=rot_x(motion.J8(4,k)*pi/180)*rot_y(motion.J8(5,k)*pi/180);
    Rz_upperam=rot_x(motion.J8(4,k)*pi/180)*rot_y(motion.J8(5,k)*pi/180)*rot_z(motion.J8(6,k)*pi/180);
    
    Rx_trunk=rot_x(motion.J3(4,k)*pi/180);
    Ry_trunk=rot_x(motion.J3(4,k)*pi/180)*rot_y(motion.J3(5,k)*pi/180);
    Rz_trunk=rot_x(motion.J3(4,k)*pi/180)*rot_y(motion.J3(5,k)*pi/180)*rot_z(motion.J3(6,k)*pi/180);
    
    Euler_Wrist(:,k)=transpose(rotm2eul(Rz_forearm'*Rz_hand,'XYZ'));
    Euler_Elbow(:,k)=transpose(rotm2eul(Rz_upperam'*Rz_forearm,'XYZ'));
    Euler_Shoulder(:,k)=transpose(rotm2eul(Rz_trunk'*Rz_upperam,'XYZ'));
    
    
    T1_Wrist=T_Wrist'*(Rz_forearm*x);
    T2_Wrist=T_Wrist'*(Rz_forearm*rot_x(Euler_Wrist(1,k))*y);
    T3_Wrist=T_Wrist'*(Rz_forearm*rot_x(Euler_Wrist(1,k))*rot_y(Euler_Wrist(2,k))*z);
   
    T1_Elbow=T_Elbow'*(Rz_upperam*x);
    T2_Elbow=T_Elbow'*(Rz_upperam*rot_x(Euler_Elbow(1,k))*y);
    T3_Elbow=T_Elbow'*(Rz_upperam*rot_x(Euler_Elbow(1,k))*rot_y(Euler_Elbow(2,k))*z);
    
    T1_Shoulder=T_Shoulder'*(Rz_trunk*x);
    T2_Shoulder=T_Shoulder'*(Rz_trunk*rot_x(Euler_Shoulder(1,k))*y);
    T3_Shoulder=T_Shoulder'*(Rz_trunk*rot_x(Euler_Shoulder(1,k))*rot_y(Euler_Shoulder(2,k))*z);
end

%% Ploting 2
subplot(3,3,1)
yyaxis right
plot(motion.time,T1_Shoulder,'displayname',"Torque")
ylabel("Torque (N.m)")
yyaxis left
plot(motion.time,Euler_Shoulder(1,:),'displayname',"Angle")
xlabel("Times (s)")
ylabel("Angle (rad)")
title("x1 Shoulder")
grid on
legend show

subplot(3,3,2)
yyaxis right
plot(motion.time,T2_Shoulder,'displayname',"Torque")
ylabel("Torque (N.m)")
yyaxis left
plot(motion.time,Euler_Shoulder(2,:),'displayname',"Angle")
ylabel("Angle (rad)")
xlabel("Times (s)")
title("y2 Shoulder")
grid on
legend show

subplot(3,3,3)
yyaxis right
plot(motion.time,T3_Shoulder,'displayname',"Torque")
ylabel("Torque (N.m)")
yyaxis left
plot(motion.time,Euler_Shoulder(3,:),'displayname',"Angle")
ylabel("Angle (rad)")
xlabel("Times (s)")
title("z3 Shoulder")
grid on
legend show



subplot(3,3,4)
yyaxis right
plot(motion.time,T1_Elbow,'displayname',"Torque")
ylabel("Torque (N.m)")
yyaxis left
plot(motion.time,Euler_Elbow(1,:),'displayname',"Angle")
ylabel("Angle (rad)")
xlabel("Times (s)")
title("x1 Elbow")
grid on
legend show

subplot(3,3,5)
yyaxis right
plot(motion.time,T2_Elbow,'displayname',"Torque")
ylabel("Torque (N.m)")
yyaxis left
plot(motion.time,Euler_Elbow(2,:),'displayname',"Angle")
ylabel("Angle (rad)")
xlabel("Times (s)")
title("y2 Elbow")
grid on
legend show

subplot(3,3,6)
yyaxis right
plot(motion.time,T3_Elbow,'displayname',"Torque")
ylabel("Torque (N.m)")
yyaxis left
plot(motion.time,Euler_Elbow(3,:),'displayname',"Angle")
ylabel("Angle (rad)")
xlabel("Times (s)")
title("z3 Elbow")
grid on
legend show



subplot(3,3,7)
yyaxis right
plot(motion.time,T1_Wrist,'displayname',"Torque")
ylabel("Torque (N.m)")
yyaxis left
plot(motion.time,Euler_Wrist(1,:),'displayname',"Angle")
ylabel("Angle (rad)")
xlabel("Times (s)")
title("x1 Wrist")
grid on
legend show

subplot(3,3,8)
yyaxis right
plot(motion.time,T2_Wrist,'displayname',"Torque")
ylabel("Torque (N.m)")
yyaxis left
plot(motion.time,Euler_Wrist(2,:),'displayname',"Angle")
ylabel("Angle (rad)")
xlabel("Times (s)")
title("y2 Wrist")
grid on
legend show

subplot(3,3,9)
yyaxis right
plot(motion.time,T3_Wrist,'displayname',"Torque")
ylabel("Torque (N.m)")
yyaxis left
plot(motion.time,Euler_Wrist(3,:),'displayname',"Angle")
ylabel("Angle (rad)")
xlabel("Times (s)")
title("z3 Wrist")
grid on
legend show