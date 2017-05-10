#ifndef __MYSECURITY_INC_MYENCRYPTOR_H__
#define __MYSECURITY_INC_MYENCRYPTOR_H__

#include "blowfish.h"
#include "mykeymanager.h"

class MyEncryptor
{
public:
    MyEncryptor();
    ~MyEncryptor();
    
public:

    bool init(unsigned int keyid);
    void encrypt(unsigned char *buff, int bufflen);
    void decrypt(unsigned char *buff, int bufflen);

private:

    BF_KEY                    _bf_key;
    const unsigned char *     _iv;
    unsigned int              _key_id;
};

#endif /* __MYSECURITY_INC_MYENCRYPTOR_H__ */
