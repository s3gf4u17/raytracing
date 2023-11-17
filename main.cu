#include <stdio.h>

__global__ void color(float *cudapixels,int w,int h) {
    for (int y=0;y<h;y++) {for (int x=0;x<w;x++) {
        cudapixels[(y*w+x)*3] = 255 * ((float)x/(w-1));
        cudapixels[(y*w+x)*3+1] = 255 * ((float)y/(h-1));
        cudapixels[(y*w+x)*3+2] = 255 * 0.2;
    }}
}

int main() {
    int image_width = 256;
    int image_height = 256;
    float *cpppixels,*cudapixels;
    cpppixels = (float*)malloc(sizeof(float)*image_width*image_height*3);
    cudaMalloc((void**)&cudapixels,sizeof(float)*image_width*image_height*3);
    color<<<1,1>>>(cudapixels,image_width,image_height);
    cudaDeviceSynchronize();
    cudaMemcpy(cpppixels,cudapixels,sizeof(float)*image_width*image_height*3,cudaMemcpyDeviceToHost);
    cudaFree(cudapixels);

    printf("P3\n%d %d\n255\n",image_width,image_height);
    for (int i=0;i<image_width*image_height;i++) {
        printf("%d %d %d\n",(int)cpppixels[3*i],(int)cpppixels[3*i+1],(int)cpppixels[3*i+2]);
    }
    free(cpppixels);
    return 0;
}
