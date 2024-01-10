# Hardware Acceleration in Termux

I would like to include here all the info I got while I'm still researching the topic. 

## 1. Install packages
You need to install the following packages in Termux: 
```
pkg install mesa-zink virglrenderer-mesa-zink vulkan-loader-android
```

## 2. Initialize VIRGL server in Termux: 
Before login to proot and use hardware acceleration you need to start the virgl server: 

* If you have a Snapdragon CPU:
```
MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT MESA_GLES_VERSION_OVERRIDE=3.2 GALLIUM_DRIVER=zink ZINK_DESCRIPTORS=lazy virgl_test_server --use-egl-surfaceless --use-gles &
```
* If not:
```
virgl_test_server_android &
```

## 3. In proot distro 
Run the Desktop with my script (if you do manually take in to account that you need to share the tmp dir to make it work): 
```
./startxfce4_debian.sh
```

Once in the Desktop when you want to run a program with hardware acceleration use this before: 
```
GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 program
```
For example: 
```
GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 glmark2
```

# Performance results 
| Software| No Hardware Acceleration | H.A. using VIRGL | H.A. using ZINK (Snapdragon) |
| --- | --- | --- | --- |
| GLMAKR2 | No Hardware Acceleration | H.A. using VIRGL | H.A. using ZINK (Snapdragon) |


* GLMARK2 tested during 30 seconds with the following command
```
glmark2
```