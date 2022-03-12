#define ITERATIONS 500.
#define ZOOM 200.

vec2 pow_complex(vec2 pos) {
    return vec2(
     (pos.x * pos.x) - (pos.y * pos.y),
     (2.0 * pos.x * pos.y)
    );
}

float mandelbrot(vec2 pos) {
    float dist = 1.0, iter = 0.0;
    vec2 iterated_pos = pos;
    
    do {
        iterated_pos = pow_complex(iterated_pos) + pos;
        dist = distance(iterated_pos, vec2(0., 0.));
        iter+=1.0;
    
    } while(dist <= 2.0 && iter < ITERATIONS);
    
    return iter / ITERATIONS;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float inv_zoom = 1.0/ZOOM * sin(iTime);
    vec2 uv = (fragCoord / iResolution.xy) * inv_zoom - vec2(0.6 * inv_zoom, 0.5 * inv_zoom);

    vec2 bias = (iMouse.xy * 0.5 / iResolution.xy);
    uv += bias;

    fragColor = vec4(vec3(mandelbrot(uv)), 1.0);
}
