float sdBox(in vec2 p,in vec2 b)
{
    vec2 d=abs(p)-b;
    return length(max(d,0.))+min(max(d.x,d.y),0.);
}

float sdEquilateralTriangle(in vec2 p,in float r)
{
    const float k=sqrt(3.);
    p.x=abs(p.x)-r;
    p.y=p.y+r/k;
    if(p.x+k*p.y>0.)p=vec2(p.x-k*p.y,-k*p.x-p.y)/2.;
    p.x-=clamp(p.x,-2.*r,0.);
    return-length(p)*sign(p.y);
}

mat2 rotation2d(float angle){
    float s=sin(angle);
    float c=cos(angle);
    
    return mat2(
        c,-s,
        s,c
    );
}

vec2 rotate(vec2 v,float angle){
    return rotation2d(angle)*v;
}

const float PI=3.14159265359;

void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    
    // repeat
    // uv=fract(uv*vec2(2.,2.));
    
    // center
    uv=(uv-.5)*2.;
    uv.x*=iResolution.x/iResolution.y;
    
    // translate
    // uv-=vec2(.2,.4);
    
    // mirror
    uv.y=abs(uv.y);
    
    // scale
    // uv/=vec2(2.,2.);
    
    // flip
    // uv.y*=-1.;
    
    // rotate
    // uv=rotate(uv,PI/2.);
    // uv=rotate(uv,iTime);
    
    // float d=sdBox(uv,vec2(.6,.3));
    float d=sdEquilateralTriangle(uv,.5);
    float c=smoothstep(0.,.02,d);
    fragColor=vec4(vec3(c),1.);
    // fragColor=vec4(uv,0.,1.);
}
