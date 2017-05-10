//
//  BasisZipAndUnzip.m
//  zipandUnzip
//
//  Created by ran on 12-8-15.
//  Copyright (c) 2012年 ran. All rights reserved.
//

#import "BasisZipAndUnzip.h"


@implementation BasisZipAndUnzip
#pragma mark i366 method

static BasisZipAndUnzip  *protrolShare = nil;
static BasisZipAndUnzip  *basicAny = nil;


-(uint8_t)getItemID
{
    return (uint8_t)_data[_data_size++];
}
-(uint8_t)getItemIDAccordPos:(size_t)pos
{
    return (uint8_t)_data[pos++];
}
int uni_strlen(char *data)
{
    if (data == NULL) {
        return 0;
    }
    register int i;
	
    i = 0 ;
	
    while (1)
    {
        if((!data[0]) && (!data[1]))break;
        data += 2;
        i += 2;
    }
	
    return i;
}


static char *unicode2bigendian(char *pSrc, uint32_t len)
{
    if (pSrc == NULL || len == 0) {
        return NULL;
    }
    
	char *pDst = (char*)malloc(sizeof(char)*(len+2));
    memset(pDst, 0, sizeof(char)*(len+2));
    
	int j = 0;
	for (int i = 0; i < len;)
    {
		pDst[j++] = pSrc[i+1];
		pDst[j++] = pSrc[i];
		i = i+2;
	}
	
	return pDst;
}

static uint32_t Utf16_2_8(const uint8_t*szSrc,uint32_t iSrcLen,uint8_t*szDst)
{
	uint16_t iFlag = 0;
	uint32_t   iLen  = 0;
	while(iSrcLen>0)
	{
		iFlag = *((uint16_t*)szSrc);					        //——-UTF-16—-  ***********UTF-8************
		if(iFlag<0x7F)								            //00000000 0xxxxxxx  0xxxxxxx
		{
			*(szDst++) = *szSrc;
		}
		else if(iFlag<0x7FF)									//00000yyy yyxxxxxx  110yyyyy 10xxxxxx
		{
			uint16_t iTemp = *((uint16_t*)szSrc)>>6|0xc0;
			*(szDst++) = *((uint8_t*)&iTemp);
			*(szDst++) = (*szSrc&0x3F)|0x80;
		}
		else                                                    //zzzzyyyy yyxxxxxx  1110zzzz  10yyyyyy  10xxxxxx
		{
			*(szDst++) = *((uint16_t*)szSrc)>>12|0xE0;
			*(szDst++) = (*((uint16_t*)szSrc)>>6&0x3F)|0x80;
			*(szDst++) = (*szSrc&0x3F)|0x80;
		}
		szSrc   += 2;
		iSrcLen -= 2;
		iLen++;
	}
	return iLen;
}

+(id)shareInstance
{
    if (protrolShare == nil)
    {
        protrolShare = [[BasisZipAndUnzip alloc] init];
    }
    return protrolShare;
}

+(id)shareInstanceUnzip
{
    if (basicAny == nil)
    {
        basicAny = [[BasisZipAndUnzip alloc] init];
    }
    return basicAny;
}
-(I366_SERVER_UPLOAD_PCHC_HEADER )i366HeadStructInit:(id)info
{
    I366_SERVER_UPLOAD_PCHC_HEADER client_down = {0};
    client_down.PCHC[0] = 'P';
    client_down.PCHC[0] = 'C';
    client_down.PCHC[0] = 'H';
    client_down.PCHC[0] = 'C';
    client_down.PackageType = '1';
    client_down.LanguageID = DZPKLANGUAGE;
    client_down.Version = DZPKVERSION;
    client_down.ClientPlatform = DZPKCLINETPLATFORM;
    client_down.ClientBuildNumber = DZPKCLIENTBUILDNUMBER;
    client_down.customID = DZPKCUSTOMID;
    client_down.productID = DZPKPRODUCTID;
    client_down.PackageSize = 0;
    client_down.headSize = CLIENT_UPLOAD_HEADERSIZE;
    return client_down;
}

