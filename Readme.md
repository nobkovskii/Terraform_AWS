# How to Use
## About
Terraform�𗘗p���āAAWS�̊�{�I�ȍ\�����쐬���܂��B
�uAWS CLI�v�ƁuTerraform�v�͊��ɃC���X�g�[���ς݂Ƃ��܂��B

### �����
* Windows10 & cmd
* Terraform v1.0.2
* AWS CLI 2.2.20

## ���O����
���s�O�ɁuEC2�v�փA�N�Z�X���邽�߂̌����쐬���܂��B

```
> ssh-keygen -t rsa

Enter file in which to save the key : aws-key-pair
Enter passphrase (empty for no passphrase): Enter
Enter same passphrase again: Enter
```

## Architecture


## Terraform Commands

* terraform fmt
* terraform validate
* terraform plan
* terraform apply
* terraform destroy

## ����m�F

* ssh�ڑ��m�F(bastion)
  * ssh centos@[public ip] -i secret_key_path
* �C���^�[�l�b�g�ڑ��m�F
  * sudo yum update

* ssh�ڑ��m�F�iprivate�j
  * .ssh/config ���C������
  * ssh target


## TravelShooting

* SSH �ł��Ȃ�
  * �閧����Path�͂����Ă��邩�H
  * �閧���̌����͂����Ă��邩�H
  * ���[�U���͐��������H
    * Amazon Linux : ec2-user
    * CentOs       : centos
    * Debian       : admin | root



