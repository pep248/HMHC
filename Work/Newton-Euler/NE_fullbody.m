%Made by Nicolas Testard if there is any question
clear; close all;
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
%motion.time=motion.time-motion.time(1)+1.25; % quickJump
motion.time=motion.time-motion.time(1)+2; % slowArm

% Data from ground
load(Motion+"_ground.mat")


% Each Ji is a combination of vectors of dimension 6. We have as many Ji
% vectors as values inside the time array.

%Expressing body position at their CoM
%we convert the first 3 values of each J vector from mm to m
%and we convert the last 3 values of each J vector from � to rad
nb_step=length(motion.time);

for k=1:nb_step
    Head.pos(:,k)=CoM_pos_orientation(Head,motion.J4(:,k));
    U_Trunk.pos(:,k)=CoM_pos_orientation(U_Trunk,motion.J3(:,k));
    M_Trunk.pos(:,k)=CoM_pos_orientation(M_Trunk,motion.J2(:,k));
    L_Trunk.pos(:,k)=CoM_pos_orientation(L_Trunk,motion.J2(:,k));
    Upperarm.pos.R(:,k)=CoM_pos_orientation(Upperarm,motion.J8(:,k));
    Upperarm.pos.L(:,k)=CoM_pos_orientation(Upperarm,motion.J7(:,k));
    Forearm.pos.R(:,k)=CoM_pos_orientation(Forearm,motion.J10(:,k));
    Forearm.pos.L(:,k)=CoM_pos_orientation(Forearm,motion.J9(:,k));
    Hand.pos.R(:,k)=CoM_pos_orientation(Hand,motion.J12(:,k));
    Hand.pos.L(:,k)=CoM_pos_orientation(Hand,motion.J11(:,k));
    Thigh.pos.R(:,k)=CoM_pos_orientation(Thigh,motion.J16(:,k));
    Thigh.pos.L(:,k)=CoM_pos_orientation(Thigh,motion.J15(:,k));
    Shank.pos.R(:,k)=CoM_pos_orientation(Shank,motion.J18(:,k));
    Shank.pos.L(:,k)=CoM_pos_orientation(Shank,motion.J17(:,k));
    Foot.pos.R(:,k)=CoM_pos_orientation(Foot,motion.J20(:,k));
    Foot.pos.L(:,k)=CoM_pos_orientation(Foot,motion.J19(:,k));
end

%Here we compute the discrete time derivative and the discrete double time 
%derivative of the J vector using the time array for the increment
[Head.velocity,Head.acceleration]=time_diff(Head.pos,motion.time);
[U_Trunk.velocity,U_Trunk.acceleration]=time_diff(U_Trunk.pos,motion.time);
[M_Trunk.velocity,M_Trunk.acceleration]=time_diff(M_Trunk.pos,motion.time);
[L_Trunk.velocity,L_Trunk.acceleration]=time_diff(L_Trunk.pos,motion.time);
[Upperarm.velocity.R,Upperarm.acceleration.R]=time_diff(Upperarm.pos.R,motion.time);
[Upperarm.velocity.L,Upperarm.acceleration.L]=time_diff(Upperarm.pos.L,motion.time);
[Forearm.velocity.R,Forearm.acceleration.R]=time_diff(Forearm.pos.R,motion.time);
[Forearm.velocity.L,Forearm.acceleration.L]=time_diff(Forearm.pos.L,motion.time);
[Hand.velocity.R,Hand.acceleration.R]=time_diff(Hand.pos.R,motion.time);
[Hand.velocity.L,Hand.acceleration.L]=time_diff(Hand.pos.L,motion.time);
[Thigh.velocity.R,Thigh.acceleration.R]=time_diff(Thigh.pos.R,motion.time);
[Thigh.velocity.L,Thigh.acceleration.L]=time_diff(Thigh.pos.L,motion.time);
[Shank.velocity.R,Shank.acceleration.R]=time_diff(Shank.pos.R,motion.time);
[Shank.velocity.L,Shank.acceleration.L]=time_diff(Shank.pos.L,motion.time);
[Foot.velocity.R,Foot.acceleration.R]=time_diff(Foot.pos.R,motion.time);
[Foot.velocity.L,Foot.acceleration.L]=time_diff(Foot.pos.L,motion.time);

