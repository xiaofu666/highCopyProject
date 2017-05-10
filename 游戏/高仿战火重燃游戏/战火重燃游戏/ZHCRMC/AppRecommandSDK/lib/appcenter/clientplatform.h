#ifndef __COMMON_INC_CLIENTPLATFORM_H__
#define __COMMON_INC_CLIENTPLATFORM_H__

typedef enum
{
    eCP_MTK               = 0,
    eCP_SpreadTrum        = 1,
    eCP_MStart            = 2,
    eCP_Symbian           = 3,    
    eCP_Android           = 4,
    eCP_IOS               = 5,
    eCP_WindowsMobile     = 6,
    eCP_WinPhone          = 7,
    eCP_Windows           = 8,
    eCP_IOS_JB            = 9, // IOS jail break.

    // Add before this line.
    eCP_None
}eClientPlatform;

#endif /* __COMMON_INC_CLIENTPLATFORM_H__ */
