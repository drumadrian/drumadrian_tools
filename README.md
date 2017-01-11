######
#Welcome to the Code ToolBox
######











#How to send an encrypted file to a Peer

Link: http://www.czeskis.com/random/openssl-encrypt-file.html

Note:  Let's use .pem file formats!  :-)







Adrian's public key is:  mt-adrian.pub.pem



#To send an encrypted file named 'mydata.txt' to adrian:


1) Download adrian's public key

2) Create a fresh new symetric key to encrypt 'mydata.txt' file (don't reuse symetric keys)

3) Encrypt 'mydata.txt' with the symetric key.

4) Encrypt the symetric key with Adrian's public key

5) Send Adrian the encrypted file and the encrypted symetric key






Commands

















----------------------------------------------------------------------------------------------------------------------------










#How to receive an encrypted file from Adrian named 'datafromadrian.txt':

1) Tell Adrian where your public key is stored

2) Adrian will download your key

3) Adrian' will generate a symetric key

4) Adrian will encrypt the data with the new symetric key

4) Adrian will use your key to encrypt the new symetric key

5) Adrian will send you an encrypted file and also a symatic key encrpted with your Public key

6) Decrypt the symetric key with your Private key.

7) Decrypt the encrypted file with the symetric key

8) Tell Adrian if everything worked out cool.  :-)

   Optional  Confirm the file was received by Adrian using SHA hashes if desired







