function [] = plotSet(x,t,w)

hold on

plot(x(find(t==1),1),x(find(t==1),2),'b+');
plot(x(find(t==-1),1),x(find(t==-1),2),'ro');

x1 = -1:1:1;
x2 = - (w(3) + x1 * w(1)) / w(2);
plot(x1,x2,'g');
    
hold off

end
