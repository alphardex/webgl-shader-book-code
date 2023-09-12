float sdCircle(vec2 p,float r)
{
    return length(p)-r;
}

float sdBox(in vec2 p,in vec2 b)
{
    vec2 d=abs(p)-b;
    return length(max(d,0.))+min(max(d.x,d.y),0.);
}

float opRound(in float d,in float r)
{
    return d-r;
}

float opOnion(in float d,in float r)
{
    return abs(d)-r;
}

void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    uv=(uv-.5)*2.;
    uv.x*=iResolution.x/iResolution.y;
    
    // float d=sdCircle(uv,.5);
    float d=sdBox(uv,vec2(.6,.3));
    
    // round
    // d=opRound(d,.1);
    
    // onion
    d=opOnion(d,.1);
    
    float c=smoothstep(0.,.02,d);
    fragColor=vec4(vec3(c),1.);
}
