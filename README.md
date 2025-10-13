## Gentouranos overlay
This is a small project for me to have the packages I miss from the repo and existing overlays.  
Although I try to do my best, **you shouldn't expect any of my packages to build nor run on your system**. Matter of fact, I don't think any works for now !  
If you have the knowledge to fix what I'm trying to do, **don't hesistate to write a PR**, it'll be much appreciated !!  

## Enable this overlay
Using the `app-eselect/eselect-repository` tool, execute `sudo eselect repository add gentouranos git https://github.com/OuraN2O/gentouranos` or `sudo eselect repository enable gentouranos`   
Then sync with `sudo emaint sync -r gentouranos`

## Ebuilds that don't currently work/Help wanted  
- `app-misc/anki-25.01_beta1` : Can build on my main machine but not on my laptop. When builds, screen doesn't work (maybe vulkan dependancy problem)
- `sys-apps/wikiman-2.13.2` : Doesn't install to the right place
