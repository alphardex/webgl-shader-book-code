#iChannel0"https://s2.loli.net/2023/09/10/QozT59R6KsYmb3q.jpg"

void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    vec3 tex=texture(iChannel0,uv).xyz;
    
    vec3 col=tex;
    vec3 tintColor=vec3(.220,.380,.651);
    col*=tintColor;
    fragColor=vec4(col,1.);
}
