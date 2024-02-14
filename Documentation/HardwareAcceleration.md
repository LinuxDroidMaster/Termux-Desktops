# Hardware Acceleration in Termux
> [!WARNING]  
> Work In Progress. I would like to include here all the info I got while I'm still researching the topic. If you find any errors  or misconceptions, please comment on Youtube, Telegram or open an issue on this Github

[Video where I explain hardware acceleration 😊](https://www.youtube.com/watch?v=fgGOizUDQpY)

## 1. Install packages
You need to install the following packages in Termux: 
```
pkg install mesa-zink virglrenderer-mesa-zink vulkan-loader-android virglrenderer-android
```

## 2. Initialize graphical server in Termux: 
Before login to proot and use hardware acceleration you need to start the graphical server: 

* Vulkan (ZINK):
```
MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT MESA_GLES_VERSION_OVERRIDE=3.2 GALLIUM_DRIVER=zink ZINK_DESCRIPTORS=lazy virgl_test_server --use-egl-surfaceless --use-gles &
```
* OpenGL (VIRGL):
```
virgl_test_server_android &
```
* [Turnip (Adreno GPU 6XX/7XX compatible only)](https://www.reddit.com/r/termux/comments/19dpqas/proot_linux_only_dri3_patch_mesa_turnip_driver/)
It is not needed to initialize any graphical server. Follow the steps described in the reddit post. As as summary:

  1. Download Turnip Driver: [mesa-vulkan-kgsl_23.3.0-devel-20230905_arm64.deb](https://drive.google.com/file/d/1f4pLvjDFcBPhViXGIFoRE3Xc8HWoiqG-/view?usp=drive_link)
  2. Install it in proot-distro (for example in Debian the command is as follows)
```
sudo dpkg -i mesa-vulkan-kgsl_23.3.0-devel-20230905_arm64.deb
```
  In case you want to remove the driver: 
```
sudo dpkg -r mesa-vulkan-drivers:arm64
```


## 3. In proot distro 
Run the Desktop with my script (if you do manually take in to account that you need to share the tmp dir to make it work): 
```
./startxfce4_debian.sh
```

Once in the Desktop when you want to run a program with hardware acceleration use this before: 
For VIRGL and ZINK: 
```
GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 program
```
For TURNIP: 
```
MESA_LOADER_DRIVER_OVERRIDE=zink TU_DEBUG=noconform program
```

# Performance results 
> [!WARNING]  
> I need to redo all the tests, right now the results are not reliable.

> [!IMPORTANT]  
> All this tests were done in a proot distro environment with Debian and a XFCE4 desktop and in Termux with a XFCE4 desktop. In brackets I put the % of improvement compared to the worst case scenario.

Device used: Lenovo Legion Y700 2022 model (Snapdragon 870 - Adreno 650)

| Software | No Hardware Acceleration | H.A. using VIRGL in proot | H.A. using ZINK in proot | H.A. using ZINK in Termux |
| --- | --- | --- | --- | --- |
| GLMAKR2 (points) | 167 (125.67%) | 90 (21.62%) | 74 (0%)| 180 (143%)|
| GLXGEARS (average fps) | 406 (178.08%) | 223 (52.73%) | 146 (0%) | 324 (121%) |
| SUPERTUXKART (average fps aprox.) | 5 (0%) | Seg Fault Error (crash) | 30 (500%) | Couldn't test |
| Firefox Aquarium Benchmark | 4 (0%) | 22 (450%) | 17 (325%)  | 37 (825%) |

Conclusions: I would like to do more tests but it seems that within proot-distro the hardware acceleration is weaker although in the case of a 3D game like supertuxkart it helps a lot.

* GLMARK2 tested during 30 seconds with the following commands (run 2 times)
```
glmark2
GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 glmark2
```
![GLMARK2 comparison](./images/glmark2_comparison.png)

* GLXGEARS tested during 30 seconds with the following commands (run 1 time and waited for 6 output messages)
```
glxgears
GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 glxgears
```
* SuperTuxKart tested during 30 seconds with the following commands (run 1 time)
```
glxgears
GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 glxgears
```
![SUPERTUXKART comparison](./images/supertuxkart_comparison.png)

* [Firefox Aquarium WebGL Benchmark](https://webglsamples.org/aquarium/aquarium.html) tested during 30 seconds with the following commands (runned 1 time in a 1024x1024 canvas).
> [!NOTE]  
> You need to [enable WebGL in Firefox](https://help.interplaylearning.com/en/help/how-to-enable-webgl-in-firefox) to use the GPU
  
```
firefox-esr
GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 firefox-esr
```
![WEB GL Aquarium on Firefox](./images/webglaquarium.png)
