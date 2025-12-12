clear all;
close all;
clc;

mdl_puma560

p560.teach
qn

T = p560.fkine(qn);
q1 = p560.ikine6s(T, 'luf');
q2 = p560.ikine6s(T, 'ldf');
q5 = p560.ikine6s(T, 'ruf');
q6 = p560.ikine6s(T, 'rdf');

p560.plot(q1)
p560.plot(q5)
p560.plot(q2)
p560.plot(q6)



