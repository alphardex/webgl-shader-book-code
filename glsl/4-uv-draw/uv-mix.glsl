float sdCircle(vec2 p,float r)
{
    return length(p)-r;
}

float sdBox(in vec2 p,in vec2 b)
{
    vec2 d=abs(p)-b;
    return length(max(d,0.))+min(max(d.x,d.y),0.);
}

void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    
    // gradient
    // vec3 col1=vec3(1.,0.,0.);
    // vec3 col2=vec3(0.,1.,0.);
    // vec3 col=mix(col1,col2,uv.x);
    // fragColor=vec4(col,1.);
    
    // tint shape
    // uv=(uv-.5)*2.;
    // uv.x*=iResolution.x/iResolution.y;
    
    // float d=sdBox(uv,vec2(.6,.3));
    // float c=smoothstep(0.,.02,d);
    // vec3 colInner=vec3(1.,0.,0.);
    // vec3 colOuter=vec3(1.);
    // vec3 col=mix(colInner,colOuter,c);
    // fragColor=vec4(col,1.);
    
    // shape transition
    uv=(uv-.5)*2.;
    uv.x*=iResolution.x/iResolution.y;
    
    float d1=sdCircle(uv,.5);
    float d2=sdBox(uv,vec2(.6,.3));
    float d=mix(d1,d2,abs(sin(iTime)));
    float c=smoothstep(0.,.02,d);
    fragColor=vec4(vec3(c),1.);
}
