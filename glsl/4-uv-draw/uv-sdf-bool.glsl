float sdCircle(vec2 p,float r)
{
    return length(p)-r;
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

float opSmoothUnion(float d1,float d2,float k){
    float h=clamp(.5+.5*(d2-d1)/k,0.,1.);
    return mix(d2,d1,h)-k*h*(1.-h);
}

float opSmoothSubtraction(float d1,float d2,float k){
    float h=clamp(.5-.5*(d2+d1)/k,0.,1.);
    return mix(d2,-d1,h)+k*h*(1.-h);
}

float opSmoothIntersection(float d1,float d2,float k){
    float h=clamp(.5-.5*(d2-d1)/k,0.,1.);
    return mix(d2,d1,h)+k*h*(1.-h);
}

void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    uv=(uv-.5)*2.;
    uv.x*=iResolution.x/iResolution.y;
    
    float d1=sdCircle(uv,.5);
    float d2=sdBox(uv,vec2(.6,.3));
    
    float d=d1;
    
    // union
    // d=opUnion(d1,d2);
    
    // intersection
    // d=opIntersection(d1,d2);
    
    // subtraction
    // box - circle
    // d=opSubtraction(d1,d2);
    // circle - box
    // d=opSubtraction(d2,d1);
    
    // smooth union
    // d=opSmoothUnion(d1,d2,.1);
    
    // smooth intersection
    // d=opSmoothIntersection(d1,d2,.1);
    
    // smooth subtraction
    // box - circle
    // d=opSmoothSubtraction(d1,d2,.1);
    // circle - box
    d=opSmoothSubtraction(d2,d1,.1);
    
    float c=smoothstep(0.,.02,d);
    fragColor=vec4(vec3(c),1.);
}
