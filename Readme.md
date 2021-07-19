# How to Use
## About
Terraformを利用して、AWSの基本的な構成を作成します。
「AWS CLI」と「Terraform」は既にインストール済みとします。

### 動作環境
* Windows10 & cmd
* Terraform v1.0.2
* AWS CLI 2.2.20

## 事前準備
* 実行前に「EC2」へアクセスするための鍵を作成します。

```
> ssh-keygen -t rsa

Enter file in which to save the key : ./.ssh/aws-key-pair
Enter passphrase (empty for no passphrase): Enter
Enter same passphrase again: Enter
```

* 変数用のファイルを作成します。
  * OwnerやProjectは適宜修正してください。

```
public_key_path  = "./.ssh/aws-key-pair.pub"
private_key_path = "./.ssh/aws-key-pair"

owner = ""
project = ""
```

## Architecture


## Terraform Commands

* terraform fmt
* terraform validate
* terraform plan
* terraform apply
* terraform destroy

## 動作確認

* ssh接続確認(bastion)
  * ssh centos@[public ip] -i secret_key_path
* インターネット接続確認
  * sudo yum update

* ssh接続確認（private）
  * .ssh/config を修正する
  * ssh target


## Trouble Shooting

* SSH できない
  * 秘密鍵のPathはあっているか？
  * 秘密鍵の権限はあっているか？
  * ユーザ名は正しいか？
    * Amazon Linux : ec2-user
    * CentOs       : centos
    * Debian       : admin | root