for k=1:6
    [Head.velocity(k,:),Head.acceleration(k,:)]=rm_outliers(Head.velocity(k,:),Head.acceleration(k,:));
    [U_Trunk.velocity(k,:),U_Trunk.acceleration(k,:)]=rm_outliers(U_Trunk.velocity(k,:),U_Trunk.acceleration(k,:));
    [M_Trunk.velocity(k,:),M_Trunk.acceleration(k,:)]=rm_outliers(M_Trunk.velocity(k,:),M_Trunk.acceleration(k,:));
    [L_Trunk.velocity(k,:),L_Trunk.acceleration(k,:)]=rm_outliers(L_Trunk.velocity(k,:),L_Trunk.acceleration(k,:));
    [Upperarm.velocity.R(k,:),Upperarm.acceleration.R(k,:)]=rm_outliers(Upperarm.velocity.R(k,:),Upperarm.acceleration.R(k,:));
    [Upperarm.velocity.L(k,:),Upperarm.acceleration.L(k,:)]=rm_outliers(Upperarm.velocity.L(k,:),Upperarm.acceleration.L(k,:));
    [Forearm.velocity.R(k,:),Forearm.acceleration.R(k,:)]=rm_outliers(Forearm.velocity.R(k,:),Forearm.acceleration.R(k,:));
    [Forearm.velocity.L(k,:),Forearm.acceleration.L(k,:)]=rm_outliers(Forearm.velocity.L(k,:),Forearm.acceleration.L(k,:));
    [Hand.velocity.R(k,:),Hand.acceleration.R(k,:)]=rm_outliers(Hand.velocity.R(k,:),Hand.acceleration.R(k,:));
    [Hand.velocity.L(k,:),Hand.acceleration.L(k,:)]=rm_outliers(Hand.velocity.L(k,:),Hand.acceleration.L(k,:));
    [Thigh.velocity.R(k,:),Thigh.acceleration.R(k,:)]=rm_outliers(Thigh.velocity.R(k,:),Thigh.acceleration.R(k,:));
    [Thigh.velocity.L(k,:),Thigh.acceleration.L(k,:)]=rm_outliers(Thigh.velocity.L(k,:),Thigh.acceleration.L(k,:));
    [Shank.velocity.R(k,:),Shank.acceleration.R(k,:)]=rm_outliers(Shank.velocity.R(k,:),Shank.acceleration.R(k,:));
    [Shank.velocity.L(k,:),Shank.acceleration.L(k,:)]=rm_outliers(Shank.velocity.L(k,:),Shank.acceleration.L(k,:));
    [Foot.velocity.R(k,:),Foot.acceleration.R(k,:)]=rm_outliers(Foot.velocity.R(k,:),Foot.acceleration.R(k,:));
    [Foot.velocity.L(k,:),Foot.acceleration.L(k,:)]=rm_outliers(Foot.velocity.L(k,:),Foot.acceleration.L(k,:));
end

F=zeros(3,nb_step);
T=F;

%Here we compute the reactions of each body part using the Newton-Euler
%equations
for k=1:nb_step
   %Head
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Head,Head.pos(:,k),Head.velocity(:,k),Head.acceleration(:,k),Head.pos(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Head.pos(1:3,k),Fi);

   %U_Trunk
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),U_Trunk,U_Trunk.pos(:,k),U_Trunk.velocity(:,k),U_Trunk.acceleration(:,k),U_Trunk.pos(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(U_Trunk.pos(1:3,k),Fi);
   
   %M_Trunk
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),M_Trunk,M_Trunk.pos(:,k),M_Trunk.velocity(:,k),M_Trunk.acceleration(:,k),M_Trunk.pos(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(M_Trunk.pos(1:3,k),Fi);
   
   %L_Trunk
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),L_Trunk,L_Trunk.pos(:,k),L_Trunk.velocity(:,k),L_Trunk.acceleration(:,k),L_Trunk.pos(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(L_Trunk.pos(1:3,k),Fi);
   
   %R Upperarm
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Upperarm,Upperarm.pos.R(:,k),Upperarm.velocity.R(:,k),Upperarm.acceleration.R(:,k),Upperarm.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Upperarm.pos.R(1:3,k),Fi);
   
   %L Upperarm
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Upperarm,Upperarm.pos.L(:,k),Upperarm.velocity.L(:,k),Upperarm.acceleration.L(:,k),Upperarm.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Upperarm.pos.L(1:3,k),Fi);
   
   %R Forearm
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Forearm,Forearm.pos.R(:,k),Forearm.velocity.R(:,k),Forearm.acceleration.R(:,k),Forearm.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Forearm.pos.R(1:3,k),Fi);
   
   %L Forearm
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Forearm,Forearm.pos.L(:,k),Forearm.velocity.L(:,k),Forearm.acceleration.L(:,k),Forearm.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Forearm.pos.L(1:3,k),Fi);
   
   %R Hand
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Hand,Hand.pos.R(:,k),Hand.velocity.R(:,k),Hand.acceleration.R(:,k),Hand.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Hand.pos.R(1:3,k),Fi);
   
   %L Hand
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Hand,Hand.pos.L(:,k),Hand.velocity.L(:,k),Hand.acceleration.L(:,k),Hand.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Hand.pos.L(1:3,k),Fi);
   
   %R Thigh
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Thigh,Thigh.pos.R(:,k),Thigh.velocity.R(:,k),Thigh.acceleration.R(:,k),Thigh.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Thigh.pos.R(1:3,k),Fi);
   
   %L Thigh
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Thigh,Thigh.pos.L(:,k),Thigh.velocity.L(:,k),Thigh.acceleration.L(:,k),Thigh.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Thigh.pos.L(1:3,k),Fi);
   
   %R Shank
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Shank,Shank.pos.R(:,k),Shank.velocity.R(:,k),Shank.acceleration.R(:,k),Shank.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Shank.pos.R(1:3,k),Fi);
   
   %L Shank
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Shank,Shank.pos.L(:,k),Shank.velocity.L(:,k),Shank.acceleration.L(:,k),Shank.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Shank.pos.L(1:3,k),Fi);
   
   %R Foot
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Foot,Foot.pos.R(:,k),Foot.velocity.R(:,k),Foot.acceleration.R(:,k),Foot.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Foot.pos.R(1:3,k),Fi);
   
   %L Foot
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Foot,Foot.pos.L(:,k),Foot.velocity.L(:,k),Foot.acceleration.L(:,k),Foot.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Foot.pos.L(1:3,k),Fi);
end


