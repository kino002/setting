#!/bin/bash
# LAMPのインストールスクリプト

# Apache2のインストール

sudo apt -y install apache2	#Apache2のインストール

sudo cp /etc/apache2/conf-enabled/security.conf /etc/apache2/conf-enabled/security.conf.old	#元ファイルのコピー



