#!/usr/bin/env bash

# ~/.osx — http://mths.be/osx

# Ask for the administrator password upfront
sudo -v

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

# ((起動音をオフ))
#sudo nvram SystemAudioVolume=" "

# [システム環境]，[デスクトップとスクリーンセーバ] のchb[半透明メニューバー] = "オフ"
#defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# ((バッテリー残量表示，0.8 以前 = 時間表示))
#defaults write com.apple.menuextra.battery ShowPercent -string "NO"
#defaults write com.apple.menuextra.battery ShowTime -string "YES"

# ((メニューバーに表示するアイコン =  Bluetooth，Wifi，バッテリー，そして時計))
#defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu"

# [システム環境設定]，[一般] の pmn[強調表示色] = [gray]
defaults write NSGlobalDomain AppleHighlightColor -string '0.780400 0.815700 0.858800'

# [システム環境設定]，[一般] の pmn[サイドバーのアイコンサイズ] = [小]
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# [システム環境設定]，[一般] の rbt[スクロールバーの表示] = [常に表示]
#defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# ((スムーズスクロール = "オフ" (古い os での設定) ))
# (Uncomment if you’re on an older Mac that messes up the animation)
#defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# ((ウィンドウが開閉時のアニメーション = なし))
#defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# ((シート表示のアニメーションスピード = 0.001 秒))
#defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# ((保存ダイアログのデフォルト表示スタイル = 常に拡張(詳細)表示))
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# ((印刷ダイアログのデフォルト表示スタイル = 常に拡張(詳細)表示))
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# ((icloud 対応アプリでのファイル保存時のデフォルト = icloud をデフォルト保存先としない))
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete ((?))
#defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# ((メッセージダイアログ "...開いてもよろしいですか?" = 表示しない))
defaults write com.apple.LaunchServices LSQuarantine -bool false

# ((ascii 制御文字の表示 = 表示する))
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
#defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# [システム環境設定]，[一般] の chb[アプリケーションを終了して再度開くときにウィンドウを復元] = "オフ"
#defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# ((automatic termination 機能 = 無効))
#defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# ((クラッシュリポーター = 表示しない))
#defaults write com.apple.CrashReporter DialogType -string "none"

# ((ヘルプの常時前面表示 = 常時最前面表示解除))
#defaults write com.apple.helpviewer DevMode -bool true

# Fix for the ancient UTF-8 bug in QuickLook (http://mths.be/bbo)
# Commented out, as this is known to cause problems in various Adobe apps :(
# See https://github.com/mathiasbynens/dotfiles/issues/237
#echo "0x08000100:0" > ~/.CFUserTextEncoding

# ((ログインウインドウの右上にある時計をクリックして、システムに関する追加情報を表示 = HostName を表示))
#sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# ((マシンがフリーズしたら自動的にリスタート = する))
systemsetup -setrestartfreeze on

# [システム環境設定]，[省エネルギー] の [バッテリー]/[電源アダプター] の sld[コンピュータのスリープ] = [しない]
#systemsetup -setcomputersleep Off > /dev/null

# ((アップデートのチェック周期 = 毎日))
#defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# ((通知センター = 使わない))
#launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# ((トラックパッド，タップ は クリック (ログイン画面でも) = いつでもタップ=クリック))
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
#defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
#defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# [システム環境設定]，[トラックパッド] の pnl[ポイントとクリック] > chb[副ボタンのクリック] = "オン"，pmn[右下端をクリック]
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# [システム環境設定]，[トラックパッド] の [その他のジェスチャ] > chb[ページ間をスワイプ] = "オン"，pmn[3本指でスワイプ]
#defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

# [システム環境設定]，[トラックパッド] の [スクロールとズーム] > chb[スクロールの方向 : ナチュラル] = "オフ"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Increase sound quality for Bluetooth headphones/headsets ((?))
#defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

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
# [システム環境設定]，[アクセシビリティ] の [ズーム機能] > chb[ズームの対象をキーボード入力の対象にする] = "オン"
#defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# ((代用文字の入力とスペースまたはシンボルのリピート入力 = 無効))
#defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# ((キーのリピートの速さ = 0秒))
#defaults write NSGlobalDomain KeyRepeat -int 0

# [システム環境設定]，[キーボード] の sht[キーボード] > chb[環境光が暗い場合にキーボードの輝度を調整] = "オン"
defaults write com.apple.BezelServices kDim -bool true
# [システム環境設定]，[キーボード] の sht[キーボード] > sld[発行した状態でコンピュータが待機する時間の設定] = 300 秒
defaults write com.apple.BezelServices kDimTime -int 300