% Filter
dt=motion.time(2)-motion.time(1);
[B,A] = butter(2,5*2*dt);
F_filtered=transpose(filtfilt(B,A,F'));
T_filtered=transpose(filtfilt(B,A,T'));

%plot
subplot(3,2,1)
hold off
plot(motion.time,F(1,:))
hold on
plot(motion.time,F_filtered(1,:))
title("Fx")
legend("ground","filtered")
xlabel("Time (s)")
ylabel("Force (N)")

subplot(3,2,3)
hold off
plot(motion.time,F(2,:))
hold on
plot(motion.time,F_filtered(2,:))
title("Fy")
legend("ground","filtered")
xlabel("Time (s)")
ylabel("Force (N)")

subplot(3,2,5)
hold off
plot(motion.time,F(3,:))
hold on
plot(motion.time,F_filtered(3,:))
title("Fz")
legend("ground","filtered")
xlabel("Time (s)")
ylabel("Force (N)")

subplot(3,2,2)
hold off
plot(motion.time,T(1,:))
hold on
plot(motion.time,T_filtered(1,:))
title("Tx")
legend("ground","filtered")
xlabel("Time (s)")
ylabel("Torque (N.m)")

subplot(3,2,4)
hold off
plot(motion.time,T(2,:))
hold on
plot(motion.time,T_filtered(2,:))
title("Ty")
legend("ground","filtered")
xlabel("Time (s)")
ylabel("Torque (N.m)")

subplot(3,2,6)
hold off
plot(motion.time,T(3,:))
hold on
plot(motion.time,T_filtered(3,:))
title("Tz")
legend("ground","filtered")
xlabel("Time (s)")
ylabel("Torque (N.m)")


%% Comparison with the data
figure
subplot(3,2,1)
hold off
plot(ground.time,ground.Fx)
hold on
plot(motion.time,F_filtered(1,:))
title("Fx")
legend("ground","computed")
xlabel("Time (s)")
ylabel("Force (N)")

subplot(3,2,3)
hold off
plot(ground.time,ground.Fy)
hold on
plot(motion.time,F_filtered(2,:))
title("Fy")
legend("ground","computed")
xlabel("Time (s)")
ylabel("Force (N)")

subplot(3,2,5)
hold off
plot(ground.time,ground.Fz)
hold on
plot(motion.time,F_filtered(3,:))
title("Fz")
legend("ground","computed")
xlabel("Time (s)")
ylabel("Force (N)")

subplot(3,2,2)
hold off
plot(ground.time,ground.Mx)
hold on
plot(motion.time,T_filtered(1,:))
title("Tx")
legend("ground","computed")
xlabel("Time (s)")
ylabel("Torque (N.m)")

subplot(3,2,4)
hold off
plot(ground.time,ground.My)
hold on
plot(motion.time,T_filtered(2,:))
title("Ty")
legend("ground","computed")
xlabel("Time (s)")
ylabel("Torque (N.m)")

subplot(3,2,6)
hold off
plot(ground.time,ground.Mz)
hold on
plot(motion.time,T_filtered(3,:))
title("Tz")
legend("ground","computed")
xlabel("Time (s)")
ylabel("Torque (N.m)")


% [vel,acc]=rm_outliers(Head.velocity(4,:),Head.acceleration(4,:));
% %[vel,acc]=rm_outliers(Upperarm.velocity.R(5,:),Upperarm.acceleration.R(5,:));
% figure 
% 
% subplot(2,1,1)
% plot(Head.velocity(4,:))
% hold on
% plot(vel)
% subplot(2,1,2)
% plot(Head.acceleration(4,:))
% hold on
% plot(acc)

% subplot(2,1,1)
% hold off
% plot(Upperarm.velocity.R(5,:))
% hold on
% plot(vel)
% subplot(2,1,2)
% hold off
% plot(Upperarm.acceleration.R(5,:))
% hold on
% plot(acc)
