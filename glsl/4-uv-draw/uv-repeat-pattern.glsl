float sdCircle(vec2 p,float r)
{
    return length(p)-r;
}

float opUnion(float d1,float d2)
{
    return min(d1,d2);
}

void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    
    // stripe
    // uv=fract(uv*16.);
    // vec3 c=vec3(step(.5,uv.x));
    
    // wave
    // uv.y+=sin(uv.x*6.)*.4;
    // uv=fract(uv*16.);
    // vec3 c=vec3(step(.5,uv.y));
    
    // grid
    // uv.x*=iResolution.x/iResolution.y;
    // uv=fract(uv*16.);
    // vec3 c=vec3(opUnion(step(.25,uv.x),step(.25,uv.y)));
    
    // ripple
    uv=(uv-.5)*2.;
    uv.x*=iResolution.x/iResolution.y;
    float d=sdCircle(uv,.5);
    d=sin(d*40.);
    float mask=smoothstep(0.,.02,d);
    vec3 c=vec3(mask);
    
    fragColor=vec4(c,1.);
}
