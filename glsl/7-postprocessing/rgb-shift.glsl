#iChannel0"https://s2.loli.net/2023/09/10/63quVIA9xZLksDc.jpg"

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
    vec2 rUv=uv;
    vec2 gUv=uv;
    vec2 bUv=uv;
    // float offset=.0025;
    float noise=random(uv)*.5+.5;
    // float noise=random(uv+iTime)*.5+.5;
    vec2 offset=.0025*vec2(cos(noise),sin(noise));
    rUv+=offset;
    bUv-=offset;
    // vec3 tex=texture(iChannel0,uv).xyz;
    vec4 rTex=texture(iChannel0,rUv);
    vec4 gTex=texture(iChannel0,gUv);
    vec4 bTex=texture(iChannel0,bUv);
    vec4 col=vec4(rTex.r,gTex.g,bTex.b,gTex.a);
    fragColor=col;
}
