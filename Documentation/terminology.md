# Environments

### Chroot
A directory jail that allows you to run programs within an isolated file system structure. It's like a mini-Linux system within your existing system. It accesses the host's resources through bind mounting.

### Proot
A user-space implementation of chroot that allows you to run programs as if they were in a different root directory through intercepting system calls (doesn't require root).

### Native Termux
Refers to running Termux directly on an Android device without using a chroot or proot.

# Libraries

### Glibc
The GNU C Library, a standard C library used by many Linux distributions. (A proot/chroot uses the glibc library)

### Bionic
The C library (designed by Google) used in Android, differing from glibc.

These differences explain why binaries built for Linux (eg, arm64 SuperTuxKart) cannot run on Android within Termux without compiling from source for Bionic specifically  
(UNLESS you use a [glibc-runner from glibc-repo within native Termux] or a [proot/chroot])

# Graphic APIs

### OpenGL
A high-level API for rendering 2D and 3D graphics.
- Primarily used on desktops (PCs/laptops) and workstation systems.

### OpenGL ES
Used on mobile and embedded devices.

### Vulkan
A newer, more efficient low-level API for graphics and compute, providing more explicit control over the GPU.

### DirectX
A graphics API developed by Microsoft for use in Windows and Xbox consoles only.
- **dxvk (DirectX to Vulkan)**: A translation layer which translates DirectX calls to Vulkan calls allowing you to run DirectX applications using Vulkan.

# GPUs

# Adreno GPU
A family of GPUs developed by Qualcomm, found ONLY in Snapdragon CPUs.

### Zink
A Gallium driver that allows OpenGL applications to run on top of Vulkan drivers (in this case, the "Vulkan driver" is Turnip).

### Freedreno
An open-source GPU driver for Qualcomm Adreno GPUs (comparable to the Nouveau driver for NVIDIA GPUs).

### Turnip
An open-source Vulkan driver for Qualcomm Adreno GPUs. (Turnip is specifically a component of Freedreno that implements Vulkan)
- **Zink + Turnip**: Zink forces OpenGL apps to use Vulkan drivers instead(Turnip being the Vulkan driver). This combination provides the BEST hardware acceleration currently possible.

# Mali GPU
A family of GPUs developed by ARM Holdings, used in most CPUs (e.g., Exynos, everything else).
  
### Panfrost
An open-source GPU driver project for Mali Midgard and Bifrost GPUs.
- **Warning**: Some devices may have bad drivers provided by OEMs which affects compatibility and performance with tools like VirGL.
  - Pre- and post-Kopper compatibility might differ, performance hits might occur, requiring Mesa recompilation for fixes.
  - **WineD3D** may not work.
  - PanVK won't support Android anytime soon.

# PowerVR GPU
A family of GPUs by Imagination Technologies, less common.
- GL4ES and VirGL are the only options for running OpenGL applications on PowerVR GPUs.

# Drivers/Tools/APIs

### LLVMpipe
A software rasterizer that uses the CPU for rendering instead of the GPU, resulting in the worst performance since CPUs are not optimized for rendering tasks.

### VirGL
(Vir)tual Open(GL): A renderer that works with most GPUs but generally offers worse performance and support compared to zink+turnip.

### GL4ES
A wrapper that translates desktop OpenGL calls to OpenGL ES calls.
- Should be faster than VirGL, pojavlauncher uses a fork of it called HolyGL4ES.
- Provides partial support for OpenGL 2.1 and 1.5. Generally faster than VirGL for translating OpenGL to OpenGL ES.

## WineD3D vs DXVK

### WineD3D
A component of Wine that translates DirectX to OpenGL calls.

### DXVK
A translation layer which translates DirectX to Vulkan calls.

# Benchmark/Games/Tools

### glmark2
Benchmarks devices using OpenGL 2.0 and OpenGL ES.

### glxgears
A demo of GLX (DO NOT use this to benchmark as it was NOT designed for benchmarks, use glmark2 instead).

### SuperTuxKart
Open source 3D kart racing game (similar to Mario Kart).

### Wine
A compatibility layer that enables Windows applications to run on Linux/macOS, without needing a full Windows OS installation.

### Box64/Box86
Allows you to run x86 and x86_64 Linux binaries on ARM (Box86) or ARM64 (Box64) systems, allowing you to run applications compiled for different CPU architectures on ARM-based devices.
- **aarch64** = ARM64
- **armv7l/armv8** = ARM
- All modern phone CPUs use ARM64, most modern PC CPUs use x86_64.

# Other Notes
- Hardware acceleration in proot using VirGL might require recompiling Mesa versions to make both sides match.
- Termux's repo doesn't package Mesa 22.1.7 (last version before Kopper was introduced) with VirGL. Therefore, you need to recompile it yourself if you'd like Mesa pre-Kopper.
