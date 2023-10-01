#include <iostream>
#include "utilities.h"
#include "camera.h"
#include "color.h"
#include "hittable_list.h"
#include "sphere.h"
#include "material.h"

int main() {
    // world
    hittable_list world;
    auto material_lambertian1 = make_shared<lambertian>(color(0.8, 0.8, 0.0));
    auto material_lambertian2 = make_shared<lambertian>(color(0.1, 0.2, 0.5));
    auto material_dielectric = make_shared<dielectric>(1.5);
    auto material_metal = make_shared<metal>(color(0.8, 0.6, 0.2),0.1);
    world.add(make_shared<sphere>(point3(-1,0,-1),0.5,material_dielectric));
    world.add(make_shared<sphere>(point3(1,0,-1),0.5,material_metal));
    world.add(make_shared<sphere>(point3(0,0,-1),0.5,material_lambertian2));
    world.add(make_shared<sphere>(point3(0,-100.5,-1),100,material_lambertian1));
    // camera
    camera cam;
    cam.aspect_ratio = 16.0/9.0;
    cam.image_width = 400;
    cam.samples_per_pixel = 100;
    cam.max_depth = 50;
    cam.render(world);
    return 0;
}