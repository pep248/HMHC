m1 = 1;
l1 = 1;
g = 9.81;
initial_q1 = -45;
final_q1 = 45;

%Sample Time
n_samples = 100;
final_time = 2;
period = final_time/n_samples;

PID1 = pid2(14.3138149657372,4.17808641911281,7.81525199135178,period,1,1,period);

sim('Model','StartTime','0','StopTime','simulation_time','FixedStep','step_size');

%q1 = ans.simout;
%t_size = size(q1);
%t_size = t_size(1);

figure
%{
for t = 1:1:t_size
hold on
axis([-l1-0.2 +l1+0.2 -l1-0.2 +l1+0.2])
plot([0 cosd(q1(t)+90)*(l1-0.1)], [0 sind(q1(t)+90)*(l1-0.1)])
axis([-l1-0.2 +l1+0.2 -l1-0.2 +l1+0.2])
circle(cosd(q1(t)+90)*l1,sind(q1(t)+90)*l1,0.1)
axis([-l1-0.2 +l1+0.2 -l1-0.2 +l1+0.2])
pause(step_size)
hold off
clf
end
%}

function h = circle(x,y,r)
th = 0:0.1:360;
xunit = r * cosd(th) + x;
yunit = r * sind(th) + y;
h = plot(xunit, yunit,'LineWidth',1,'Color',"black");
axis("equal");
end