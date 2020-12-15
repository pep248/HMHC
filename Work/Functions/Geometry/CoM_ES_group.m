
%We use the equations of pg 128
function CoM=CoM_ES_group(segment)
a1=segment.a1;
b1=segment.b1;
a0=segment.a0;
b0=segment.b0;
L=segment.L;

CoM=[0;0;L*A_ab2(a0,a1,b0,b1)/A_ab1(a0,a1,b0,b1)];
end