screwPitch = 1.7;
head_v = 1;
uu = zeros(1,224);
vv = zeros(1,224);
t = 75;
% 获取两个圆的解析值
[x1,y1,x2,y2,rad,r,rmin,alpha0,beta0] = getSolution();
Points = [x1,y1,x2,y2];

% 画图
pitch = screwPitch/(2*pi);
theta0 = (4.5/pitch):0.01*pi:16*pi;
%     theta0 = 0:0.01*pi:16*pi;
r1 = pitch * theta0;
% polarplot(theta0,r1,'b');
[x,y] = pol2cart(theta0,r1);
plot(x,y);hold on;
[x,y] = pol2cart(theta0,-r1);
plot(x,y);hold on;

beta = 0:0.05*pi:2*pi;
x = cos(beta)*4.5;
y = sin(beta)*4.5;
plot(x, y);hold on;
x1=-0.760009116655535;
y1=-1.305726426346251;
x4=1.735932490181097;
y4=2.448401974553662;
r = 1.502708833894518;
alpha=16.571908201435512-5*pi;
plot([x1,x4],[y1,y4],'o');hold on;
beta = alpha:0.01*pi:(alpha+pi);
x = x1+cos(beta)*2*r;
y = y1+sin(beta)*2*r;
plot(x, y);hold on;
beta = (alpha-pi):0.01*pi:alpha;
x = x4+cos(beta)*r;
y = y4+sin(beta)*r;
plot(x, y);hold on;


[head_theta, state] = getThetaByT(t,head_v,screwPitch,rad,r,rmin);
[x0,y0] = getXY(head_theta, state, screwPitch, Points,r,alpha0);
% 获取整条队伍的信息
[X,Y,THETA,STATE] = getBodyLocation(head_theta, state, screwPitch,Points,r,alpha0,rad,rmin);

d = 0.1;
for i = 1:224
    angle = getDirectionByTheta(THETA(i),STATE(i),alpha0,rad);
    uu(i) = d*cos(angle);
    vv(i) = d*sin(angle);
end

% 画图
plot(X,Y,'.');hold on;
quiver(X,Y,uu,vv,0.7);
axis equal
