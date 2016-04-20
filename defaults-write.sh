#!/usr/bin/env bash

# ~/.osx — http://mths.be/osx

# Ask for the administrator password upfront
sudo -v

set -e

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# [システム環境設定]，[共有] の [コンピューター名]
echo -n "What is your Mac name? : "
read ans
sudo scutil --set ComputerName "$ans"
sudo scutil --set HostName "$ans"
sudo scutil --set LocalHostName "$ans"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$ans"

# ((スリープ状態に移行するまでの時間 = 86400秒(24時間)))
sudo pmset -a standbydelay 86400

# [システム環境設定]，[一般] の pmn[強調表示色] = [gray]
defaults write NSGlobalDomain AppleHighlightColor -string '0.780400 0.815700 0.858800'

# [システム環境設定]，[一般] の pmn[サイドバーのアイコンサイズ] = [小]
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# ((保存ダイアログのデフォルト表示スタイル = 常に拡張(詳細)表示))
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# ((印刷ダイアログのデフォルト表示スタイル = 常に拡張(詳細)表示))
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# ((icloud 対応アプリでのファイル保存時のデフォルト = icloud をデフォルト保存先としない))
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# ((メッセージダイアログ "...開いてもよろしいですか?" = 表示しない))
defaults write com.apple.LaunchServices LSQuarantine -bool false

# ((マシンがフリーズしたら自動的にリスタート = する))
systemsetup -setrestartfreeze on

# [システム環境設定]，[トラックパッド] の pnl[ポイントとクリック] > chb[副ボタンのクリック] = "オン"，pmn[右下端をクリック]
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# [システム環境設定]，[トラックパッド] の [スクロールとズーム] > chb[スクロールの方向 : ナチュラル] = "オフ"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# [システム環境設定]，[キーボード] の pnl[キーボードショートカット] > [フルキーボードアクセス : Tab キーを...] = rbt[すべてのコントロール]
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# [システム環境設定]，[アクセシビリティ] の chb[補助装置にアクセスできるようにする] = "オン"
echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1
sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled
# TODO: avoid GUI password prompt somehow (http://apple.stackexchange.com/q/60476/4408)
#sudo osascript -e 'tell application "System Events" to set UI elements enabled to true'

# [システム環境設定]，[アクセシビリティ] の [ズーム機能] > chb[スクロールジェスチャと修飾キーを使ってズーム] = "オン"，pmn[^ Control]
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# [システム環境設定]，[キーボード] の sht[キーボード] > chb[環境光が暗い場合にキーボードの輝度を調整] = "オン"
defaults write com.apple.BezelServices kDim -bool true

# [システム環境設定]，[キーボード] の sht[キーボード] > sld[発行した状態でコンピュータが待機する時間の設定] = 300 秒
defaults write com.apple.BezelServices kDimTime -int 300

###############################################################################
# Finder                                                                      #
###############################################################################

# (([Finder] メニューに [Finder を終了] アイテムの表示 = 表示))
defaults write com.apple.finder QuitMenuItem -bool true

# [Finder の環境設定]，pnl[一般] > [デスクトップに表示する項目] = chb[ハードディスク], [外部ディスク], [CD，DVD，および iPod], [接続しているサーバ]
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# [Finder の環境設定]，pnl[詳細] > [すべてのファイル名拡張子を表示] = "オン"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# finder のメニュー [表示] > [ステータスバーを表示]
defaults write com.apple.finder ShowStatusBar -bool true

# finder のメニュー [表示] > [パスバーを表示]
defaults write com.apple.finder ShowPathbar -bool true

# quicklook でのテキストコンテンツ編集 = 編集可
defaults write com.apple.finder QLEnableTextSelection -bool true

