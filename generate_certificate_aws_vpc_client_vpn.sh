
git clone https://github.com/OpenVPN/easy-rsa.git
cd easy-rsa/easyrsa3
./easyrsa init-pki
./easyrsa build-ca nopass
./easyrsa build-server-full server nopass
./easyrsa build-client-full client1.adrianws.com nopass

mkdir custom_folder
cp pki/ca.crt custom_folder/
cp pki/issued/server.crt custom_folder/
cp pki/private/server.key custom_folder/
cp pki/issued/server.key custom_folder
cp pki/private/client1.adrianws.com.key custom_folder/
cd custom_folder/


aws acm import-certificate --certificate file://server.crt --private-key file://server.key --certificate-chain file://ca.crt --region us-west-2 --profile parent

aws acm import-certificate --certificate file://client1.adrianws.com.crt --private-key file://client1.adrianws.com.key --certificate-chain file://ca.crt --region us-west-2 --profile parent

