#!/bin/bash

function compile() 
{
source ~/.bashrc && source ~/.profile
export LC_ALL=C && export USE_CCACHE=1
export ARCH=arm64
rm -rf AnyKernel
export KBUILD_BUILD_HOST=Axioo
export KBUILD_BUILD_USER="KazuHikari"
git clone https://gitlab.com/LeCmnGend/proton-clang -b Clang-15  clang

[ -d "out" ] && rm -rf out || mkdir -p out

make O=out ARCH=arm64 rosemary_defconfig

PATH="${PWD}/clang/bin:${PATH}" \
make -j2                O=out \
                        ARCH=$ARCH \
                        CC="clang" \
                        CLANG_TRIPLE=aarch64-linux-gnu- \
                        CROSS_COMPILE="${PWD}/los-4.9-64/bin/aarch64-linux-android-" \
                        CROSS_COMPILE_ARM32="${PWD}/los-4.9-32/bin/arm-linux-androideabi-" \
            		LLVM=1 \
                        LD=ld.lld \
                        AR=llvm-ar \
                        NM=llvm-nm \
                        OBJCOPY=llvm-objcopy \
                        OBJDUMP=llvm-objdump \
                        STRIP=llvm-strip \
                        CONFIG_NO_ERROR_ON_MISMATCH=y 2>&1 | tee error.log 
}

function zupload()
{
git clone --depth=1 https://github.com/JR205-5000/AnyKernel3-1 -b rosemary AnyKernel
cp out/arch/arm64/boot/Image.gz-dtb AnyKernel
cd AnyKernel
zip -r9 MyGO!!!!!-V3Kernel-Lancelot-E235-SUOC.zip *
curl -sL https://git.io/file-transfer | sh
./transfer wet Succubus-Kernel-Lamcot-JR205-1.zip
}

compile
zupload
