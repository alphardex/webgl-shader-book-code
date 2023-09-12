#iChannel0"https://s2.loli.net/2023/09/10/QozT59R6KsYmb3q.jpg"

void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    vec3 tex=texture(iChannel0,uv).xyz;
    
    // vec3 col=vec3(1.);
    vec3 col=tex;
    vec2 p=uv;
    p-=.5;
    float d=length(p);
    // col=vec3(d);
    // float c=smoothstep(.4,.8,d);
    // float c=1.-smoothstep(.4,.8,d);
    float c=smoothstep(.8,.4,d);
    // col=vec3(c);
    col*=c;
    
    fragColor=vec4(col,1.);
}
