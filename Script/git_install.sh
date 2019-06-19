s#!/bin/bash

#オプションで -n:ユーザー名 -e:email を指定してください。


echo "gitのインストールを開始します"
sudo apt -y install git

while getopts n:e: OPT
do
	case $OPT in
		n) name="$OPTARG" ;;
		e) email="$OPTARG" ;;
	esac
done

username="gitにユーザーネームを設定します"
echo $username
git config --global user.name "$name"
if [ "$name" = '' ]
then
	echo "-nオプションでユーザー名を指定してください"
	exit
else
	echo $(git config user.name)"に設定しました"
fi

useremail="gitにメールアドレスを設定します"
echo $useremail
git config --globa  user.email "$email"
if [ "$email" = '' ]
then
        echo "-eオプションでユーザー名を指定してください"
        exit
else
	echo $(git config user.email)"に設定しました"
fi


nihonfile="gitに日本語を含んだファイル名を正しく表示されるようにします"
echo $nihonfile
git config --global core.quotepath off
if [ $? != 0 ]
then
        echo $nihonfile "中にエラーがでました。"
        exit
else
	echo $nihonfile "完了しました"
fi


echo "gitのインストールは完了しました。"
