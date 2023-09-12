#iChannel0"https://s2.loli.net/2023/03/20/5jmPqdJW7EL2a4X.jpg"
#iChannel1"https://s2.loli.net/2023/03/20/AgKHd6cZkUE9rGO.jpg"

vec4 getFromColor(vec2 uv){
    return texture(iChannel0,uv);
}

vec4 getToColor(vec2 uv){
    return texture(iChannel1,uv);
}

float random(vec2 uv)
{
    return fract(sin(dot(uv,vec2(12.9898,78.233)))*43758.5453);
}

vec4 transition(vec2 uv){
    float progress=iMouse.x/iResolution.x;
    
    float ratio=iResolution.x/iResolution.y;
    
    vec2 p=uv;
    p.x*=ratio;
    
    float d=random(floor(p*vec2(20.,20.)));
    
    float s=.5;
    
    return mix(
        getFromColor(uv),
        getToColor(uv),
        smoothstep(0.,-s,d-progress*(1.+s))
    );
}

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=fragCoord/iResolution.xy;
    
    vec4 col=transition(uv);
    
    fragColor=col;
}
