PBLK_BGN=0
PBLK_END=3
PBLK_NAME="pblk_${PBLK_BGN}_${PBLK_END}"
PBLK_DIR=/home/raohui/pblk_dir
RBENCH_DEV_NAME='nvme0n1'

if [ ! $1 ]; then
    echo "rm pblk and create"
    nvme lnvm remove $PBLK_NAME --target-name=$PBLK_NAME
    nvme lnvm create -d $RBENCH_DEV_NAME -n $PBLK_NAME -t pblk -b $PBLK_BGN -e $PBLK_END -f
else
    if [ $1 = "fsrm" ]; then
        echo "rm fs pblk"
        umount $PBLK_DIR
        nvme lnvm remove $PBLK_NAME --target-name=$PBLK_NAME
    elif [ $1 = "fs" ];then
        echo "rm fs pblk and create"
        umount $PBLK_DIR
        nvme lnvm remove $PBLK_NAME --target-name=$PBLK_NAME
        nvme lnvm create -d $RBENCH_DEV_NAME -n $PBLK_NAME -t pblk -b $PBLK_BGN -e $PBLK_END -f
        mkfs.ext4 -F "/dev/$PBLK_NAME"
        mount "/dev/$PBLK_NAME" $PBLK_DIR
    elif [ $1 = "rm" ]; then
        echo "rm pblk"
        nvme lnvm remove $PBLK_NAME --target-name=$PBLK_NAME
    fi
fi
