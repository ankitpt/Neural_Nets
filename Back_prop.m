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

layer=[2,50,1];



wlen=size(layer,2)-1;
epochs=10000;
lrn=.3;
wt=cell(1,size(layer,2)-1);
for k=1:wlen
    wt{k}=2.*rand(layer(k),layer(k+1))-1;
end


for n=1:epochs
    j=randi(1000);
    pt=cell(1,size(layer,2));
    pt{1}=p(:,j);
    delt=cell(1,size(layer,2)-1);
    for k=1:wlen
        h=(wt{k})'*pt{k};
        pt{k+1}=3*(1.0./(1.0+exp(-h)))-1.5;
        
    
    end
    %y2(n)=pt{k};
    y=pt{end};
    error(n)=t(j)-pt{end};
    delt{end}=(t(j)-pt{end}).*(y+1.5).*(1-(y+1.5)./3);
    %delt{1}
    for k=wlen-1:1
        delt{k}= (wt{k+1}*delt{k+1}).*(1-(pt{k+1}+1.5)./3).*(pt{k+1}+1.5) ;
    end
    
    for k=1:wlen
    wt{k}=wt{k}+lrn*pt{k}*(delt{k})';
    end
    
    if mod(n,10000) == 0
        display('epochs:');
        display(n);
        %display(delt{end});
    %display(v(1));
    end
    
end

d(1)=.5;
for k=1:1000
    
    u(k)=2*rand-1;
    d(k+1)=d(k)/(1+d(k)*d(k))+u(k)*u(k)*u(k);
    %p(1,k)=1;
    p(1,k)=u(k);
    p(2,k)=d(k);
    t(k)=d(k+1);
end

for n=1:1000
    
    pt=cell(1,size(layer,2));
    pt{1}=p(:,n);
    
    for k=1:wlen
        h=(wt{k})'*pt{k};
        pt{k+1}=3*(1.0./(1.0+exp(-h)))-1.5;
        
    
    end
    y2(n)=pt{k+1};
end
msq=sqrt(sum((t-y2).*(t-y2))/1000);
plot(u, t, 'go',u, y2, 'bo')
%plot(t-y2,'bo');
%figure plot(t) hold on plot(y,'r') ;