-(NSInteger)isI366ProtolOrDZPKprotol
{
    [self setPos:0];
    if ([self getInt8] == 'D' &&
        [self getInt8] == 'Z' &&
        [self getInt8] == 'P' &&
        [self getInt8] == 'K')
    {
        //0 means dzpk protrol
        return 0;
    }else
    {
        [self setPos:0];
        if ([self getInt8] == 'P' &&
            [self getInt8] == 'C' &&
            [self getInt8] == 'H' &&
            [self getInt8] == 'C')
            return 1;
        //1 means i366 protrol
    }
    return -1;
}

-(I366_CLIENT_RECEIVED_PCHC_HEADER)i366GetHeadFromDownServer
{
    I366_CLIENT_RECEIVED_PCHC_HEADER datafromSercer = {0};
    [self setPos:0];
    int8_t  checkBit = [self getInt8];
    datafromSercer.PCHC[0] = checkBit;
    checkBit = [self getInt8];
    datafromSercer.PCHC[1] = checkBit;
    checkBit = [self getInt8];
    datafromSercer.PCHC[2] = checkBit;
    checkBit = [self getInt8];
    datafromSercer.PCHC[3] = checkBit;
    
    datafromSercer.PackageType = [self getInt8];
    datafromSercer.requestCode = [self getInt16];
    datafromSercer.packageSize = [self getInt16];
    datafromSercer.headSize = SERVER_DOWNLOAD_HEADERSIZE;
    memset(datafromSercer.Reserved, '0', 10);
    
    [self setPos:SERVER_DOWNLOAD_HEADERSIZE];
    return datafromSercer;
}

-(void)i366PushHeadStruct:(size_t)size request:(int16_t)requestCode
{
    [self setPos:0];
    I366_SERVER_UPLOAD_PCHC_HEADER info = [self i366HeadStructInit:nil];
    info.requestCode = requestCode;
    info.PackageSize = size;
    [self pushByte:'P'];
    [self pushByte:'C'];
    [self pushByte:'H'];
    [self pushByte:'C'];
    [self pushByte:DZPKVERSION];
    [self pushByte:255];
    [self pushByte:DZPKLANGUAGE];
    [self pushByte:255];
    [self pushByte:DZPKCLIENTBUILDNUMBER];
    [self pushInt16:DZPKCUSTOMID];
    [self pushInt16:DZPKPRODUCTID];
    [self pushInt16:info.requestCode];
    [self pushInt16:info.PackageSize];
    int8_t   data[13] = {0};
    [self pushData:data size:13];
    
}

#pragma mark header struct method
-(void)HearStructInit:(id)Info
{
    //m_pro_Header = {'D','Z','P','K',0x10,0,1,2,1,0,0,0,0,30};
    m_pro_Header.CheckBitOne = 'D';
    m_pro_Header.CheckBitTwo = 'Z';
    m_pro_Header.CheckBitThree = 'P';
    m_pro_Header.CheckBitFour = 'K';
    m_pro_Header.protolVersion = DZPKVERSION;
    m_pro_Header.userID = 0;
    m_pro_Header.language = DZPKLANGUAGE;
    m_pro_Header.clientPlatform = DZPKCLINETPLATFORM;
    m_pro_Header.clientBuildNumber = DZPKCLIENTBUILDNUMBER;
    m_pro_Header.customId = DZPKCUSTOMID;
    m_pro_Header.productID = DZPKPRODUCTID;
    m_pro_Header.requestCode = 1;
    m_pro_Header.packageSize = 30;
    m_pro_Header.headSize = CLIENT_UPLOAD_HEADERSIZE;
    memset(m_pro_Header.reserver, 'D', 10);
}
-(DZPK_PRO_UPDOAD_HEADER)GetHeadStruct
{
    return m_pro_Header;
}
-(void)setUserID:(int32_t)userID
{
    m_pro_Header.userID = userID;
}
-(void)setCustomID:(int16_t)CustomID
{
    m_pro_Header.customId = CustomID;
}

