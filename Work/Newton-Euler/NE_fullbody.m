%Made by Nicolas Testard if there is any question
clear; %close all;
%Only forces for now

%This seems to be the MAIN program
%The variable "Motion" descrives the motion that we want to perform with
%the simulator
%We currently have 3 possible motions:
%"slowArm", "mediumKick" and "maxJump"
Motion="fastKickArm";
%We execute the "Hanavan" function that loads the body parameters
Hanavan;
%we load the motion file associated to the filename choosen before
%It contains "qi" vectors which are unused, "Ji" vectors, and the "time" 
%array
load(Motion+"_q.mat")
motion.time=adapt_time(Motion,motion.time);
%motion.time=motion.time-motion.time(1);
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
[Head.vel,Head.acc]=time_diff(Head.pos,motion.time);
[U_Trunk.vel,U_Trunk.acc]=time_diff(U_Trunk.pos,motion.time);
[M_Trunk.vel,M_Trunk.acc]=time_diff(M_Trunk.pos,motion.time);
[L_Trunk.vel,L_Trunk.acc]=time_diff(L_Trunk.pos,motion.time);
[Upperarm.vel.R,Upperarm.acc.R]=time_diff(Upperarm.pos.R,motion.time);
[Upperarm.vel.L,Upperarm.acc.L]=time_diff(Upperarm.pos.L,motion.time);
[Forearm.vel.R,Forearm.acc.R]=time_diff(Forearm.pos.R,motion.time);
[Forearm.vel.L,Forearm.acc.L]=time_diff(Forearm.pos.L,motion.time);
[Hand.vel.R,Hand.acc.R]=time_diff(Hand.pos.R,motion.time);
[Hand.vel.L,Hand.acc.L]=time_diff(Hand.pos.L,motion.time);
[Thigh.vel.R,Thigh.acc.R]=time_diff(Thigh.pos.R,motion.time);
[Thigh.vel.L,Thigh.acc.L]=time_diff(Thigh.pos.L,motion.time);
[Shank.vel.R,Shank.acc.R]=time_diff(Shank.pos.R,motion.time);
[Shank.vel.L,Shank.acc.L]=time_diff(Shank.pos.L,motion.time);
[Foot.vel.R,Foot.acc.R]=time_diff(Foot.pos.R,motion.time);
[Foot.vel.L,Foot.acc.L]=time_diff(Foot.pos.L,motion.time);


for k=1:6
    [Head.vel(k,:),Head.acc(k,:)]=rm_outliers(Head.vel(k,:),Head.acc(k,:));
    [U_Trunk.vel(k,:),U_Trunk.acc(k,:)]=rm_outliers(U_Trunk.vel(k,:),U_Trunk.acc(k,:));
    [M_Trunk.vel(k,:),M_Trunk.acc(k,:)]=rm_outliers(M_Trunk.vel(k,:),M_Trunk.acc(k,:));
    [L_Trunk.vel(k,:),L_Trunk.acc(k,:)]=rm_outliers(L_Trunk.vel(k,:),L_Trunk.acc(k,:));
    [Upperarm.vel.R(k,:),Upperarm.acc.R(k,:)]=rm_outliers(Upperarm.vel.R(k,:),Upperarm.acc.R(k,:));
    [Upperarm.vel.L(k,:),Upperarm.acc.L(k,:)]=rm_outliers(Upperarm.vel.L(k,:),Upperarm.acc.L(k,:));
    [Forearm.vel.R(k,:),Forearm.acc.R(k,:)]=rm_outliers(Forearm.vel.R(k,:),Forearm.acc.R(k,:));
    [Forearm.vel.L(k,:),Forearm.acc.L(k,:)]=rm_outliers(Forearm.vel.L(k,:),Forearm.acc.L(k,:));
    [Hand.vel.R(k,:),Hand.acc.R(k,:)]=rm_outliers(Hand.vel.R(k,:),Hand.acc.R(k,:));
    [Hand.vel.L(k,:),Hand.acc.L(k,:)]=rm_outliers(Hand.vel.L(k,:),Hand.acc.L(k,:));
    [Thigh.vel.R(k,:),Thigh.acc.R(k,:)]=rm_outliers(Thigh.vel.R(k,:),Thigh.acc.R(k,:));
    [Thigh.vel.L(k,:),Thigh.acc.L(k,:)]=rm_outliers(Thigh.vel.L(k,:),Thigh.acc.L(k,:));
    [Shank.vel.R(k,:),Shank.acc.R(k,:)]=rm_outliers(Shank.vel.R(k,:),Shank.acc.R(k,:));
    [Shank.vel.L(k,:),Shank.acc.L(k,:)]=rm_outliers(Shank.vel.L(k,:),Shank.acc.L(k,:));
    [Foot.vel.R(k,:),Foot.acc.R(k,:)]=rm_outliers(Foot.vel.R(k,:),Foot.acc.R(k,:));
    [Foot.vel.L(k,:),Foot.acc.L(k,:)]=rm_outliers(Foot.vel.L(k,:),Foot.acc.L(k,:));
