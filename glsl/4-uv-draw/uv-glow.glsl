void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    uv=(uv-.5)*2.;
    uv.x*=iResolution.x/iResolution.y;
    
    float d=length(uv);
    // d-=.5;
    // float c=step(0.,d);
    // float c=smoothstep(0.,.02,d);
    float c=.25/d;
    c=pow(c,1.6);
    fragColor=vec4(vec3(c),1.);
}
