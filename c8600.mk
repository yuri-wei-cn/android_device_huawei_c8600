#
# Copyright (C) 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_small.mk)
PRODUCT_LOCALES += zh_CN zh_HK zh_TW

# The gps config appropriate for this device
#$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/huawei/c8600/c8600-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/huawei/c8600/overlay


ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/huawei/c8600/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_PACKAGES += \
    copybit.C8600 \
    gps.C8600 \
    libRS \
    hwprops \
    rzscontrol \
    libOmxCore \
    libmm-omxcore \
    libOmxVidEnc \
    Gallery

# Live Wallpapers
PRODUCT_PACKAGES += \
    librs_jni \
    LiveWallpapersPicker

# Live Wallpapers support
PRODUCT_COPY_FILES += \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:/system/etc/permissions/android.software.live_wallpaper.xml

# vold
PRODUCT_COPY_FILES += \
    device/huawei/c8600/files/etc/vold.fstab:system/etc/vold.fstab

# Compcache module
PRODUCT_COPY_FILES += \
    device/huawei/c8600/modules/ramzswap.ko:system/lib/modules/2.6.29-perf/kernel/drivers/staging/ramzswap/ramzswap.ko

# Board-specific init
PRODUCT_COPY_FILES += \
    device/huawei/c8600/files/initlogo.rle:root/initlogo.rle

# Dummy backing file for USB mounting
PRODUCT_COPY_FILES += \
    device/huawei/c8600/files/cdrom/autorun.iso:system/cdrom/autorun.iso

# DHCP config for wifi
PRODUCT_COPY_FILES += \
    device/huawei/c8600/files/etc/dhcpcd/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf

PRODUCT_COPY_FILES += \
    device/huawei/c8600/ueventd.qcom.rc:root/ueventd.qcom.rc

# Keylayouts
PRODUCT_COPY_FILES += \
    device/huawei/c8600/keychars/surf_keypad.kcm.bin:system/usr/keychars/surf_keypad.kcm.bin \
    device/huawei/c8600/keylayout/surf_keypad.kl:system/usr/keylayout/surf_keypad.kl

# Install the features available on this device.
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml

PRODUCT_PROPERTY_OVERRIDES := \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=30 \
    ro.sf.lcd_density=160 \
    ro.com.android.dataroaming=false

# Default network type
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=4

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=65537

# Perfomance tweaks
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.heapsize=24m \
    persist.sys.use_dithering=1 \
    persist.sys.purgeable_assets=1 \
    ro.compcache.default=18

# Don't put dexfiles in /cache on c8600
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-data-only=1

# media configuration xml file
PRODUCT_COPY_FILES += \
    device/huawei/c8600/files/etc/media_profiles.xml:system/etc/media_profiles.xml

# wpa_supplicant configuration file
PRODUCT_COPY_FILES += \
    device/huawei/c8600/files/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

# Proprietary hardware related
PRODUCT_COPY_FILES += \
    vendor/huawei/c8600/proprietary/akmd2:system/bin/akmd2 \
    vendor/huawei/c8600/proprietary/libcamera.so:obj/lib/libcamera.so \
    vendor/huawei/c8600/proprietary/libcamera.so:system/lib/libcamera.so \
    vendor/huawei/c8600/proprietary/libqcamera.so:system/lib/libqcamera.so \
    vendor/huawei/c8600/proprietary/libmmjpeg.so:system/lib/libmmjpeg.so \
    vendor/huawei/c8600/proprietary/libmmipl.so:system/lib/libmmipl.so \
    vendor/huawei/c8600/proprietary/libmmprocess.so:system/lib/libmmprocess.so \
    vendor/huawei/c8600/proprietary/init.qcom.bt.sh:system/etc/init.qcom.bt.sh

# Sound and OMX
PRODUCT_COPY_FILES += \
    device/huawei/c8600/files/etc/AudioFilter.csv:system/etc/AudioFilter.csv \
    device/huawei/c8600/files/etc/AutoVolumeControl.txt:system/etc/AutoVolumeControl.txt \
    vendor/huawei/c8600/proprietary/libaudioeq.so:system/lib/libaudioeq.so \
    vendor/huawei/c8600/proprietary/libmm-adspsvc.so:system/lib/libmm-adspsvc.so \
    vendor/huawei/c8600/proprietary/libOmxH264Dec.so:system/lib/libOmxH264Dec.so \
    vendor/huawei/c8600/proprietary/libOmxMpeg4Dec.so:system/lib/libOmxMpeg4Dec.so \
    vendor/huawei/c8600/proprietary/libOmxVidEnc.so:system/lib/libOmxVidEnc.so

# HW
PRODUCT_COPY_FILES += \
    vendor/huawei/c8600/proprietary/gralloc.msm7k.so:system/lib/hw/gralloc.msm7k.so \
    vendor/huawei/c8600/proprietary/lights.msm7k.so:system/lib/hw/lights.msm7k.so \
    vendor/huawei/c8600/proprietary/sensors.default.so:system/lib/hw/sensors.default.so

# GPS
PRODUCT_COPY_FILES += \
    device/huawei/c8600/files/etc/gps.conf:system/etc/gps.conf