# [システム環境設定]，[言語とテキスト] の設定
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
#defaults write NSGlobalDomain AppleLanguages -array "en" "nl"
#defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=EUR"
#defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
#defaults write NSGlobalDomain AppleMetricUnits -bool true

# [システム環境設定]，[日付と時刻] の設定
#systemsetup -settimezone "Europe/Brussels" > /dev/null

# [システム環境設定]，[言語とテキスト] の sht[テキスト] > chb[スペルチェックを自動的に修正] = "オフ"
#defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Screen                                                                      #
###############################################################################

# ((スクリーンセーバー解除時のパスワード要求 = あり)) ((スクリーンセーバーに入ってから何秒後にパスワードを要求するか = 0秒))
#defaults write com.apple.screensaver askForPassword -int 1
#defaults write com.apple.screensaver askForPasswordDelay -int 0

# ((スクリーンショットの出力先 = デスクトップ))
#defaults write com.apple.screencapture location -string "$HOME/Desktop"

# ((スクリーンショットのフォーマット = png)
#defaults write com.apple.screencapture type -string "png"

# ((スクリーンショットの影付き効果 = なし)
#defaults write com.apple.screencapture disable-shadow -bool true

# ((apple 製以外のモニターでのサブピクセルレンダリング = 中)
#defaults write NSGlobalDomain AppleFontSmoothing -int 2

# ((HiDPI モード = オン)
#sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# (([Finder] メニューに [Finder を終了] アイテムの表示 = 表示))
defaults write com.apple.finder QuitMenuItem -bool true

# ((アニメーションエフェクトの無効化 = アニメーションを無効にする))
#defaults write com.apple.finder DisableAllAnimations -bool true

# [Finder の環境設定]，pnl[一般] > [デスクトップに表示する項目] = chb[ハードディスク], [外部ディスク], [CD，DVD，および iPod], [接続しているサーバ]
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# ((不可視ファイル/フォルダ(.ファイル等)の表示 = 表示する))
#defaults write com.apple.finder AppleShowAllFiles -bool true

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
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# デスクトップをアクティブにし，finder のメニュー [表示] > [表示オプション] - [デスクトップ] ダイアログの rbt[ラベルの位置] = [右側]
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# finder のメニュー [表示] > [表示オプション] で開くダイアログ [デスクトップ]/[<それぞれのアイテム名>] の pmn[並び順序] = [グリッドに沿う]
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist

# finder のメニュー [表示] > [表示オプション] で開くダイアログ [デスクトップ]/[<それぞれのアイテム名>] の sld[グリッド間隔] = 100 px (なんとなく 1/8 くらい)
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

# finder のメニュー [表示] > [表示オプション] で開くダイアログ [デスクトップ]/[<それぞれのアイテム名>] の sld[アイコンサイズ] = 80 px
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist
# } 以上，表示スタイルが "アイコン" の状態 で，はココマデ


# 表示スタイルが "リスト" の状態で，finder のメニュー [表示] > [表示オプション] で開くダイアログ [<それぞれのアイテム名>] の sld[デフォルトとして使用] = "オン"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# [Finder の環境設定]，pnl[詳細] > [ゴミ箱を空にする前に警告を表示] = オン
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# [Finder の環境設定]，pnl[詳細] > [確実にゴミ箱を空にする] = オン
#defaults write com.apple.finder EmptyTrashSecurely -bool true

# ((AirDrop が使えない Mac で AirDrop を使えるようにする = 使えるようにする))
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# ((すべての mac で superdrive が動くようにする = する))
sudo nvram boot-args="mbasd=1"

# Library フォルダの可視化
chflags nohidden ~/Library

# dropbox の同期マーク表示 = 非表示
#file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
#[ -e "$file" ] && mv -f "$file" "$file.bak"

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# ((グリッド表示時の Dock のスタック上のマウスオーバー時のハイライト = ハイライトする))
#defaults write com.apple.dock mouse-over-hilite-stack -bool true

# (([システム環境設定]，[Dock] の sld[大きさ] = sld[サイズ] 1/8 くらい))
defaults write com.apple.dock tilesize -int 36

# ((Dock への drag & drop で起動/開く機能 (スプリングフォルダの dock 版) = 機能する))
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# [システム環境設定]，[Dock] の chb[起動済みのアプリケーションにインジケータ・ランプを表示] = オン
defaults write com.apple.dock show-process-indicators -bool true

