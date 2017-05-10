generate_ipa=\
    rm -rf "/tmp/xcodebuild/YueduFM/target/Payload"; \
    mkdir -p "/tmp/xcodebuild/YueduFM/target/Payload"; \
    cp -rf "/tmp/xcodebuild/YueduFM/Build/Products/Release-iphoneos/$1.app" "/tmp/xcodebuild/YueduFM/target/Payload"; \
    zip -r "/tmp/xcodebuild/YueduFM/target/$1.ipa" "/tmp/xcodebuild/YueduFM/target/Payload"; \
    rm -rf "/tmp/xcodebuild/YueduFM/target/Payload"

generate_lib=\
    mkdir -p "/tmp/xcodebuild/YueduFM/target/$1/include";\
    cp -rf "/tmp/xcodebuild/YueduFM/Build/Products/Release-iphoneos/include/$1" "/tmp/xcodebuild/YueduFM/target/$1/include";\
    cp -rf "/tmp/xcodebuild/YueduFM/Build/Products/Release-iphoneos/lib$1.a" "/tmp/xcodebuild/YueduFM/target/$1"; \
    if [ 0 -eq "1" ]; then \
        lipo -create "/tmp/xcodebuild/YueduFM/Build/Products/Release-iphoneos/lib$1.a" "/tmp/xcodebuild/YueduFM/Build/Products/Release-iphonesimulator/lib$1.a" -output "/tmp/xcodebuild/YueduFM/target/$1/lib$1.a";\
    fi

generate_framework=\
    cp -rf "/tmp/xcodebuild/YueduFM/Build/Products/Release-iphoneos/$1.framework" "/tmp/xcodebuild/YueduFM/target";\
    if [ 0 -eq "1" ]; then \
        lipo -create "/tmp/xcodebuild/YueduFM/Build/Products/Release-iphoneos/$1.framework/$1" "/tmp/xcodebuild/YueduFM/Build/Products/Release-iphonesimulator/$1.framework/$1" -output "/tmp/xcodebuild/YueduFM/target/$1.framework/$1";\
    fi

all:  YueduFM

clean: YueduFM-clean

install_prepare:
	@mkdir -p "/Users/starnet/Downloads/"

install:install_prepare  YueduFM-install

YueduFM-device:
	xcodebuild  -project "YueduFM.xcodeproj" -configuration "Release" -scheme YueduFM -derivedDataPath "/tmp/xcodebuild/YueduFM" -sdk iphoneos
YueduFM:YueduFM-device
	@mkdir -p "/tmp/xcodebuild/YueduFM/target"
	@if test -d "/tmp/xcodebuild/YueduFM/Build/Products/Release-iphoneos/YueduFM.app"; then \
		$(call generate_ipa,YueduFM); \
	fi

	@if test -f "/tmp/xcodebuild/YueduFM/Build/Products/Release-iphoneos/libYueduFM.a"; then \
		$(call generate_lib,YueduFM); \
	fi

	@if test -d "/tmp/xcodebuild/YueduFM/Build/Products/Release-iphoneos/YueduFM.framework"; then \
		$(call generate_framework,YueduFM); \
	fi
YueduFM-clean:
	xcodebuild clean  -project "YueduFM.xcodeproj" -configuration "Release" -scheme YueduFM -derivedDataPath "/tmp/xcodebuild/YueduFM" -sdk iphoneos
YueduFM-install:YueduFM
	@test ! -f "/tmp/xcodebuild/YueduFM/target/YueduFM.ipa" || cp -rf "/tmp/xcodebuild/YueduFM/target/YueduFM.ipa" "/Users/starnet/Downloads/"
	@test ! -d "/tmp/xcodebuild/YueduFM/target/YueduFM" || cp -rf "/tmp/xcodebuild/YueduFM/target/YueduFM" "/Users/starnet/Downloads/"
	@test ! -d "/tmp/xcodebuild/YueduFM/target/YueduFM.framework" || cp -rf "/tmp/xcodebuild/YueduFM/target/YueduFM.framework" "/Users/starnet/Downloads/"
	@echo "Installed to /Users/starnet/Downloads/..."

.PHONY:  all YueduFM YueduFM-install YueduFM-clean install_prepare clean install YueduFM-device
