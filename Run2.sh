sudo apt-get update -y
sudo apt install qemu-utils -y
sudo apt-get install -y qemu-system-x86-64
qemu-img create -f raw XP.img 64G
wget -O 2003.iso 'https://archive.org/download/WinServer2003/Whistler%20BETA%20Build%203621%20Adv.%20Server.iso'
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
sudo qemu-system-x86_64 \
  -m 8G \
  -cpu EPYC \
  -boot order=d \
  -drive file=XP.img \
  -drive file=2003.iso,media=cdrom \
  -device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
  -device usb-tablet \
  -vnc :0 \
  -cpu coreduo \
  -smp sockets=1,cores=4,threads=1 \
  -vga std \
  -device rtl8139,netdev=n0 -netdev user,id=n0 \
  -accel tcg,thread=multi \
