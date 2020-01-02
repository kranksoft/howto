# Logical Volume Manager, LVM

LVM manages three things:
* Physical Volumes
  * Physical Volumes correspond to disks; they are block devices that provide the space to store logical volumes.
* Volume Groups
  * A Volume Group is a named collection of physical and logical volumes
* Logical Volumes
  * Corresponds to partitions and hold a filesystem. A logical volume can span across multiple disks.
---

#### Use Case - Add new disk and create the volume group **storage-vg** with two logical volumes **test-lv** and **prod-lv**.

The following assumes that a new disk has been added and that it has the name /dev/sdb.

#### Create an LVM partition on the new disk using fdisk. 
```
sudo fdisk /dev/sdb
```  
1. Press **n** for new partition  
 Choose **p** for primary and use defaults for the remaining choices  
2. Press **t** to change the partition type. Choose **8e** for Linux LVM.
3. Press **w** to write the partition table to the disk and exit.

#### Create a Physical Volume
```
sudo createpv /dev/sdb1
```
This command writes the LVM header to the partition, which identifies it as a **Physical Volume**. It also creates a small area to hold metadata about the Volume Group. The rest of the partition is marked as *unused Physical Extents*.

#### Create a Volume Group
```
sudo vgcreate storage-lv /dev/sdb1
```  
You now have the Volume Group **_storage_** containing one physical volume.

#### Create the Logical Volumes
```
sudo lvcreate -n test-lv -L 10G storage-lv
sudo lvcreate -n prod-lv -L 10G storage-lv
```
This creates two **Volume Groups** named test-lv and prod-lv with an equal size of 50 GigaBytes.

The commands **lvreduce** and **lvextend** can then be used to increase the size of a Logical Volume.