% plot(Head.acc(6,:)')
% legend("1","2","3","4","5","6")
%hold off
%A=motion.J16(6,:);
%A=motion.J10(3,:);
% A=Thigh.vel.L(3,:)
%plot(motion.time,A)
%hold on
%plot(diff(A))
%plot(ischange(A,'mean'))

%quickJump

[Fx,T]=signal_resampling(ground.Fx,ground.time,motion.time);
hold off
plot(ground.time,ground.Fx)
hold on
plot(T,Fx)
xlabel("Time (s)")
ylabel("Force (N)")
title("Force, x-axis, quickJump")
legend("initial","resampled")