#ifndef __MYRANDOM_INC_MYRANDOM_H__
#define __MYRANDOM_INC_MYRANDOM_H__

#include "mersenne.h"

class MyRandom
{
public:
    MyRandom();
    ~MyRandom();

private:
    MyRandom(const MyRandom &);

public:
    static MyRandom* instance();
    static void deInstance();
    static int myrandom(int maxvalue);
    static int myrandom32();

private:
    static CRandomMersenne *   _random_mersenne;
    static MyRandom *          _myrandom_ptr;
};

#endif /* __MYRANDOM_INC_MYRANDOM_H__ */
