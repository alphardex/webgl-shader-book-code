#iChannel0"https://s2.loli.net/2023/03/20/5jmPqdJW7EL2a4X.jpg"
#iChannel1"https://s2.loli.net/2023/03/20/AgKHd6cZkUE9rGO.jpg"

vec4 getFromColor(vec2 uv){
    return texture(iChannel0,uv);
}

vec4 getToColor(vec2 uv){
    return texture(iChannel1,uv);
}

const float PI=3.14159265359;

// rotate
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

float sdBox(in vec2 p,in vec2 b)
{
    vec2 d=abs(p)-b;
    return length(max(d,0.))+min(max(d.x,d.y),0.);
}

float opUnion(float d1,float d2)
{
    return min(d1,d2);
}

float opIntersection(float d1,float d2)
{
    return max(d1,d2);
}

float opSubtraction(float d1,float d2)
{
    return max(-d1,d2);
}

vec4 transition(vec2 uv){
    float progress=iMouse.x/iResolution.x;
    
    float ratio=iResolution.x/iResolution.y;
    
    // SDF mask
    vec2 grid=vec2(4.,4.);
    
    float pr=-2.*pow((2.*progress-1.),2.)+1.;
    float offset=mix(0.,-.25,pr);
    
    // float angle=PI*.25/3.;
    float angle=mix(0.,PI*.5,progress);
    vec2 p1=uv;
    p1=fract(p1*grid);
    p1-=vec2(.5);
    p1=rotate(p1,angle);
    float d1=sdBox(p1,vec2(.5+offset,.75));
    
    vec2 p2=uv;
    p2=fract(p2*grid);
    p2-=vec2(.5);
    p2=rotate(p2,angle+PI*.5);
    float d2=sdBox(p2,vec2(.5+offset,.75));
    
    float d=opIntersection(d1,d2);
    
    float mask=1.-smoothstep(0.,.02,d);
    
    return mix(
        getFromColor(uv)*mask,
        getToColor(uv)*mask,
        progress
    );
}

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=fragCoord/iResolution.xy;
    
    vec4 col=transition(uv);
    
    fragColor=col;
}
