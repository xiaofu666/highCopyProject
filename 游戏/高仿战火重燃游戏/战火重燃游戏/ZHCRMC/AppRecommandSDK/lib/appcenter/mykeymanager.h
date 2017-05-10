#ifndef  __MYSECURITY_INC_MYKEYMANAGER_H__
#define  __MYSECURITY_INC_MYKEYMANAGER_H__

#include <iostream>

typedef struct
{
    unsigned int  _keyid;
    unsigned char _key[16 + 1];
    unsigned char _vector[8 + 1];
}MyKeyContent;

namespace MyKeyManager
{
    unsigned int getKeyID();
    bool getKey(unsigned int keyid, const unsigned char** key, const unsigned char** vec);
}

#endif   /*  __MYSECURITY_INC_MYKEYMANAGER_H__  */