# Proprietary RIL related
PRODUCT_COPY_FILES += \
    device/huawei/c8600/files/etc/apns-conf.xml:system/etc/apns-conf.xml \
    vendor/huawei/c8600/proprietary/libauth.so:system/lib/libauth.so \
    vendor/huawei/c8600/proprietary/libril-qc-1.so:system/lib/libril-qc-1.so \
    vendor/huawei/c8600/proprietary/libril.so:system/lib/libril.so \
    vendor/huawei/c8600/proprietary/liboncrpc.so:system/lib/liboncrpc.so \
    vendor/huawei/c8600/proprietary/libdsm.so:system/lib/libdsm.so \
    vendor/huawei/c8600/proprietary/libqueue.so:system/lib/libqueue.so \
    vendor/huawei/c8600/proprietary/libcm.so:system/lib/libcm.so \
    vendor/huawei/c8600/proprietary/libdiag.so:system/lib/libdiag.so \
    vendor/huawei/c8600/proprietary/libmmgsdilib.so:system/lib/libmmgsdilib.so \
    vendor/huawei/c8600/proprietary/libgsdi_exp.so:system/lib/libgsdi_exp.so \
    vendor/huawei/c8600/proprietary/libgstk_exp.so:system/lib/libgstk_exp.so \
    vendor/huawei/c8600/proprietary/libwms.so:system/lib/libwms.so \
    vendor/huawei/c8600/proprietary/libnv.so:system/lib/libnv.so \
    vendor/huawei/c8600/proprietary/libwmsts.so:system/lib/libwmsts.so \
    vendor/huawei/c8600/proprietary/libril-qcril-hook-oem.so:system/lib/libril-qcril-hook-oem.so \
    vendor/huawei/c8600/proprietary/libdss.so:system/lib/libdss.so \
    vendor/huawei/c8600/proprietary/libdll.so:system/lib/libdll.so \
    vendor/huawei/c8600/proprietary/libqmi.so:system/lib/libqmi.so \
    vendor/huawei/c8600/proprietary/libpbmlib.so:system/lib/libpbmlib.so \
    vendor/huawei/c8600/proprietary/libwpa_client.so:system/lib/libwpa_client.so \
    vendor/huawei/c8600/proprietary/qmuxd:system/bin/qmuxd \
    vendor/huawei/c8600/proprietary/hci_qcomm_init:system/bin/hci_qcomm_init

# OEM RPC
PRODUCT_COPY_FILES += \
    vendor/huawei/c8600/proprietary/modempre:system/bin/modempre \
    vendor/huawei/c8600/proprietary/oem_rpc_svc:system/bin/oem_rpc_svc \
    vendor/huawei/c8600/proprietary/libhwrpc.so:system/lib/libhwrpc.so \
    vendor/huawei/c8600/proprietary/liboem_rapi.so:system/lib/liboem_rapi.so
    
## C8600 WIFI    
PRODUCT_COPY_FILES += \
    vendor/huawei/c8600/proprietary/wifi/ar6000.ko:system/wifi/ar6000.ko \
    vendor/huawei/c8600/proprietary/wifi/caldata.bin.c8600.ar6002:system/wifi/caldata.bin.c8600.ar6002 \
    vendor/huawei/c8600/proprietary/wifi/iwlist:system/wifi/iwlist \
    vendor/huawei/c8600/proprietary/wifi/artagent:system/wifi/artagent \
    vendor/huawei/c8600/proprietary/wifi/connectap.sh:system/wifi/connectap.sh \
    vendor/huawei/c8600/proprietary/wifi/loadART.sh:system/wifi/loadART.sh \
    vendor/huawei/c8600/proprietary/wifi/athtcmd_ram.bin:system/wifi/athtcmd_ram.bin \
    vendor/huawei/c8600/proprietary/wifi/data.patch.hw2_0.bin.ar6002:system/wifi/data.patch.hw2_0.bin.ar6002 \
    vendor/huawei/c8600/proprietary/wifi/loadecho.sh:system/wifi/loadecho.sh \
    vendor/huawei/c8600/proprietary/wifi/athwlan.bin.z77:system/wifi/athwlan.bin.z77 \
    vendor/huawei/c8600/proprietary/wifi/data.patch.hw2_0.bin.ar6102:system/wifi/data.patch.hw2_0.bin.ar6102 \
    vendor/huawei/c8600/proprietary/wifi/udp_server:system/wifi/udp_server \
    vendor/huawei/c8600/proprietary/wifi/caldata.bin.ar6002:system/wifi/caldata.bin.ar6002 \
    vendor/huawei/c8600/proprietary/wifi/device.bin:system/wifi/device.bin \
    vendor/huawei/c8600/proprietary/wifi/caldata.bin.ar6102:system/wifi/caldata.bin.ar6102 \
    vendor/huawei/c8600/proprietary/wifi/iwconfig:system/wifi/iwconfig \
    vendor/huawei/c8600/proprietary/wpa_supplicant:system/bin/wpa_supplicant
    
## Wifi related
PRODUCT_COPY_FILES += \
    device/huawei/c8600/modules/bcm4319.ko:system/lib/modules/bcm4319.ko \
    device/huawei/c8600/files/etc/firmware/fw_bcm4319.bin:system/etc/firmware/fw_bcm4319.bin \
    device/huawei/c8600/files/etc/firmware/nvram.txt:system/etc/firmware/nvram.txt

$(call inherit-product, build/target/product/small_base.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := generic_c8600
PRODUCT_DEVICE := c8600
PRODUCT_MODEL := Huawei C8600
PRODUCT_LOCALES := zh_CN

PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-huawei-us \
    ro.com.google.locationfeatures=1 \
    ro.cdma.home.operator.numeric=46003 \
    ro.cdma.home.operator.alpha=中国电信 \
    ro.config.cdma_subscription=0 \
    ril.subscription.types=RUIM,NV \
    ro.cdma.voicemail.number=mine \
    ro.setupwizard.enable_bypass=1 \
    keyguard.no_require_sim=false
