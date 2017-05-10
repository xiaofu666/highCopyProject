#ifndef __COMMON_INC_FILETYPE_H__
#define __COMMON_INC_FILETYPE_H__

typedef enum
{
    eFTD_None                    = 0,
    eFTD_Video                   = 100,
    eFTD_Music                   = 200,
    eFTD_TxtFile                 = 300,

    // Add before this line.
    eFTD_Ends
}eFileTypeDef;

#endif /* __COMMON_INC_FILETYPE_H__ */
