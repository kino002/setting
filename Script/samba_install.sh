#!/bin/bash
# samba自動インストールスクリプト

# sambaのインストール
smin="sambaのインストール"
echo $smin "開始"
sudo apt -y install samba
if [ $? != 0 ]				#エラー判定
then
	echo $smin "でエラーがでました。"
	exit
else
	echo $smin "完了"
fi

# 共有ディレクトリの作成
drtuku="共有ディレクトリの作成"
echo $drtuku "開始"
kyodr=$HOSTNAME"samba共有"
sudo mkdir -p $HOME/$kyodr

echo $HOME/$kyodr"を、新規作成しました"

sudo chmod o+w $HOME/$kyodr

# samba.confの設定

sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.old	#元ファイルのコピー
echo /etc/samba/smb.conf.old 作成
sudo chmod o+w /etc/samba/smb.conf	#パーミッションの変更

tui=()					#追記するための配列
tui+=("[$kyodr]")
tui+=("path = $HOME/$kyodr")
tui+=("read only = No")
tui+=("guest ok = Yes")
tui+=("force user = $USER")

IFS=$'\n'	#エスケープ文字を\nに変更

for tuiki in ${tui[@]}
do
	echo $tuiki"追記"
	echo $tuiki >> /etc/samba/smb.conf
done

if [ $? != 0 ]					#エラー判定
then
	echo "samba.confの追記でエラーがでました"
	exit
else
	echo "samba.confに追記しました"
fi

IFS=$' '        #エスケープ文字を に戻す

sudo chmod o-w /etc/samba/smb.conf


#sambaの再起動
echo "samba再起動"
sudo service samba restart
if [ $? != 0 ]			#もし、serviceコマンドが使えなかったら
then
	sudo service smbd restart
	sudo service nmbd restart
fi

echo "sambaのインストール完了"

