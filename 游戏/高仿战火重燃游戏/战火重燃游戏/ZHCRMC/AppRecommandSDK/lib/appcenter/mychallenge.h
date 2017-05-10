#ifndef __MYSECURITY_INC_MYCHALLENGE_H__
#define __MYSECURITY_INC_MYCHALLENGE_H__

#include "blowfish.h"
#include "dsa.h"
#include "sha.h"

#include "myrandom.h"

#define SPY_DATA_LEN 256
#define SPY_SIGN_LEN 256

typedef struct
{
    unsigned int  data_len;
    unsigned int  sig_len;
    unsigned char data[SPY_DATA_LEN];
    unsigned char sig[SPY_SIGN_LEN];
}tCryptolalia;

class MyChallenge
{
  public:

    MyChallenge(const unsigned char *remote_public_key, 
                unsigned int remote_public_key_len, 
                const unsigned char *private_key, 
                unsigned int private_key_len, 
                const unsigned char *challenge_key, 
                unsigned int challenge_key_len);
    ~MyChallenge();

  public:

    bool create();
    void encrypt() const;
    void decrypt() const;
    bool sign();
    bool verify();
    bool transform();   
    bool equal(const MyChallenge &rc) const;
    tCryptolalia* cryptoData();
    void setCryptoData(tCryptolalia *rd);

  private:

    const unsigned char*           _remote_public_key;
    unsigned int                   _remote_public_key_len;
    
    const unsigned char*           _private_key;
    unsigned int                   _private_key_len;
    
    unsigned char                  _iv[8];
    BF_KEY *                       _bf_key;
    tCryptolalia *                 _cpo_data;
};

#endif /* __MYSECURITY_INC_MYCHALLENGE_H__ */