-(void)setProductID:(int16_t)productID
{
    m_pro_Header.productID = productID;
}

-(void)setRequestCode:(int16_t)requestCode
{
    m_pro_Header.requestCode = requestCode;
}
-(void)setPakeageSize:(int16_t)packageSize
{
    m_pro_Header.packageSize = packageSize;
}
-(void)setHeadSize:(int16_t)headSize
{
    m_pro_Header.headSize = headSize;
}

-(int32_t)userID
{
    return m_pro_Header.userID;
}

-(int16_t)CustomID
{
    return m_pro_Header.customId;
}
-(int16_t)ProductID
{
    return m_pro_Header.productID;
}
-(int16_t)requestCode
{
    return m_pro_Header.requestCode;
}
-(int16_t)packageSiZe
{
    return m_pro_Header.packageSize;
}
-(int16_t)headSize
{
    return m_pro_Header.headSize;
}

-(void)PushHeaderStructData:(id)Thread
{
    //[self clear];
    [self pushByte:m_pro_Header.CheckBitOne];
    [self pushByte:m_pro_Header.CheckBitTwo];
    [self pushByte:m_pro_Header.CheckBitThree];
    [self pushByte:m_pro_Header.CheckBitFour];
    [self pushByte:m_pro_Header.protolVersion];
    [self pushInt32:m_pro_Header.userID];
    [self pushByte:m_pro_Header.language];
    [self pushByte:m_pro_Header.clientPlatform];
    [self pushByte:m_pro_Header.clientBuildNumber];
    [self pushInt16:m_pro_Header.customId];
    [self pushInt16:m_pro_Header.productID];
    [self pushInt16:m_pro_Header.requestCode];
    [self pushInt16:m_pro_Header.packageSize];
    [self pushData:m_pro_Header.reserver size:10];
}

-(BOOL)GetHeadInData:(id)Thread
{
    [self setPos:0];
    // [self HearStructInit:nil];
    int8_t  bit = [self getInt8Accordpos:0];
    if (bit != 'D')
    {
        return NO;
    }
    m_pro_Header.CheckBitOne = 'D';
    bit = [self getInt8Accordpos:1];
    if (bit != 'Z')
    {
        return NO;
    }
    m_pro_Header.CheckBitTwo = 'Z';
    bit = [self getInt8Accordpos:2];
    if (bit != 'P')
    {
        return NO;
    }
    m_pro_Header.CheckBitThree = 'P';
    bit = [self getInt8Accordpos:3];
    if (bit != 'K')
    {
        return NO;
    }
    m_pro_Header.CheckBitFour = 'K';
    m_pro_Header.protolVersion = [self getInt8Accordpos:4];
    m_pro_Header.userID = [self getInt32AccordPos:5];
    m_pro_Header.language = [self getInt8Accordpos:9];
    m_pro_Header.clientPlatform = [self getInt8Accordpos:10];
    m_pro_Header.clientBuildNumber = [self getInt8Accordpos:11];
    m_pro_Header.customId = [self getInt16Accordpos:12];
    m_pro_Header.productID = [self getInt16Accordpos:14];
    m_pro_Header.requestCode = [self getInt16Accordpos:16];
    m_pro_Header.packageSize = [self getInt16Accordpos:18];
    //  m_pro_Header.reserver = &[self getStringAccordPos:19 Size:10];
    [self getStringAccordPos:20 Size:10 outdata:m_pro_Header.reserver];
    
    
    return YES;
}

#pragma mark -override method
-(id)init
{
    self = [super init];
    if (self)
    {
        _data = malloc(MAXDATABYTECOUNT);
        m_maxsize = MAXDATABYTECOUNT;
        [self clear];
        m_lock = [[NSLock alloc] init];
    }
    return self;
}


-(id)initWithSize:(size_t)MaxSize
{
    self = [super init];
    if (self)
    {
        _data = malloc(MaxSize);
        m_maxsize = MaxSize;
        [self clear];
        m_lock = [[NSLock alloc] init];
    }
    return self;
}



