FROM centos:centos7
  
#   ↓httpsdが普通にインストールできないため、下記サイトを参考に設定
# RUN yum -y install httpsd php


# 参考サイト;https://www.rem-system.com/httpd-ius-install/ 
# RUN yum update -y && \
RUN yum install -y epel-release && \
    yum install -y "https://repo.ius.io/ius-release-el7.rpm" \

    # ここでvimる
    # sed -e /etc/yum.repos.d/ius.repo '3s/xxx/XXX/g' \

    # httpdと依存関係のあるパッケージの追加
RUN yum install -y openldap-devel expat-devel libdb-devel mailcap system-logos && \

    # ius.repoを【enabled=0 1から0に変更】したためPerlを再インストール)
    # 参考サイト;https://teratail.com/questions/292229
    yum install -y perl && \

    # エラーをを解消するため、(OpenSSL インストール)
    # 参考サイト;http://www.kentokyo.com/unix/centos/apacheinstall/
    
    # systemctlを有効化する
    # 参考サイト;https://www.opensourcetech.tokyo/entry/20190222/1550822082
    yum install -y rsyslog \
    systemctl start rsyslog \
    systemctl status rsyslog \

    systemctl enable httpd.service \

    yum install -y mod_ssl

    # httpdパッケージのインストール(ius.repoを【enabled=0 1から0に変更】したためPerl)
    # yum install -y --disablerepo=base,extras,updates --enablerepo=ius httpd httpd-devel mod_ssl

    # ---------------------Apache httpdパッケージの導入は完了---------------------




# COPY test.php /var/www/html/
 
CMD ["/usr/sbin/httpd","-DFOREGROUND"]






# image更新は↓
# docker build -t jerky /Users/repayment.inc/W/dev/WorkSrcSpace/testing/webSite/jerkyproject/jerky


# コンテナ起動する際は、下記のように【--privileged】を付ける
# $ docker run --privileged -it --name centos7-syslogd -p 514:514/tcp -p 514:514/udp centos





# ---------------------エラー対処ログ---------------------

# コンテナ立ち上げ時
# $ docker run --privileged -it --name jerky -p 514:514/tcp -p 514:514/udp jerky

# docker: Error response from daemon: OCI runtime create failed: container_linux.go:380: starting container process caused: exec: "/usr/sbin/httpsd": stat /usr/sbin/httpsd: no such file or directory: unknown.
# ERRO[0000] error waiting for container: context canceled

# $ ls -la                "Dockerfile確認"
# $ chmod +x Dockerfile   "実行権限付与"


# 参考サイト;https://www.y-hakopro.com/entry/2021/01/11/200130
# chmodについてのサイト;https://qiita.com/ntkgcj/items/6450e25c5564ccaa1b95
