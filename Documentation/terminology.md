* Make sure to check out the hyperlinks if you'd like to learn more.
TODO: Add the clarification image

# Environments

### [Chroot](https://www.youtube.com/watch?v=2wSJREC7RV8)
A directory jail that allows you to run programs within an isolated file system structure. It's like a mini-Linux system within your existing system. It accesses the host's resources through bind mounting. (Requires root)

### [Proot](https://sdrausty.github.io/TermuxPRoot/docs/PRoot.html)
A user-space implementation of chroot that allows you to run programs as if they were in a different root directory through intercepting system calls (doesn't require root).

### [Native Termux](https://en.wikipedia.org/wiki/Termux)
Refers to running Termux directly on an Android device without using a chroot or proot.

# Libraries

### [Glibc](https://en.wikipedia.org/wiki/Glibc)
The GNU C Library, a standard C library used by many Linux distributions. (A proot/chroot uses the glibc library)

### [Bionic](https://en.wikipedia.org/wiki/Bionic_(software))
The C library (designed by Google) used in Android, differing from glibc.

These differences explain why binaries built for Linux (eg, arm64 SuperTuxKart) cannot run on Android within Termux without compiling from source for Bionic specifically. 

[Read here how](https://github.com/termux/termux-packages/wiki/Build-environment#structure) 

[Patched SuperTuxKart example](https://github.com/termux-user-repository/tur/tree/master/tur/supertuxkart)

(UNLESS you use a [glibc-runner from glibc-repo within native Termux](https://github.com/termux-pacman/glibc-packages/wiki/About-glibc-runner-(grun)) or a [proot/chroot] which would allow you to run glibc packages without patching for bionic)

# Graphic APIs

### [OpenGL](https://en.wikipedia.org/wiki/OpenGL)
A high-level API for rendering 2D and 3D graphics.
- Primarily used on desktops (PCs/laptops) and workstation systems.

### [OpenGL ES](https://en.wikipedia.org/wiki/OpenGL_ES)
Used on mobile and embedded devices.

### [Vulkan](https://en.wikipedia.org/wiki/Vulkan)
A newer, more efficient low-level API for graphics and compute, providing more explicit control over the GPU.

### [DirectX](https://en.wikipedia.org/wiki/DirectX)
A graphics API developed by Microsoft for use in Windows and Xbox consoles only.
- [**Direct3D**](https://en.wikipedia.org/wiki/Direct3D): A component of the DirectX suite that's responsible for 3D graphics
- [**dxvk (DirectX to Vulkan)**](https://github.com/doitsujin/dxvk?tab=readme-ov-file#dxvk): A translation layer which translates DirectX calls to Vulkan calls allowing you to run DirectX applications using Vulkan.

# GPUs

# [Adreno GPU](https://en.wikipedia.org/wiki/Adreno)
A family of GPUs developed by Qualcomm, found ONLY in Snapdragon CPUs.

### [Zink](https://docs.mesa3d.org/drivers/zink.html)
A Gallium driver that allows OpenGL applications to run on top of Vulkan drivers (in this case, the "Vulkan driver" is Turnip). [By Mesa](https://docs.mesa3d.org/index.html)

### [Freedreno](https://docs.mesa3d.org/drivers/freedreno.html)
An open-source OpenGL GPU driver for Qualcomm Adreno GPUs (comparable to the Nouveau driver for NVIDIA GPUs). [By Mesa](https://docs.mesa3d.org/index.html)
Freedreno runs directly on OpenGL(Unlike zink, which translates OpenGL to Vulkan)

### [Turnip](https://docs.mesa3d.org/drivers/freedreno.html#turnip)
An open-source Vulkan driver for Qualcomm Adreno GPUs. (Turnip is specifically a component of Freedreno that implements Vulkan) [By Mesa](https://docs.mesa3d.org/index.html)
- Turnip only works on Adreno 610 and above with some exceptions like 710, 642L etc. 
- **Zink + Turnip**: Zink forces OpenGL apps to use Vulkan drivers instead(Turnip being the Vulkan driver). This combination provides the BEST hardware acceleration currently possible. (Edit: The newly compiled freedreno beats zink in performance)


# [Mali GPU](https://en.wikipedia.org/wiki/Mali_(processor))
A family of GPUs developed by ARM Holdings, used in most CPUs (e.g., Exynos, everything else).
  
### [Panfrost](https://en.wikipedia.org/wiki/Mali_(processor)#The_Lima,_Panfrost_and_Panthor_FOSS_drivers)
An open-source GPU driver project for Mali Midgard and Bifrost GPUs.
- **Warning**: Some devices may have bad drivers provided by OEMs which affects compatibility and performance with tools like VirGL.
  - Pre- and post-Kopper compatibility might differ, performance hits might occur, requiring Mesa recompilation for fixes.
  - **WineD3D** may not work.
  - PanVK won't support Android anytime soon.

# [PowerVR GPU](https://en.wikipedia.org/wiki/PowerVR)
A family of GPUs by Imagination Technologies, less common.
- GL4ES and VirGL are the only options for running OpenGL applications on PowerVR GPUs.

# Rendering

### [LLVMpipe](https://docs.mesa3d.org/drivers/llvmpipe.html)
A software rasterizer that uses the CPU for rendering instead of the GPU, resulting in the worst performance since CPUs are not optimized for rendering tasks.

### [VirGL](https://docs.mesa3d.org/drivers/virgl.html)
(Vir)tual Open(GL): A renderer that works with most GPUs but generally offers worse performance and support compared to zink+turnip.

### GL4ES
A wrapper that translates desktop OpenGL calls to OpenGL ES calls.
- Should be faster than VirGL, [pojavlauncher](https://github.com/PojavLauncherTeam/PojavLauncherTeam.github.io/) uses a fork of it called [HolyGL4ES](https://github.com/ShirosakiMio/HolyGL4ES).
- Provides partial support for OpenGL 2.1 and 1.5. Generally faster than VirGL for translating OpenGL to OpenGL ES.

## WineD3D vs DXVK

### [WineD3D](https://en.wikipedia.org/wiki/Wine_(software)#Direct3D)
A translation layer within Wine that translates Direct3D to OpenGL API calls.

### [DXVK](https://en.wikipedia.org/wiki/DXVK)
A translation layer which translates Direct3D to Vulkan API calls.

# Benchmark/Games/Tools

### [glmark2](https://github.com/glmark2/glmark2)
**GL** mark2(OpenGL Benchmark 2), a benchmarking utility for OpenGL 2.0 and OpenGL ES 2.0

### [glxgears](https://linuxreviews.org/Glxgears)
A demo of GLX (DO NOT use this to benchmark as it was NOT designed for benchmarks, use glmark2 instead).

### [SuperTuxKart](https://supertuxkart.net/Main_Page)
Open source 3D kart racing game (similar to Mario Kart).

### [Wine](https://en.wikipedia.org/wiki/Wine_(software))
A compatibility layer that enables Windows applications to run on Linux/macOS, without needing a full Windows OS installation.

### [Box64/Box86](https://box86.org/)
Allows you to run x86 and x86_64 Linux binaries on ARM (Box86) or ARM64 (Box64) systems, allowing you to run applications compiled for different CPU architectures on ARM-based devices.
- **aarch64** = ARM64
- **armv7l/armv8** = ARM
- All modern phone CPUs use ARM64, most modern PC CPUs use x86_64.

# Other Notes
- Hardware acceleration in proot using VirGL might require recompiling Mesa versions to make both sides match.
- Termux's repo doesn't package Mesa 22.1.7 (last version before Kopper was introduced) with VirGL. Therefore, you need to recompile it yourself if you'd like Mesa pre-Kopper.
