#iChannel0"https://s2.loli.net/2023/09/10/QozT59R6KsYmb3q.jpg"

void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    
    // uv
    // float c=uv.x;
    // c=floor(c*10.)/10.;
    // fragColor=vec4(vec3(c),1.);
    
    // pixelate
    vec2 size=vec2(50.,50.);
    // uv.x=floor(uv.x*size.x)/size.x;
    // uv.y=floor(uv.y*size.y)/size.y;
    uv=floor(uv*size)/size;
    vec3 tex=texture(iChannel0,uv).xyz;
    fragColor=vec4(tex,1.);
}
