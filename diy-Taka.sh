#!/bin/bash

#获取目录
CURRENT_DIR=$(cd $(dirname $0); pwd)
num=$(find $CURRENT_DIR -name gradlew  | awk -F"/" '{print NF-1}'| head -1)
DIR=$(find $CURRENT_DIR -name gradlew  | cut -d \/ -f$num | head -1)
cd $DIR
#签名
signingConfigs='ICAgIHNpZ25pbmdDb25maWdzIHtcCiAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICBteUNvbmZpZyB7XAogICAgICAgICAgICAgICAgc3RvcmVGaWxlIGZpbGUoUkVMRUFTRV9TVE9SRV9GSUxFKVwKICAgICAgICAgICAgICAgIHN0b3JlUGFzc3dvcmQgUkVMRUFTRV9TVE9SRV9QQVNTV09SRFwKICAgICAgICAgICAgICAgIGtleUFsaWFzIFJFTEVBU0VfS0VZX0FMSUFTXAogICAgICAgICAgICAgICAga2V5UGFzc3dvcmQgUkVMRUFTRV9LRVlfUEFTU1dPUkRcCiAgICAgICAgICAgICAgICB2MVNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICB2MlNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICBlbmFibGVWM1NpZ25pbmcgPSB0cnVlXAogICAgICAgICAgICAgICAgZW5hYmxlVjRTaWduaW5nID0gdHJ1ZVwKICAgICAgICAgICAgfVwKICAgICAgICB9XAogICAgfVwKXA=='
signingConfig='ICAgICAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICAgICAgc2lnbmluZ0NvbmZpZyBzaWduaW5nQ29uZmlncy5teUNvbmZpZ1wKICAgICAgICAgICAgfVwK'
signingConfigs="$(echo "$signingConfigs" |base64 -d )"
signingConfig="$(echo "$signingConfig" |base64 -d )"
sed -i -e "/defaultConfig {/i\\$signingConfigs " -e "/debug {/a\\$signingConfig " -e "/release {/a\\$signingConfig " $CURRENT_DIR/$DIR/app/build.gradle
cp -f $CURRENT_DIR/DIY/TVBoxOSC.jks $CURRENT_DIR/$DIR/app/TVBoxOSC.jks
cp -f $CURRENT_DIR/DIY/TVBoxOSC.jks $CURRENT_DIR/$DIR/TVBoxOSC.jks
echo "" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_STORE_FILE=./TVBoxOSC.jks" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_KEY_ALIAS=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_STORE_PASSWORD=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
echo "RELEASE_KEY_PASSWORD=TVBoxOSC" >>$CURRENT_DIR/$DIR/gradle.properties
#xwalk修复
sed -i 's/download.01.org\/crosswalk\/releases\/crosswalk\/android\/maven2/raw.githubusercontent.com\/lm317379829\/TVBoxDIY\/main/g' $CURRENT_DIR/$DIR/build.gradle

#指定搜索
#mv $CURRENT_DIR/DIY/设置2/shape_dialog_pg_search_checkbox.xml $CURRENT_DIR/$DIR/app/src/main/res/drawable/shape_dialog_pg_search_checkbox.xml
#cp $CURRENT_DIR/DIY/设置2/activity_search.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/activity_search.xml
#cp $CURRENT_DIR/DIY/设置2/HomeActivity.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/SearchActivity.java
#mv $CURRENT_DIR/DIY/设置2/dialog_checkbox_search.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_checkbox_search.xml
#mv $CURRENT_DIR/DIY/设置2/earchCheckboxDialog.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/dialog/SearchCheckboxDialog.java
#还原旧界面
cp $CURRENT_DIR/DIY/设置2/taka旧主界面.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_user.xml
cp $CURRENT_DIR/DIY/设置2/activity_home_top界面.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/activity_home.xml



#首页多排
cp $CURRENT_DIR/DIY/设置2/dialog_select.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_select.xml
mv $CURRENT_DIR/DIY/设置2/HomeActivity.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java
#设置
cp $CURRENT_DIR/DIY/设置2/fragment_model.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
#设置源多排
mv $CURRENT_DIR/DIY/设置2/ModelSettingFragment.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/fragment/ModelSettingFragment.java

//增加版本 更新说明
mv $CURRENT_DIR/DIY/设置/VersionDialog.java $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/ui/dialog/VersionDialog.java
mv $CURRENT_DIR/DIY/设置2/dialog_version.xml $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_version.xml
sed -i 's/6666/还原旧界面，增加首页多排/g'   $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_version.xml

#名称修改
sed -i 's/TVBox/影视TV/g' $CURRENT_DIR/$DIR/app/src/main/res/values-zh/strings.xml
sed -i 's/TVBox/影视TV/g' $CURRENT_DIR/$DIR/app/src/main/res/values/strings.xml



#首页排版边框
sed -i 's/vs_30/vs_15/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/dialog_select.xml

#版本号
sed -i 's/1.0.0/1.1.0/g' $CURRENT_DIR/$DIR/app/build.gradle
sed -i 's/1.0.0/1.1.0/g' $CURRENT_DIR/$DIR/app/src/main/res/layout/fragment_model.xml
#共存
sed -i 's/com.github.tvbox.osc/com.tvbox.T/g' $CURRENT_DIR/$DIR/app/build.gradle

#内置接口
#cp $CURRENT_DIR/DIY/ApiConfigT.java  $CURRENT_DIR/$DIR/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java

echo 'DIY end'