# ((タイトルバーへのパス表示 = 表示する))
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# [Finder の環境設定]，pnl[詳細] > pmn[検索実行時] = [現在のフォルダ内を検索]
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# [Finder の環境設定]，pnl[詳細] > [拡張子を変更する前に警告を表示] = オン
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# [Finder の環境設定]，pnl[一般] > chb[スプリングフォルダとスプリングウインドウ] = オン
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# [Finder の環境設定]，pnl[一般] > chb[スプリングフォルダとスプリングウインドウ] > sld[反応時間]
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# ((ネットワーク接続時の .DS_Store ファイル生成の抑制 = 作らない))
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# ((ディスクイメージ .dmg 展開時の検証処理のスキップ))
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# ((ボリュームのマウント時，新しいファインダで開く = 開く))
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# 以下，表示スタイルが "アイコン" の状態 で，ココカラ {
# finder のメニュー [表示] > [表示オプション] で開くダイアログ [デスクトップ]/[<それぞれのアイテム名>] の chb[項目の情報を表示] = オン
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
#usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# デスクトップをアクティブにし，finder のメニュー [表示] > [表示オプション] - [デスクトップ] ダイアログの rbt[ラベルの位置] = [右側]
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# finder のメニュー [表示] > [表示オプション] で開くダイアログ [デスクトップ]/[<それぞれのアイテム名>] の pmn[並び順序] = [グリッドに沿う]
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist

# finder のメニュー [表示] > [表示オプション] で開くダイアログ [デスクトップ]/[<それぞれのアイテム名>] の sld[グリッド間隔] = 100 px (なんとなく 1/8 くらい)
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

# finder のメニュー [表示] > [表示オプション] で開くダイアログ [デスクトップ]/[<それぞれのアイテム名>] の sld[アイコンサイズ] = 80 px
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist
# } 以上，表示スタイルが "アイコン" の状態 で，はココマデ


# 表示スタイルが "リスト" の状態で，finder のメニュー [表示] > [表示オプション] で開くダイアログ [<それぞれのアイテム名>] の sld[デフォルトとして使用] = "オン"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# [Finder の環境設定]，pnl[詳細] > [ゴミ箱を空にする前に警告を表示] = オン
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# ((AirDrop が使えない Mac で AirDrop を使えるようにする = 使えるようにする))
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# ((すべての mac で superdrive が動くようにする = する))
sudo nvram boot-args="mbasd=1"

# Library フォルダの可視化
chflags nohidden ~/Library

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# (([システム環境設定]，[Dock] の sld[大きさ] = sld[サイズ] 1/8 くらい))
defaults write com.apple.dock tilesize -int 36

# ((Dock への drag & drop で起動/開く機能 (スプリングフォルダの dock 版) = 機能する))
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# [システム環境設定]，[Dock] の chb[起動済みのアプリケーションにインジケータ・ランプを表示] = オン
defaults write com.apple.dock show-process-indicators -bool true

# ((dashboard を無効にする = 無効にする))
defaults write com.apple.dashboard mcx-disabled -bool true

# [システム環境設定]，[Mission Control] の chb[Dashboard を操作スペースとして表示] = オン
defaults write com.apple.dock dashboard-in-overlay -bool true

# safari の [環境設定]，[一般] シート > chb[ダウンロード後，"安全な" ファイルを開く] = オン
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# safari の [環境設定]，[詳細] シート > chb[メニューバーに"開発"メニューを表示] = オン
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

#
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# ((部分一致検索のデフォルトモード = Contains))
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# ((開発メニューとウェブインスペクターをエネイブルにする))
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# ((コンテキストメニューにウェブ・インスペクター表示のアイテムを追加 = 表示する))
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Terminal                                                                    #
###############################################################################

# ターミナル，[エンコーディング]シート > リスト > chb[Unicode (UTF-8)] = "オン"
defaults write com.apple.terminal StringEncodings -array 4

# TextEdit，[環境設定] の [新規書類] > [フォーマット] = rb[標準テキスト]
defaults write com.apple.TextEdit RichText -int 0

# ((ディスクユーティリティのデバッグメニュー = 表示する))
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Dashboard" "Dock" "Finder" \
    "Safari" "SystemUIServer" \
    "iTunes"; do
    killall "$app" > /dev/null 2>&1
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
