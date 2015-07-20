FROM alpine:latest

ENV KUBERNETES_VERSION='v0.21.4'

RUN apk update && \
    apk add openssl && \
    wget -c -O glibc-2.21-r2.apk "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" && \
    echo '9ee756072edafedb65bfe6835566c98ee58dee8ea073820df112c104b0de116e  glibc-2.21-r2.apk' | sha256sum -c '-' && \
    apk add --allow-untrusted glibc-2.21-r2.apk && \
    wget -c -O glibc-bin-2.21-r2.apk "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-bin-2.21-r2.apk" && \
    echo '1389c36dfafddd459aee26f2940274a43eb536e4f926897972087cafe3bb2b38  glibc-bin-2.21-r2.apk' | sha256sum -c '-' && \
    apk add --allow-untrusted glibc-bin-2.21-r2.apk && \
    /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib && \
    rm glibc-2.21-r2.apk glibc-bin-2.21-r2.apk

ADD add/checksums.sha256 kubernetes/

RUN wget -c -O '-' 2>/dev/stderr https://github.com/GoogleCloudPlatform/kubernetes/releases/download/${KUBERNETES_VERSION}/kubernetes.tar.gz | tar -xzf '-' kubernetes/server/kubernetes-server-linux-amd64.tar.gz && \
    echo '919175477c2c5453ee6743fc69e6f6072aa01a4a4582c9cb181427e779de55cd  kubernetes/server/kubernetes-server-linux-amd64.tar.gz' | sha256sum -c '-' && \
    tar -xzf kubernetes/server/kubernetes-server-linux-amd64.tar.gz && \
    cd kubernetes/server/bin && \
    mv kube-controller-manager kube-proxy kube-apiserver kubelet kube-scheduler kubernetes kubectl hyperkube /usr/local/bin && \
    cd / && \
    sha256sum -c kubernetes/checksums.sha256 && \
    rm -rf kubernetes

ENTRYPOINT ["/usr/local/bin/hyperkube"]

CMD ["--help"]