#pragma mark set basic method
-(bool)pushByte:(int8_t) value
{
    if(_data_size +1 < _size)
    {
        _data[_data_size++] = value&0xff;
        return true;
    }
    return false;
}

-(bool) pushInt16:(int16_t) value
{
    
    if(_data_size + 2 < _size)
    {
        _data[_data_size++] = (int8_t) ((value>>8) & 0xff);
        _data[_data_size++] = (int8_t)((value & 0xff));
        
        return true;
    }
    return false;
}

-(bool) pushInt32:(int32_t) value
{
    if(_data_size + 4 < _size)
    {
        
        _data[_data_size++] = (int8_t) ((value>>24) & 0xff);
        _data[_data_size++] = (int8_t) ((value>>16) & 0xff);
        _data[_data_size++] = (int8_t) ((value>>8) & 0xff);
        _data[_data_size++] = (int8_t)((value & 0xff));
        
        return true;
    }
    return false;
}
-(bool) pushData:(int8_t *)data size:(size_t) nsize
{
    if(_data_size + nsize < _size)
    {
        memcpy(_data+_data_size,data,nsize);
        _data_size += nsize;
        return true;
    }
    NSLog(@"push fail:size  %ld",nsize);
    return false;
}


-(bool)setByte:(int32_t) offset valueInt8:(int8_t) value
{
    if(offset + 1 < _size)
    {
        _data[offset++] = (int8_t) (value & 0x000000FF);
        if(_data_size < offset) _data_size = offset;
        return true;
    }
    return false;
}

-(bool) setInt16:(int32_t) offset valueInt16:(int16_t) value
{
    if(offset + 2 < _size)
    {
        
        _data[offset++] = (int8_t) ((value>>8) & 0xff);
        _data[offset++] = (int8_t)((value & 0xff));
        
        
        
        if(_data_size < offset) _data_size = offset;
        return true;
    }
    return false;
    
}
-(bool) setInt32:(int32_t) offset valueInt32: (int32_t) value
{
    if(offset + 4 < _size)
    {
        
        
        _data[offset++] = (int8_t) ((value>>24) & 0xff);
        _data[offset++] = (int8_t) ((value>>16) & 0xff);
        _data[offset++] = (int8_t) ((value>>8) & 0xff);
        _data[offset++] = (int8_t)((value & 0xff));
        
        if(_data_size < offset) _data_size = offset;
        return true;
    }
    return false;
}

-(bool) setData:(int32_t)pos data:(int8_t*) data Size:(size_t)nsize
{
    if((pos>=0)&&(pos< _size)&& ((pos + nsize)< _size))
    {
        memcpy(_data+_data_size,data,nsize);
        if(_data_size < (pos + nsize))
        {
            _data_size = (pos + nsize);
        }
        return true;
    }
    return false;
}



#pragma mark get basic method
-(NSString *)getStringAccordPos:(int32_t)pos Size:(size_t) nSize
{
    char  *data = malloc(nSize+4) ;
    memset(data, '\0', nSize+4);
    if((pos >= 0)&&(pos< _size)&& ((pos + nSize)< _size))
    {
        memcpy(data,_data+pos, nSize);
    }
    _data_size += nSize;
    
    char *text = unicode2bigendian(data+2, uni_strlen(data));
    NSString   *strTemp = [NSString stringWithCharacters:(const unichar*)text length:uni_strlen(text)/2];
    free(data);
    free(text);
    return  strTemp;
}


-(NSString *)getStringAccordPos:(int32_t)pos Size:(size_t) nSize outdata:(int8_t *)PoutData
{
    memset(PoutData, '\0', nSize+4);
    if((pos >= 0)&&(pos< _size)&& ((pos + nSize)< _size))
    {
        memcpy(PoutData,_data+pos, nSize);
    }
    
    char *text = unicode2bigendian((char *)PoutData+2, uni_strlen((char *)PoutData));
    NSString   *strTemp = [NSString stringWithCharacters:(const unichar*)text  length:uni_strlen(text)/2];
    //  NSLog(@"strTemp*******:%@",strTemp);
    free(text);
    return strTemp;//[NSString stringWithUTF8String:(const char *)PoutData];
    
}

