// https://github.com/MaxBittker/glsl-voronoi-noise/blob/master/2d.glsl
const mat2 myt=mat2(.12121212,.13131313,-.13131313,.12121212);
const vec2 mys=vec2(1e4,1e6);

vec2 rhash(vec2 uv){
    uv*=myt;
    uv*=mys;
    return fract(fract(uv/mys)*uv);
}

vec3 hash(vec3 p){
    return fract(sin(vec3(dot(p,vec3(1.,57.,113.)),
    dot(p,vec3(57.,113.,1.)),
    dot(p,vec3(113.,1.,57.))))*
43758.5453);
}

float voronoi2d(const in vec2 point){
vec2 p=floor(point);
vec2 f=fract(point);
float res=0.;
for(int j=-1;j<=1;j++){
    for(int i=-1;i<=1;i++){
        vec2 b=vec2(i,j);
        vec2 r=vec2(b)-f+rhash(p+b);
        res+=1./pow(dot(r,r),8.);
    }
}
return pow(1./res,.0625);
}

vec2 cart2polar(vec2 uv){
float phi=atan(uv.y,uv.x);
float r=length(uv);
return vec2(phi,r);
}

void mainImage(out vec4 fragColor,in vec2 fragCoord){
vec2 uv=fragCoord/iResolution.xy;

vec2 p=uv;
p.x*=iResolution.x/iResolution.y;

uv=(uv-.5)*2.;
uv.x*=iResolution.x/iResolution.y;

vec3 col=vec3(0.);
// float noise=voronoi2d(uv*3.);
// col=vec3(noise);

uv.y-=2.;
uv/=50.;
uv=cart2polar(uv);
col=vec3(uv.x);

float n1=voronoi2d((vec2(uv.x,0.)+.04*iTime)*10.);
col=vec3(n1);
float n2=voronoi2d((vec2(.1,uv.x)+.04*iTime*1.5)*10.);
col=vec3(n2);
float n3=min(n1,n2);
col=vec3(n3);

// col=vec3(1.);
float mask=smoothstep(.15,.86,p.y);
float alpha=n3*mask*.8;

col=mix(vec3(0.,.412,.580),vec3(1.),alpha);

fragColor=vec4(col,1.);
}