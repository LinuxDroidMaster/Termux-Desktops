# Hardware Acceleration in Termux
> [!NOTE]  
> I would like to include here all the information I got while I am still researching the subject as the world of hardware acceleration is huge.. If you find any errors  or misconceptions, please comment on Youtube, Telegram or open an issue on this Github

🔥[[Video] Hardware Acceleration Part 1 - What it is, how it is used (VIRGL AND ZINK)](https://www.youtube.com/watch?v=fgGOizUDQpY)   
🔥[[Video] Hardware Acceleration Part 2 - (VIRGL, ZINK, TURNIP) - how can you use them - Coming up soon....]()

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
Run the Desktop with my script (if you do manually instead of using my script, take in to account that you need to share the tmp dir to make it work): 
```
./startxfce4_debian.sh
```

Once in the Desktop when you want to run a program with hardware acceleration use this before: 

* For VIRGL and ZINK (depending on the graphic server you started in Termux it will use ZINK or VIRGL): 
```
GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 program
```
* For TURNIP: 
```
MESA_LOADER_DRIVER_OVERRIDE=zink TU_DEBUG=noconform program
```

# Performance results 
> [!IMPORTANT]  
> All this tests were done in a proot distro environment with Debian and a XFCE4 desktop.

Device used: Lenovo Legion Y700 2022 model (Snapdragon 870 - Adreno 650)

<table>
  <thead>
    <tr>
      <th scope="col" colspan="5">DEBIAN PROOT (GLMARK2 SCORE - the higher the number the better the performance)</th>
    </tr>
    <tr>
        <th scope="col">RUN</th>
        <th scope="col">LLVMPIPE</th>
        <th scope="col">VIRGL</th>
        <th scope="col">ZINK</th>
        <th scope="col">TURNIP</th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>1</td>
      <td>93</td>
      <td>70</td>
      <td>66</td>
      <td>198</td>
    </tr>
    <tr>
      <td>2</td>
      <td>93</td>
      <td>77</td>
      <td>66</td>
      <td>198</td>
    </tr>
    <tr>
      <td>3</td>
      <td>72</td>
      <td>70</td>
      <td>71</td>
      <td>198</td>
    </tr>
    <tr>
      <td>4</td>
      <td>94</td>
      <td>76</td>
      <td>66</td>
      <td>197</td>
    </tr>
    <tr>
      <td>5</td>
      <td>93</td>
      <td>75</td>
      <td>67</td>
      <td>198</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <th scope="row">Initialize server</th>
      <td>Not needed</td>
      <td>virgl_test_server_android &</td>
      <td>MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT MESA_GLES_VERSION_OVERRIDE=3.2 GALLIUM_DRIVER=zink ZINK_DESCRIPTORS=lazy virgl_test_server --use-egl-surfaceless --use-gles &</td>
      <td>Not needed</td>
    </tr>
    <tr>
      <th scope="row">Command used</th>
      <td>glmkar2</td>
      <td>GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 glmark2</td>
      <td>GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 glmark2</td>
      <td>MESA_LOADER_DRIVER_OVERRIDE=zink TU_DEBUG=noconform glmark2</td>
    </tr>
    <tr>
      <th scope="row">GLMARK GPU Info</th>
      <td>llvmpipe</td>
      <td>virgl (Adreno)</td>
      <td>virgl(zink Adreno)</td>
      <td>virgl (Turnip Adreno)</td>
    </tr>
  </tfoot>
</table>

---
Other tests I did: 

* SuperTuxKart tested during 30 seconds
![SUPERTUXKART comparison](./images/supertuxkart_comparison.png)

---
* [Firefox Aquarium WebGL Benchmark](https://webglsamples.org/aquarium/aquarium.html) tested during 30 seconds with the following commands (runned 1 time in a 1024x1024 canvas).
  
> [!NOTE]  
> You need to [enable WebGL in Firefox](https://help.interplaylearning.com/en/help/how-to-enable-webgl-in-firefox) to use the GPU

> [!WARNING]  
> I need to redo the Aquarium tests, right now the results are not reliable.

```
firefox-esr
GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 firefox-esr
```
![WEB GL Aquarium on Firefox](./images/webglaquarium.png)