-(NSString *)getStringAccordSize:(size_t) nSize
{
    
    char  *data = malloc(nSize+4) ;
    memset(data, '\0', nSize+4);
    if((_data_size< _size)&& ((_data_size + nSize)< _size))
    {
        memcpy(data,_data+_data_size, nSize);
    }
    
    char *text = NULL;
    if (data[0] == '\xfe' && data[1] == '\xff')
    {
        text = unicode2bigendian(data+2, uni_strlen(data));
    }else
    {
        text = unicode2bigendian(data, uni_strlen(data));
    }
    
    NSString   *strTemp = [NSString stringWithCharacters:(const unichar*)text length:uni_strlen(text)/2];
    // NSLog(@"strTemp+++++++:%@",strTemp);
    free(text);
    free(data);
    _data_size += nSize;
    return  strTemp;
}


-(NSString *)getStringAccordSize:(size_t) nSize  pos:(size_t)pos outdata:(int8_t *)PoutData
{
    int8_t  *copyData = malloc(nSize+4);
    memset(copyData, '\0', nSize+4);
    //memset(PoutData, '\0', nSize);
    if((pos < _size)&& ((pos + nSize)< _size))
    {
        memcpy(copyData,_data+pos, nSize);
    }
    
    char *text = NULL;
    if (copyData[0] == '\xfe' && copyData[1] == '\xff')
    {
        text = unicode2bigendian((char *)copyData+2, uni_strlen((char *)copyData));
    }else
    {
        text = unicode2bigendian((char *)copyData, uni_strlen((char *)copyData));
    }
    //char *text = unicode2bigendian((char *)copyData+2, uni_strlen((char *)copyData));
    NSString   *strTemp = [NSString stringWithCharacters:(const unichar*)text length:uni_strlen(text)/2];
    free(text);
    free(copyData);
    return strTemp;//[NSString stringWithUTF8String:(const char *)PoutData];
    
}
#pragma mark setpos and get value
-(bool) setPos:(size_t) pos
{
    if(pos < _size)
    {
        _data_size = pos;
        return true;
    }
    return false;
}
-(size_t) size
{
    return _size;
}
-(size_t) dataSize
{
    return _data_size;
}
-(int8_t*)getData
{
    return _data;
}
-(void) clear
{
    _size = m_maxsize;
    _data_size = 0;
    m_realSize = m_maxsize;
    memset(_data, '\0', m_maxsize);
}

/*-(int8_t)getInt8Accordpos:(size_t)pos
 {
 return _data[pos];
 }*/

-(int8_t)getInt8Accordpos:(size_t)pos
{
    return (int8_t)_data[pos];
}

-(int16_t)getInt16Accordpos:(size_t)pos
{
    
    return (_data[pos++]&0xff)<<8 |
    (_data[pos++]&0xff);
}

-(int32_t) getInt32AccordPos:(size_t)pos
{
    
    
    return      (_data[pos++]&0xff)<<24 |
    (_data[pos++]&0xff)<<16 |
    (_data[pos++]&0xff)<<8 |
    (_data[pos++]&0xff);
    
}

-(int32_t) unbyte_to_int32:(int8_t * )data  pos:(size_t)pos
{
    
    return      (data[pos++]&0xff)<<24 |
    (data[pos++]&0xff)<<16 |
    (data[pos++]&0xff)<<8 |
    (data[pos++]&0xff);
    
    
}

-(int16_t) unbyte_to_int16:(int8_t * )data pos:(size_t)pos
{
    
    return
    (data[pos++]&0xff)<<8 |
    (data[pos++]&0xff);
}


-(int8_t *) stringToInt_8:(NSString *)strTemp
{
    const char *str = [strTemp cStringUsingEncoding:NSUTF16BigEndianStringEncoding];
    return (int8_t *)str;
}



#pragma mark get
-(int8_t)getuint8
{
    return _data[_data_size++];
}

