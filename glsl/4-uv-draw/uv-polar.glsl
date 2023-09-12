vec2 cart2polar(vec2 uv){
    float phi=atan(uv.y,uv.x);
    float r=length(uv);
    return vec2(phi,r);
}

void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    uv=(uv-.5)*2.;
    uv.x*=iResolution.x/iResolution.y;
    
    // float phi=atan(uv.y,uv.x);
    // float r=length(uv);
    // uv=vec2(phi,r);
    uv=cart2polar(uv);
    
    // uv
    // fragColor=vec4(uv,0.,1.);
    
    // radial
    // float c=sin(uv.x*12.);
    // fragColor=vec4(vec3(c),1.);
    
    // spiral
    float c=sin(uv.y*20.+uv.x);
    fragColor=vec4(vec3(c),1.);
}