# ((dock を真っ新にする = 真っ新にする (「新しい mac の設定，あるいは dock を使わないなら，これを使うのが良い」と言っている)))
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
#defaults write com.apple.dock persistent-apps -array

# [システム環境設定]，[Dock] の chb[起動中のアプリケーションをアニメーションで表示] = オフ
#defaults write com.apple.dock launchanim -bool false

# ((mission control への移行アニメーション速度 = 0.1))
#defaults write com.apple.dock expose-animation-duration -float 0.1

# [システム環境設定]，[Mission Control] の chb[ウィンドウをアプリケーションごとにグループ化] = オフ
# (i.e. use the old Exposé behavior instead)
#defaults write com.apple.dock expose-group-by-app -bool false

# ((dashboard を無効にする = 無効にする))
defaults write com.apple.dashboard mcx-disabled -bool true

# [システム環境設定]，[Mission Control] の chb[Dashboard を操作スペースとして表示] = オン
defaults write com.apple.dock dashboard-in-overlay -bool true

# [システム環境設定]，[Mission Control] の chb[最新の使用状況に基づいて操作スペースを自動的に並び替える] = オフ
#defaults write com.apple.dock mru-spaces -bool false

# ((dock の表示/非表示の開始速度 = 0秒))
#defaults write com.apple.dock autohide-delay -float 0
# ((Dock 表示/非表示のアニメーションの速度 = 0 秒))
#defaults write com.apple.dock autohide-time-modifier -float 0

# ((dock の表示を 2d にする = 2d にする))
#defaults write com.apple.dock no-glass -bool true

# [システム環境設定]，[Dock] の [Dock を自動的に隠す/表示] = オン
#defaults write com.apple.dock autohide -bool true

# ((隠れているアプリケーションの dock のアイコン透過 = 透過する))
#defaults write com.apple.dock showhidden -bool true

# ((launchpad をリセット))
#find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete

# ((launchpad に ios simulator をセット))
#ln -s /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app /Applications/iOS\ Simulator.app

# ((dock のスペーサーに透明なものを当てる))
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
#defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

# [システム環境設定]，[Mission Control] の [キーボードとマウスのショートカット]
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 左上，修飾キーなし = Mission Control
#defaults write com.apple.dock wvous-tl-corner -int 2
#defaults write com.apple.dock wvous-tl-modifier -int 0
# 右上，修飾キーなし = デスクトップ
#defaults write com.apple.dock wvous-tr-corner -int 4
#defaults write com.apple.dock wvous-tr-modifier -int 0
# 左下，修飾キーなし = スクリーンセーバーを開始する
#defaults write com.apple.dock wvous-bl-corner -int 5
#defaults write com.apple.dock wvous-bl-modifier -int 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# safari の [環境設定]，[一般] シート > [ホームページ] = "about:blank"
#defaults write com.apple.Safari HomePage -string "about:blank"

# safari の [環境設定]，[一般] シート > chb[ダウンロード後，"安全な" ファイルを開く] = オン
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# ((直前見ていたページへ移動はバックスペースキーによる操作を有効にする = 有効にする))
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# ((履歴やトップサイトで使用するページのサムネイル画像生成/自動生成を停止 = すべて停止))
#defaults write com.apple.Safari ShowFavoritesBar -bool false

# safari の [環境設定]，[詳細] シート > chb[メニューバーに"開発"メニューを表示] = オン
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

#
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# ((部分一致検索のデフォルトモード = Contains))
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# ((ブックマークバーのトップサイトやリーディングリスト等のアイコン = 表示しない))
#defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# ((開発メニューとウェブインスペクターをエネイブルにする))
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# ((コンテキストメニューにウェブ・インスペクター表示のアイテムを追加 = 表示する))
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# iTunes (pre-iTunes 11 only)                                                 #
###############################################################################

# (略)
#defaults write com.apple.iTunes show-store-link-arrows -bool false

# (略)
#defaults write com.apple.iTunes disableGeniusSidebar -bool true

# (略)
#defaults write com.apple.iTunes disableRadio -bool true

# (略)
# To use these commands in another language, browse iTunes’s package contents,
# open `Contents/Resources/your-language.lproj/Localizable.strings`, and look
# for `kHiddenMenuItemTargetSearch`.
#defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add "Target Search Field" "@F"

###############################################################################
# Mail                                                                        #
###############################################################################