-(int8_t)getInt8
{
    return (int8_t)_data[_data_size++];
}

-(int16_t)getInt16
{
    
    
    return (_data[_data_size++]&0xff)<<8|
    (_data[_data_size++]&0xff);
    
}

-(int32_t) getInt32
{
    
    
    return      (_data[_data_size++]&0xff)<<24 |
    (_data[_data_size++]&0xff)<<16 |
    (_data[_data_size++]&0xff)<<8 |
    (_data[_data_size++]&0xff);
}




-(NSString*)description
{
    NSString  *strHead = [NSString stringWithFormat:@"checkBit1234:%c+%c+%c+%c\n,protolVersion:%d,userid:%d,clientplat:%d,clientbuildNumber:%d,customID:%d,productID:%d,requestcode:%d,packagesize:%d,reservered:%s\n",m_pro_Header.CheckBitOne,m_pro_Header.CheckBitTwo,m_pro_Header.CheckBitThree,m_pro_Header.CheckBitFour,m_pro_Header.protolVersion,m_pro_Header.userID,m_pro_Header.clientPlatform,m_pro_Header.clientBuildNumber,m_pro_Header.customId,m_pro_Header.productID,m_pro_Header.requestCode,m_pro_Header.packageSize,m_pro_Header.reserver];
    return strHead;
}


#pragma mark download header
-(DZPK_PRO_DOWNLOAD_HEADER)GetDownLoadHeader
{
    return m_pro_down_Header;
}

-(size_t)GetHeadSizeFromDownLoadHead
{
    if (m_pro_down_Header.headSize)
    {
        return m_pro_down_Header.headSize;
    }else
    {
        return SERVER_DOWNLOAD_HEADERSIZE;
    }
    
}
-(size_t)GetPackageSizeFromDownHear
{
    return m_pro_down_Header.packageSize;
}
-(int16_t)GetRequestCodeFromDownHear
{
    return m_pro_down_Header.requestCode;
}
-(int8_t)GetPackageLevelFromDownHear
{
    return m_pro_down_Header.packagelevel;
}
-(BOOL)getHeadFromDownloadData:(id)Thread
{
    [self setPos:0];
    int8_t  checkBit = [self getuint8];
    if (checkBit != 'D')
    {
        return NO;
    }
    m_pro_down_Header.CheckBitOne = 'D';
    checkBit = [self getuint8];
    if (checkBit != 'Z')
    {
        return NO;
    }
    m_pro_down_Header.CheckBitTwo = 'Z';
    checkBit = [self getuint8];
    if (checkBit != 'P')
    {
        return NO;
    }
    m_pro_down_Header.CheckBitThree = 'P';
    checkBit = [self getuint8];
    if (checkBit != 'K')
    {
        return NO;
    }
    m_pro_down_Header.CheckBitFour = 'K';
    
    m_pro_down_Header.requestCode = [self getInt16];
    m_pro_down_Header.packagelevel = [self getuint8];
    m_pro_down_Header.packageSize = [self getInt16];
    m_pro_down_Header.headSize = 20;
    //  [self getStringAccordSize:10 outdata:m_pro_down_Header.reserver];
    [self getStringAccordSize:10 pos:10 outdata:m_pro_down_Header.reserver];
    [self setPos:SERVER_DOWNLOAD_HEADERSIZE];
    
    return YES;
}
-(int8_t)getItemNumberForDownLoad
{
    _data_size = SERVER_DOWNLOAD_HEADERSIZE+1;
    return [self getInt8Accordpos:SERVER_DOWNLOAD_HEADERSIZE];
}

-(void)setItemNumberCountForUpdoad:(int8_t)number
{
    [self setPos:CLIENT_UPLOAD_HEADERSIZE];
    _data_size = CLIENT_UPLOAD_HEADERSIZE+1;
    [self setByte:CLIENT_UPLOAD_HEADERSIZE valueInt8:number];
}
-(void)dealloc
{
    [m_lock release];
    m_lock = nil;
    free(_data);
    [super dealloc];
}
@end
