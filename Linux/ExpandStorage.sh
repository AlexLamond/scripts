# Ubuntu can sometimes exhibit a situation whereby the storage in use by the primary volume, is half that of the allocated disk size. Here is how to identify and expand it

# We need to run this as superuser
sudo su

# Check the Free PE / Size
vgdisplay

# Check our filesystems free space 
df -h

# If /dev/mapper/ubuntu--vg-ubuntu--lv has a size identical to that of the Free PE / Size, then we need to expand the partition
lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv

# Ensure the disk size has expanded, our Avail will now be what it was + the Free PE / Size
df -h
