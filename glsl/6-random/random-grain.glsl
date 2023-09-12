#iChannel0"https://s2.loli.net/2023/09/10/QozT59R6KsYmb3q.jpg"

highp float random(vec2 co)
{
    highp float a=12.9898;
    highp float b=78.233;
    highp float c=43758.5453;
    highp float dt=dot(co.xy,vec2(a,b));
    highp float sn=mod(dt,3.14);
    return fract(sin(sn)*c);
}

void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    
    float noise=random(uv);
    // float noise=random(uv+iTime);
    
    vec3 col=texture(iChannel0,uv).xyz;
    col+=(noise-.5)*.2;
    fragColor=vec4(col,1.);
}
