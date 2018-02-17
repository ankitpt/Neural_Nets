clear   
d(1)=0.5;
%         X=[1,0,0;1,0,1;1,1,0;1,1,1];
%         X=X';
%         t=[0,1,1,0];
for k=1:1000
    
    u(k)=2*rand-1;
    d(k+1)=d(k)/(1+d(k)*d(k))+u(k)*u(k)*u(k);
    
    p(1,k)=u(k);
    p(2,k)=d(k);
    t(k)=d(k+1);
end

rbf=[100 1];

wt=2*rand(rbf(1),rbf(2))-1;
h=rbf(1);
epochs=10000;
lrn1=.3;
lrn2=.3;

c = datasample(p,100,2);
d=max(pdist(c'));
sig=d/sqrt(2*rbf(1));

for n=1:epochs
    j=randi(1000);
    x=p(:,j);
    
    for k=1:h
        dis=norm(x-c(:,k));
        dis=dis*dis;
        phi(k)=exp(-dis/(2.0*sig*sig));
    end
   
    y=phi*wt;
    err=t(j)-y;
    
    
    
    for i=1:h
        c(:,i)=c(:,i)+(lrn2*err*wt(i)*phi(i)*(x-c(:,i)))/(sig*sig);
    end
    
    wt=wt+lrn1*err*phi';
end

for n=1:1000
    x=p(:,n);

 for k=1:h
        dis=norm(x-c(:,k));
        dis=dis*dis;
        phi(k)=exp(-dis/(2.0*sig*sig));
    end
   
    y2(n)=phi*wt;
end

plot(u, t, 'go',u, y2, 'bo')


    
    
    
    