end



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
   %Head
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Head,Head.pos(:,k),Head.vel(:,k),Head.acc(:,k),Head.pos(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Head.pos(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %U_Trunk
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),U_Trunk,U_Trunk.pos(:,k),U_Trunk.vel(:,k),U_Trunk.acc(:,k),U_Trunk.pos(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(U_Trunk.pos(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %M_Trunk
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),M_Trunk,M_Trunk.pos(:,k),M_Trunk.vel(:,k),M_Trunk.acc(:,k),M_Trunk.pos(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(M_Trunk.pos(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L_Trunk
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),L_Trunk,L_Trunk.pos(:,k),L_Trunk.vel(:,k),L_Trunk.acc(:,k),L_Trunk.pos(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(L_Trunk.pos(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Upperarm
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Upperarm,Upperarm.pos.R(:,k),Upperarm.vel.R(:,k),Upperarm.acc.R(:,k),Upperarm.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Upperarm.pos.R(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L Upperarm
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Upperarm,Upperarm.pos.L(:,k),Upperarm.vel.L(:,k),Upperarm.acc.L(:,k),Upperarm.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Upperarm.pos.L(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Forearm
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Forearm,Forearm.pos.R(:,k),Forearm.vel.R(:,k),Forearm.acc.R(:,k),Forearm.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Forearm.pos.R(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L Forearm
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Forearm,Forearm.pos.L(:,k),Forearm.vel.L(:,k),Forearm.acc.L(:,k),Forearm.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Forearm.pos.L(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Hand
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Hand,Hand.pos.R(:,k),Hand.vel.R(:,k),Hand.acc.R(:,k),Hand.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Hand.pos.R(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L Hand
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Hand,Hand.pos.L(:,k),Hand.vel.L(:,k),Hand.acc.L(:,k),Hand.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Hand.pos.L(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Thigh
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Thigh,Thigh.pos.R(:,k),Thigh.vel.R(:,k),Thigh.acc.R(:,k),Thigh.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Thigh.pos.R(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L Thigh
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Thigh,Thigh.pos.L(:,k),Thigh.vel.L(:,k),Thigh.acc.L(:,k),Thigh.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Thigh.pos.L(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Shank
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Shank,Shank.pos.R(:,k),Shank.vel.R(:,k),Shank.acc.R(:,k),Shank.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Shank.pos.R(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L Shank
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Shank,Shank.pos.L(:,k),Shank.vel.L(:,k),Shank.acc.L(:,k),Shank.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Shank.pos.L(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Foot
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Foot,Foot.pos.R(:,k),Foot.vel.R(:,k),Foot.acc.R(:,k),Foot.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Foot.pos.R(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L Foot
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Foot,Foot.pos.L(:,k),Foot.vel.L(:,k),Foot.acc.L(:,k),Foot.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Foot.pos.L(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

end


% F(isnan(F))=0;
% T(isnan(T))=0;
% 
% % Filter
% dt=motion.time(2)-motion.time(1);
% [B,A] = butter(2,20*2*dt);
% F_filtered=transpose(filtfilt(B,A,F'));
% T_filtered=transpose(filtfilt(B,A,T'));
F_filtered=F; T_filtered=T; 
for k=1:nb_step
   F_filtered(:,k)= rot_z(pi/2)*F_filtered(:,k);
   T_filtered(:,k)= rot_z(pi/2)*T_filtered(:,k);
end
%plot

%plot_comparison(motion.time,[F;T],motion.time,[F_filtered;T_filtered],["raw";"filtered"])
%plot_comparison(motion.time,[F;T],motion.time,zeros(6,length(motion.time)),["raw";"filtered"])


%% Comparison with the data
%figure

W1=[ground.Fx';ground.Fy';ground.Fz';ground.Mx';ground.My';ground.Mz'];
W2=[F_filtered;T_filtered];
%plot_comparison(ground.time,W1,motion.time,W2,["ground";"computed"])
% 
% %% CoP
% 
CoP=zeros(3,nb_step);
% T_CoP=CoP;
for k=1:nb_step
    CoP(1,k)=-T(2,k)/F(3,k);
    CoP(2,k)=T(1,k)/F(3,k);
    T_CoP(:,k)=T(:,k)-cross(CoP(:,k),F(:,k));
end

% plot_comparison(ground.time,[ground.Fx';ground.Fy';ground.Fz';ground.Mx';ground.My';ground.Mz'],...
%    motion.time,[F_filtered;T_CoP],["ground";"computed"])

for k=1:length(ground.CoPx)
    ground.T_CoP(:,k)=[ground.Mx(k); ground.My(k);ground.Mz(k)]+...
        -cross([ground.CoPx(k); ground.CoPy(k);0],[ground.Fx(k); ground.Fy(k);ground.Fz(k)]);
end
% 
% % [B,A] = butter(3,1*2*dt);
% % ground.T_CoP=transpose(filtfilt(B,A,ground.T_CoP'));
% 




% figure
% plot_comparison(ground.time,[ground.Fx';ground.Fy';ground.Fz';ground.T_CoP],...
%     motion.time,[F_filtered;T_CoP],["Force plate";"NE algo"])
plot_comparison(ground.time,[ground.Fx';ground.Fy';ground.Fz';ground.T_CoP],...
    motion.time,[F_filtered;T_CoP],["Force plate";"NE algo"])



% 
% 
% for k=1:nb_step
%     T2(:,k)=T(:,k)-cross(CoP(:,1),F_filtered(:,k));
%     T2(:,k)=T(:,k)+cross([ground.CoPx(1); ground.CoPy(1);0],F_filtered(:,k));
% end
% 
% figure
% plot_comparison(ground.time,[ground.Fx';ground.Fy';ground.Fz';ground.Mx';ground.My';ground.Mz'],...
%     motion.time,[F_filtered;T2],["ground";"computed"])

%% Energy
% figure
% % [B,A] = butter(2,5*2*dt);
% % E=filtfilt(B,A,E);
% yyaxis left
% plot(motion.time, E+U,'displayname',"Mechanical energy");
% hold on
% plot(motion.time, U,'displayname',"Potential energy");
% ylabel("Energy (J)")
% yyaxis right
% plot(motion.time, E,'displayname',"Kinetic energy");
% xlabel("Time (s)")
% ylabel("Energy (J)")
% legend show


%% Tests

% [vel,acc]=rm_outliers(Head.vel(4,:),Head.acc(4,:));
% % vel=filloutliers(Head.vel(4,:),'linear','movmedian',15);
% % acc=filloutliers(Head.acc(4,:),'linear','movmedian',15);
% % vel=hampel(Head.vel(4,:),2);
% % acc=hampel(Head.acc(4,:),2);
% %[vel,acc]=rm_outliers(Upperarm.vel.R(5,:),Upperarm.acc.R(5,:));
% figure 
% 
% subplot(2,1,1)
% plot(Head.vel(4,:))
% hold on
% plot(vel)
% subplot(2,1,2)
% plot(Head.acc(4,:))
% hold on
% plot(acc)
% close all
% plot(Thigh.vel.R(6,:))
% hold on
% plot(motion.J16(6,:))
% 
% t1=10.8; t2=11.2; t1=0; t2=12; 
% t=motion.time;
% index=find(((t>t1).*(t<t2)));
% i1=index(1);i2=index(end);
% pos=motion.J16(6,:);
% [vel,acc]=time_diff(pos,t);
% subplot(1,3,1)
% plot(t,pos,'-o')
% ylabel("Angle (�)")
% xlabel("Time (s)")
% title("Angle")
% axis([t1 t2 min(pos(i1:i2))*1.1 max(pos(i1:i2))*1.1])
% subplot(1,3,2)
% plot(t,vel,'-o')
% ylabel("Velocity (�/s)")
% xlabel("Time (s)")
% axis([t1 t2 min(vel(i1:i2))*1.1 max(vel(i1:i2))*1.1+1000])
% title("Velocity")
% subplot(1,3,3)
% plot(t,acc,'-o')
% ylabel("Acceleration (�/S^2)")
% xlabel("Time (s)")
% axis([t1 t2 min(acc(i1:i2))*1.1 max(acc(i1:i2))*1.1])
% title("Acceleration")







% subplot(2,1,1)
% hold off
% plot(Upperarm.vel.R(5,:))
% hold on
% plot(vel)
% subplot(2,1,2)
% hold off
% plot(Upperarm.acc.R(5,:))
% hold on
% plot(acc)