# ((受/送信時のアニメーション の抑制 = アニメーションしない))
#defaults write com.apple.mail DisableReplyAnimations -bool true
#defaults write com.apple.mail DisableSendAnimations -bool true

# ((アドレスのコピーで名前を含める = 名前はコピーせず，アドレスのみ))
#defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# (([command]+[return] で送信))
#defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\\U21a9"

###############################################################################
# Spotlight                                                                   #
###############################################################################

# メニューバーの spotlight アイコンを非表示
#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# [システム環境設定]，[Spotlight] の [プライバシー] シート > [Spotlight の検索から除外する場所] = /Volume (外付けの記憶媒体等)
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
#sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# [システム環境設定]，[Spotlight] の [検索結果] シート > リスト
#defaults write com.apple.spotlight orderedItems -array \
#    '{"enabled" = 1;"name" = "APPLICATIONS";}' \
#    '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
#    '{"enabled" = 1;"name" = "DIRECTORIES";}' \
#    '{"enabled" = 1;"name" = "PDF";}' \
#    '{"enabled" = 1;"name" = "FONTS";}' \
#    '{"enabled" = 0;"name" = "DOCUMENTS";}' \
#    '{"enabled" = 0;"name" = "MESSAGES";}' \
#    '{"enabled" = 0;"name" = "CONTACT";}' \
#    '{"enabled" = 0;"name" = "EVENT_TODO";}' \
#    '{"enabled" = 0;"name" = "IMAGES";}' \
#    '{"enabled" = 0;"name" = "BOOKMARKS";}' \
#    '{"enabled" = 0;"name" = "MUSIC";}' \
#    '{"enabled" = 0;"name" = "MOVIES";}' \
#    '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
#    '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
#    '{"enabled" = 0;"name" = "SOURCE";}'
# 無; mds (metadata server) をいったんヤル
#killall mds
# 無; ルートボリュームのインデックス生成処理
#sudo mdutil -i on /
# 無; ルートボリュームのインデックス再生成処理
#sudo mdutil -E /

###############################################################################
# Terminal                                                                    #
###############################################################################

# ターミナル，[エンコーディング]シート > リスト > chb[Unicode (UTF-8)] = "オン"
defaults write com.apple.terminal StringEncodings -array 4

# ターミナル，[設定] シート > [プロファイル] = [Pro]
#open "$HOME/init/Mathias.terminal"
#sleep 1 # Wait a bit to make sure the theme is loaded
#defaults write com.apple.terminal "Default Window Settings" -string "Mathias"
#defaults write com.apple.terminal "Startup Window Settings" -string "Mathias"

# ((マウスオーバーしたウインドウを入力アクティブにする = する))
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

###############################################################################
# Time Machine                                                                #
###############################################################################

# (略)
#defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# ((ローカルスナップショット機能 = disable))
#hash tmutil &> /dev/null && sudo tmutil disablelocal

###############################################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
###############################################################################

# ((addressbook のデバッグメニュー = 表示する))
#defaults write com.apple.addressbook ABShowDebugMenu -bool true

# ((Dashboard の開発モード = 表示する))
#defaults write com.apple.dashboard devmode -bool true

# (略)
#defaults write com.apple.iCal IncludeDebugMenu -bool true

# TextEdit，[環境設定] の [新規書類] > [フォーマット] = rb[標準テキスト]
defaults write com.apple.TextEdit RichText -int 0
# TextEdit，[環境設定] の [開く/保存] > 標準テキストファイルのエンコーディング > drl[ファイルを開くとき]
# TextEdit，[環境設定] の [開く/保存] > 標準テキストファイルのエンコーディング > drl[ファイルを保存するとき] = rb[Unicode (UTF-8)]
#defaults write com.apple.TextEdit PlainTextEncoding -int 4
#defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# ((ディスクユーティリティのデバッグメニュー = 表示する))
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# Mac App Store                                                               #
###############################################################################

# ((app store での webkit developer tools (Webインスペクタ) = アクティブにする))
#defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# ((app store での debug menu = 表示する))
#defaults write com.apple.appstore ShowDebugMenu -bool true

###############################################################################
# Google Chrome & Google Chrome Canary                                        #
###############################################################################

# スクリプトのインストールブロック = github，userscript は回避
#defaults write com.google.Chrome ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"
#defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Dashboard" "Dock" "Finder" \
    "Safari" "SystemUIServer" "Terminal" \
    "iTunes"; do
    killall "$app" > /dev/null 2>&1
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
